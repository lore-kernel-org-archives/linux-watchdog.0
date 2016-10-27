Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.data-modul.de ([212.184.205.171]:49826 "EHLO
        mail2.data-modul.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935161AbcJ0N6C (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Oct 2016 09:58:02 -0400
From: Zahari Doychev <zahari.doychev@linux.com>
To: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        lee.jones@linaro.org, wsa@the-dreams.de, linus.walleij@linaro.org,
        wim@iguana.be, linux@roeck-us.net
Cc: linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        gnurou@gmail.com, linux-watchdog@vger.kernel.org,
        Zahari Doychev <zahari.doychev@linux.com>
Subject: [RFC PATCH 3/5] gpio-dmec: gpio support for dmec
Date: Thu, 27 Oct 2016 12:47:14 +0200
Message-Id: <fe8ac70204de48edd8a3da8a783b10810f3d4ca1.1477564996.git-series.zahari.doychev@linux.com>
In-Reply-To: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
References: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
In-Reply-To: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
References: <cover.42dd8126f6e33b5130d9afa4596d88a106c54188.1477564996.git-series.zahari.doychev@linux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is support for the gpio functionality found on the Data Modul embedded
controllers

Signed-off-by: Zahari Doychev <zahari.doychev@linux.com>
---
 drivers/staging/dmec/Kconfig     |  10 +-
 drivers/staging/dmec/Makefile    |   1 +-
 drivers/staging/dmec/dmec.h      |   5 +-
 drivers/staging/dmec/gpio-dmec.c | 390 ++++++++++++++++++++++++++++++++-
 4 files changed, 406 insertions(+), 0 deletions(-)
 create mode 100644 drivers/staging/dmec/gpio-dmec.c

diff --git a/drivers/staging/dmec/Kconfig b/drivers/staging/dmec/Kconfig
index 0067b0b..9c4a8e5 100644
--- a/drivers/staging/dmec/Kconfig
+++ b/drivers/staging/dmec/Kconfig
@@ -17,3 +17,13 @@ config I2C_DMEC
 
 	  To compile this driver as a module, say M here: the module will be
           called i2c-dmec
+
+config GPIO_DMEC
+	tristate "Data Modul GPIO"
+	depends on MFD_DMEC && GPIOLIB
+	help
+	  Say Y here to enable support for a GPIOs on a Data Module embedded
+	  controller.
+
+	  To compile this driver as a module, say M here: the module will be
+          called gpio-dmec
diff --git a/drivers/staging/dmec/Makefile b/drivers/staging/dmec/Makefile
index c51a37e..b71b27b 100644
--- a/drivers/staging/dmec/Makefile
+++ b/drivers/staging/dmec/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MFD_DMEC)		+= dmec-core.o
 obj-$(CONFIG_I2C_DMEC)		+= i2c-dmec.o
+obj-$(CONFIG_GPIO_DMEC) 	+= gpio-dmec.o
diff --git a/drivers/staging/dmec/dmec.h b/drivers/staging/dmec/dmec.h
index 178937d..cc42926 100644
--- a/drivers/staging/dmec/dmec.h
+++ b/drivers/staging/dmec/dmec.h
@@ -1,6 +1,11 @@
 #ifndef _LINUX_MFD_DMEC_H
 #define _LINUX_MFD_DMEC_H
 
+struct dmec_gpio_platform_data {
+	int gpio_base;
+	int chip_num;
+};
+
 struct dmec_i2c_platform_data {
 	u32 reg_shift; /* register offset shift value */
 	u32 reg_io_width; /* register io read/write width */
diff --git a/drivers/staging/dmec/gpio-dmec.c b/drivers/staging/dmec/gpio-dmec.c
new file mode 100644
index 0000000..4cefbbf
--- /dev/null
+++ b/drivers/staging/dmec/gpio-dmec.c
@@ -0,0 +1,390 @@
+/*
+ * GPIO driver for Data Modul AG Embedded Controller
+ *
+ * Copyright (C) 2016 Data Modul AG
+ *
+ * Authors: Zahari Doychev <zahari.doychev@linux.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/gpio.h>
+#include <linux/seq_file.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/spinlock.h>
+
+#include "dmec.h"
+
+#define DMEC_GPIO_BANKS			2
+#define DMEC_GPIO_MAX_NUM		8
+#define DMEC_GPIO_BASE(x)		(0x40 + 0x10 * ((x)->chip_num))
+#define DMEC_GPIO_SET_OFFSET(x)		(DMEC_GPIO_BASE(x) + 0x1)
+#define DMEC_GPIO_GET_OFFSET(x)		(DMEC_GPIO_BASE(x) + 0x1)
+#define DMEC_GPIO_CLR_OFFSET(x)		(DMEC_GPIO_BASE(x) + 0x2)
+#define DMEC_GPIO_VER_OFFSET(x)		(DMEC_GPIO_BASE(x) + 0x2)
+#define DMEC_GPIO_DIR_OFFSET(x)		(DMEC_GPIO_BASE(x) + 0x3)
+#define DMEC_GPIO_IRQTYPE_OFFSET(x)	(DMEC_GPIO_BASE(x) + 0x4)
+#define DMEC_GPIO_EVTSTA_OFFSET(x)	(DMEC_GPIO_BASE(x) + 0x6)
+#define DMEC_GPIO_IRQCFG_OFFSET(x)	(DMEC_GPIO_BASE(x) + 0x8)
+#define DMEC_GPIO_NOPS_OFFSET(x)	(DMEC_GPIO_BASE(x) + 0xa)
+#define DMEC_GPIO_IRQSTA_OFFSET(x)	(DMEC_GPIO_BASE(x) + 0xb)
+
+#ifdef CONFIG_PM
+struct dmec_reg_ctx {
+	u32 dat;
+	u32 dir;
+	u32 imask;
+	u32 icfg[2];
+	u32 emask[2];
+};
+#endif
+
+struct dmec_gpio_priv {
+	struct regmap *regmap;
+	struct gpio_chip gpio_chip;
+	struct irq_chip irq_chip;
+	unsigned int chip_num;
+	unsigned int irq;
+	u8 ver;
+#ifdef CONFIG_PM
+	struct dmec_reg_ctx regs;
+#endif
+};
+
+static int dmec_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
+						   gpio_chip);
+	struct regmap *regmap = priv->regmap;
+	unsigned int val;
+
+	/* read get register */
+	regmap_read(regmap, DMEC_GPIO_GET_OFFSET(priv), &val);
+
+	return !!(val & BIT(offset));
+}
+
+static void dmec_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
+						   gpio_chip);
+	struct regmap *regmap = priv->regmap;
+
+	if (value)
+		regmap_write(regmap, DMEC_GPIO_SET_OFFSET(priv), BIT(offset));
+	else
+		regmap_write(regmap, DMEC_GPIO_CLR_OFFSET(priv), BIT(offset));
+}
+
+static int dmec_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
+						   gpio_chip);
+	struct regmap *regmap = priv->regmap;
+
+	/* set pin as input */
+	regmap_update_bits(regmap, DMEC_GPIO_DIR_OFFSET(priv), BIT(offset), 0);
+
+	return 0;
+}
+
+static int dmec_gpio_direction_output(struct gpio_chip *gc, unsigned int offset,
+				      int value)
+{
+	struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
+						   gpio_chip);
+	struct regmap *regmap = priv->regmap;
+	unsigned int val = BIT(offset);
+
+	if (value)
+		regmap_write(regmap, DMEC_GPIO_SET_OFFSET(priv), val);
+	else
+		regmap_write(regmap, DMEC_GPIO_CLR_OFFSET(priv), val);
+
+	/* set pin as output */
+	regmap_update_bits(regmap, DMEC_GPIO_DIR_OFFSET(priv), val, val);
+
+	return 0;
+}
+
+static int dmec_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
+						   gpio_chip);
+	struct regmap *regmap = priv->regmap;
+	unsigned int val;
+
+	regmap_read(regmap, DMEC_GPIO_DIR_OFFSET(priv), &val);
+
+	return !(val & BIT(offset));
+}
+
+static int dmec_gpio_pincount(struct dmec_gpio_priv *priv)
+{
+	struct regmap *regmap = priv->regmap;
+	unsigned int val;
+
+	regmap_read(regmap, DMEC_GPIO_NOPS_OFFSET(priv), &val);
+
+	/* number of pins is val + 1 */
+	return val == 0xff ? 0 : (val & 7) + 1;
+}
+
+static int dmec_gpio_get_version(struct gpio_chip *gc)
+{
+	struct device *dev = gc->parent;
+	struct dmec_gpio_priv *p = container_of(gc, struct dmec_gpio_priv,
+						gpio_chip);
+	unsigned int v;
+
+	regmap_read(p->regmap, DMEC_GPIO_VER_OFFSET(p), &v);
+	p->ver = v;
+	dev_info(dev, "chip%u v%u.%u\n", p->chip_num, (v >> 4) & 0xf, v & 0xf);
+
+	return 0;
+}
+
+static void dmec_gpio_irq_enable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
+						   gpio_chip);
+	struct regmap *regmap = priv->regmap;
+	int offset, mask;
+
+	offset = DMEC_GPIO_IRQCFG_OFFSET(priv) + (d->hwirq >> 2);
+	mask = BIT((d->hwirq & 3) << 1);
+
+	regmap_update_bits(regmap, offset, mask, mask);
+}
+
+static void dmec_gpio_irq_disable(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
+						   gpio_chip);
+	struct regmap *regmap = priv->regmap;
+	int offset, mask;
+
+	offset = DMEC_GPIO_IRQCFG_OFFSET(priv) + (d->hwirq >> 2);
+	mask = 3 << ((d->hwirq & 3) << 1);
+
+	regmap_update_bits(regmap, offset, mask, 0);
+}
+
+static int dmec_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct dmec_gpio_priv *priv = container_of(gc, struct dmec_gpio_priv,
+						   gpio_chip);
+	struct regmap *regmap = priv->regmap;
+	unsigned int offset, mask, val;
+
+	offset = DMEC_GPIO_IRQTYPE_OFFSET(priv) + (d->hwirq >> 2);
+	mask = ((d->hwirq & 3) << 1);
+
+	regmap_read(regmap, offset, &val);
+
+	val &= ~(3 << mask);
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_LEVEL_LOW:
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		val |= (1 << mask);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val |= (2 << mask);
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		val |= (3 << mask);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_write(regmap, offset, val);
+
+	return 0;
+}
+
+static irqreturn_t dmec_gpio_irq_handler(int irq, void *dev_id)
+{
+	struct dmec_gpio_priv *p = dev_id;
+	struct irq_domain *d = p->gpio_chip.irqdomain;
+	unsigned int irqs_handled = 0;
+	unsigned int val = 0, stat = 0;
+
+	regmap_read(p->regmap, DMEC_GPIO_IRQSTA_OFFSET(p), &val);
+	stat = val;
+	while (stat) {
+		int line = __ffs(stat);
+		int child_irq = irq_find_mapping(d, line);
+
+		handle_nested_irq(child_irq);
+		stat &= ~(BIT(line));
+		irqs_handled++;
+	}
+	regmap_write(p->regmap, DMEC_GPIO_EVTSTA_OFFSET(p), val);
+
+	return irqs_handled ? IRQ_HANDLED : IRQ_NONE;
+}
+
+static int dmec_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dmec_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct dmec_gpio_priv *priv;
+	struct gpio_chip *gpio_chip;
+	struct irq_chip *irq_chip;
+	int ret = 0;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regmap = dmec_get_regmap(pdev->dev.parent);
+	priv->chip_num = pdata->chip_num;
+
+	gpio_chip = &priv->gpio_chip;
+	gpio_chip->label = "gpio-dmec";
+	gpio_chip->owner = THIS_MODULE;
+	gpio_chip->parent = dev;
+	gpio_chip->label = dev_name(dev);
+	gpio_chip->can_sleep = true;
+
+	gpio_chip->base = pdata->gpio_base;
+
+	gpio_chip->direction_input = dmec_gpio_direction_input;
+	gpio_chip->direction_output = dmec_gpio_direction_output;
+	gpio_chip->get_direction = dmec_gpio_get_direction;
+	gpio_chip->get = dmec_gpio_get;
+	gpio_chip->set = dmec_gpio_set;
+	gpio_chip->ngpio = dmec_gpio_pincount(priv);
+	if (gpio_chip->ngpio == 0) {
+		dev_err(dev, "No GPIOs detected\n");
+		return -ENODEV;
+	}
+
+	dmec_gpio_get_version(gpio_chip);
+
+	irq_chip = &priv->irq_chip;
+	irq_chip->name = dev_name(dev);
+	irq_chip->irq_mask = dmec_gpio_irq_disable;
+	irq_chip->irq_unmask = dmec_gpio_irq_enable;
+	irq_chip->irq_set_type = dmec_gpio_irq_set_type;
+
+	ret = devm_gpiochip_add_data(&pdev->dev, gpio_chip, priv);
+	if (ret) {
+		dev_err(dev, "Could not register GPIO chip\n");
+		return ret;
+	}
+
+	ret = gpiochip_irqchip_add(gpio_chip, irq_chip, 0,
+				   handle_simple_irq, IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(dev, "cannot add irqchip\n");
+		return ret;
+	}
+
+	priv->irq = platform_get_irq(pdev, 0);
+	ret = devm_request_threaded_irq(dev, priv->irq,
+					NULL, dmec_gpio_irq_handler,
+					IRQF_ONESHOT | IRQF_SHARED,
+					dev_name(dev), priv);
+	if (ret) {
+		dev_err(dev, "unable to get irq: %d\n", ret);
+		return ret;
+	}
+
+	gpiochip_set_chained_irqchip(gpio_chip, irq_chip, priv->irq, NULL);
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int dmec_gpio_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int dmec_gpio_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct dmec_gpio_priv *p = platform_get_drvdata(pdev);
+	struct regmap *regmap = p->regmap;
+	struct dmec_reg_ctx *ctx = &p->regs;
+
+	regmap_read(regmap, DMEC_GPIO_BASE(p), &ctx->dat);
+	regmap_read(regmap, DMEC_GPIO_DIR_OFFSET(p), &ctx->dir);
+	regmap_read(regmap, DMEC_GPIO_IRQCFG_OFFSET(p), &ctx->imask);
+	regmap_read(regmap, DMEC_GPIO_IRQTYPE_OFFSET(p), &ctx->emask[0]);
+	regmap_read(regmap, DMEC_GPIO_IRQTYPE_OFFSET(p) + 1, &ctx->emask[1]);
+	regmap_read(regmap, DMEC_GPIO_IRQCFG_OFFSET(p), &ctx->icfg[0]);
+	regmap_read(regmap, DMEC_GPIO_IRQCFG_OFFSET(p) + 1, &ctx->icfg[1]);
+
+	devm_free_irq(&pdev->dev, p->irq, p);
+
+	return 0;
+}
+
+static int dmec_gpio_resume(struct platform_device *pdev)
+{
+	struct dmec_gpio_priv *p = platform_get_drvdata(pdev);
+	struct regmap *regmap = p->regmap;
+	struct dmec_reg_ctx *ctx = &p->regs;
+	int ret;
+
+	regmap_write(regmap, DMEC_GPIO_BASE(p), ctx->dat);
+	regmap_write(regmap, DMEC_GPIO_DIR_OFFSET(p), ctx->dir);
+	regmap_write(regmap, DMEC_GPIO_IRQCFG_OFFSET(p), ctx->icfg[0]);
+	regmap_write(regmap, DMEC_GPIO_IRQCFG_OFFSET(p) + 1, ctx->icfg[1]);
+	regmap_write(regmap, DMEC_GPIO_IRQTYPE_OFFSET(p), ctx->emask[0]);
+	regmap_write(regmap, DMEC_GPIO_IRQTYPE_OFFSET(p) + 1, ctx->emask[1]);
+	regmap_write(regmap, DMEC_GPIO_IRQCFG_OFFSET(p), ctx->imask);
+	regmap_write(regmap, DMEC_GPIO_EVTSTA_OFFSET(p), 0xff);
+
+	ret = devm_request_threaded_irq(&pdev->dev, p->irq,
+					NULL, dmec_gpio_irq_handler,
+					IRQF_ONESHOT | IRQF_SHARED,
+					dev_name(&pdev->dev), p);
+	if (ret)
+		dev_err(&pdev->dev, "unable to get irq: %d\n", ret);
+
+	return ret;
+}
+#else
+#define dmec_gpio_suspend NULL
+#define dmec_gpio_resume NULL
+#endif
+
+static struct platform_driver dmec_gpio_driver = {
+	.driver = {
+		.name = "dmec-gpio",
+		.owner = THIS_MODULE,
+	},
+	.probe = dmec_gpio_probe,
+	.remove	= dmec_gpio_remove,
+	.suspend = dmec_gpio_suspend,
+	.resume = dmec_gpio_resume,
+};
+
+module_platform_driver(dmec_gpio_driver);
+
+MODULE_DESCRIPTION("dmec gpio driver");
+MODULE_AUTHOR("Zahari Doychev <zahari.doychev@linux.com");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:dmec-gpio");
-- 
git-series 0.8.10
