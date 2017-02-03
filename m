Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:49266 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdBCTre (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Feb 2017 14:47:34 -0500
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org
Cc: fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com,
        horms+renesas@verge.net.au, treding@nvidia.com,
        jonathanh@nvidia.com, f.fainelli@gmail.com, kernel@pengutronix.de,
        shawnguo@kernel.org, linux@armlinux.org.uk, wim@iguana.be,
        mark.rutland@arm.com, damien.riegel@savoirfairelinux.com,
        lucile.quirion@savoirfairelinux.com, olof@lixom.net, arnd@arndb.de,
        suzuki.poulose@arm.com, will.deacon@arm.com,
        yamada.masahiro@socionext.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH v2 4/6] bus: add driver for the Technologic Systems NBUS
Date: Fri,  3 Feb 2017 14:47:27 -0500
Message-Id: <20170203194729.20995-5-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver implements a GPIOs bit-banged bus, called the NBUS by
Technologic Systems. It is used to communicate with the peripherals in
the FPGA on the TS-4600 SoM.

---
Changes v1 -> v2:
  - rebase on master
  - the driver now populate its child nodes
  - remove the 'default y' option from the Kconfig
  - rework the driver to not use singleton anymore (suggested by Linus
  Walleij)
  - replace the use of the legacy GPIO API with gpiod (suggested by
  Linus Walleij)
  - use the ts vendor prefix for gpios (suggested by Rob Herring)

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 drivers/bus/Kconfig     |   8 ++
 drivers/bus/Makefile    |   1 +
 drivers/bus/ts-nbus.c   | 357 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ts-nbus.h |  26 ++++
 4 files changed, 392 insertions(+)
 create mode 100644 drivers/bus/ts-nbus.c
 create mode 100644 include/linux/ts-nbus.h

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index b9e8cfc93c7e..e573f1c27162 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -157,6 +157,14 @@ config TEGRA_GMI
 	  Driver for the Tegra Generic Memory Interface bus which can be used
 	  to attach devices such as NOR, UART, FPGA and more.
 
+config TS_NBUS
+	tristate "Technologic Systems NBUS Driver"
+	depends on SOC_IMX28
+	depends on OF_GPIO && PWM
+	help
+	  Driver for the Technologic Systems NBUS which is used to interface
+	  with the peripherals in the FPGA of the TS-4600 SoM.
+
 config UNIPHIER_SYSTEM_BUS
 	tristate "UniPhier System Bus driver"
 	depends on ARCH_UNIPHIER && OF
diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
index cc6364bec054..72377f77651c 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
 obj-$(CONFIG_TEGRA_GMI)		+= tegra-gmi.o
+obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
 
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
new file mode 100644
index 000000000000..d502d97adbd5
--- /dev/null
+++ b/drivers/bus/ts-nbus.c
@@ -0,0 +1,357 @@
+/*
+ * NBUS driver for TS-4600 based boards
+ *
+ * Copyright (c) 2016 - Savoir-faire Linux
+ * Author: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ *
+ * This driver implements a GPIOs bit-banged bus, called the NBUS by Technologic
+ * Systems. It is used to communicate with the peripherals in the FPGA on the
+ * TS-4600 SoM.
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/ts-nbus.h>
+
+static DEFINE_MUTEX(ts_nbus_lock);
+
+#define TS_NBUS_READ_MODE  0
+#define TS_NBUS_WRITE_MODE 1
+#define TS_NBUS_DIRECTION_IN  0
+#define TS_NBUS_DIRECTION_OUT 1
+#define TS_NBUS_WRITE_ADR 0
+#define TS_NBUS_WRITE_VAL 1
+
+/*
+ * request all gpios required by the bus.
+ */
+static int ts_nbus_init_pdata(struct platform_device *pdev, struct ts_nbus
+		*ts_nbus)
+{
+	ts_nbus->data = devm_gpiod_get_array(&pdev->dev, "ts-data",
+			GPIOD_OUT_HIGH);
+	if (IS_ERR(ts_nbus->data)) {
+		dev_err(&pdev->dev, "failed to retrieve ts-data-gpio from dts\n");
+		return PTR_ERR(ts_nbus->data);
+	}
+
+	ts_nbus->csn = devm_gpiod_get(&pdev->dev, "ts-csn", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts_nbus->csn)) {
+		dev_err(&pdev->dev, "failed to retrieve ts-csn-gpio from dts\n");
+		return PTR_ERR(ts_nbus->csn);
+	}
+
+	ts_nbus->txrx = devm_gpiod_get(&pdev->dev, "ts-txrx", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts_nbus->txrx)) {
+		dev_err(&pdev->dev, "failed to retrieve ts-txrx-gpio from dts\n");
+		return PTR_ERR(ts_nbus->txrx);
+	}
+
+	ts_nbus->strobe = devm_gpiod_get(&pdev->dev, "ts-strobe", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts_nbus->strobe)) {
+		dev_err(&pdev->dev, "failed to retrieve ts-strobe-gpio from dts\n");
+		return PTR_ERR(ts_nbus->strobe);
+	}
+
+	ts_nbus->ale = devm_gpiod_get(&pdev->dev, "ts-ale", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts_nbus->ale)) {
+		dev_err(&pdev->dev, "failed to retrieve ts-ale-gpio from dts\n");
+		return PTR_ERR(ts_nbus->ale);
+	}
+
+	ts_nbus->rdy = devm_gpiod_get(&pdev->dev, "ts-rdy", GPIOD_IN);
+	if (IS_ERR(ts_nbus->rdy)) {
+		dev_err(&pdev->dev, "failed to retrieve ts-rdy-gpio from dts\n");
+		return PTR_ERR(ts_nbus->rdy);
+	}
+
+	return 0;
+}
+
+/*
+ * the txrx gpio is used by the FPGA to know if the following transactions
+ * should be handled to read or write a value.
+ */
+static inline void ts_nbus_set_mode(struct ts_nbus *ts_nbus, int mode)
+{
+	if (mode == TS_NBUS_READ_MODE)
+		gpiod_set_value_cansleep(ts_nbus->txrx, 0);
+	else
+		gpiod_set_value_cansleep(ts_nbus->txrx, 1);
+}
+
+/*
+ * the data gpios are used for reading and writing values, their directions
+ * should be adjusted accordingly.
+ */
+static inline void ts_nbus_set_direction(struct ts_nbus *ts_nbus, int direction)
+{
+	int i;
+
+	for (i = 0; i < ts_nbus->data->ndescs; i++) {
+		if (direction == TS_NBUS_DIRECTION_IN)
+			gpiod_direction_input(ts_nbus->data->desc[i]);
+		else
+			gpiod_direction_output(ts_nbus->data->desc[i], 1);
+	}
+}
+
+/*
+ * reset the bus in its initial state.
+ */
+static inline void ts_nbus_reset_bus(struct ts_nbus *ts_nbus)
+{
+	int i;
+	int values[ts_nbus->data->ndescs];
+
+	for (i = 0; i < ts_nbus->data->ndescs; i++)
+		values[i] = 0;
+
+	gpiod_set_array_value_cansleep(ts_nbus->data->ndescs,
+			ts_nbus->data->desc, values);
+	gpiod_set_value_cansleep(ts_nbus->csn, 0);
+	gpiod_set_value_cansleep(ts_nbus->strobe, 0);
+	gpiod_set_value_cansleep(ts_nbus->ale, 0);
+}
+
+/*
+ * let the FPGA knows it can process.
+ */
+static inline void ts_nbus_start_transaction(struct ts_nbus *ts_nbus)
+{
+	gpiod_set_value_cansleep(ts_nbus->strobe, 1);
+}
+
+/*
+ * return the byte value read from the data gpios.
+ */
+static inline u8 ts_nbus_read_byte(struct ts_nbus *ts_nbus)
+{
+	struct gpio_descs *gpios = ts_nbus->data;
+	int i;
+	u8 value = 0;
+
+	for (i = 0; i < gpios->ndescs; i++)
+		if (gpiod_get_value_cansleep(gpios->desc[i]))
+			value |= 1 << i;
+
+	return value;
+}
+
+/*
+ * set the data gpios accordingly to the byte value.
+ */
+static inline void ts_nbus_write_byte(struct ts_nbus *ts_nbus, u8 byte)
+{
+	struct gpio_descs *gpios = ts_nbus->data;
+	int i;
+	int values[gpios->ndescs];
+
+	for (i = 0; i < gpios->ndescs; i++)
+		if (byte & (1 << i))
+			values[i] = 1;
+		else
+			values[i] = 0;
+
+	gpiod_set_array_value_cansleep(gpios->ndescs, gpios->desc, values);
+}
+
+/*
+ * reading the bus consists of resetting the bus, then notifying the FPGA to
+ * send the data in the data gpios and return the read value.
+ */
+static inline u8 ts_nbus_read_bus(struct ts_nbus *ts_nbus)
+{
+	ts_nbus_reset_bus(ts_nbus);
+	ts_nbus_start_transaction(ts_nbus);
+
+	return ts_nbus_read_byte(ts_nbus);
+}
+
+/*
+ * writing to the bus consists of resetting the bus, then define the type of
+ * command (address/value), write the data and notify the FPGA to retrieve the
+ * value in the data gpios.
+ */
+static inline void ts_nbus_write_bus(struct ts_nbus *ts_nbus, int cmd, u8 value)
+{
+	ts_nbus_reset_bus(ts_nbus);
+
+	if (cmd == TS_NBUS_WRITE_ADR)
+		gpiod_set_value_cansleep(ts_nbus->ale, 1);
+
+	ts_nbus_write_byte(ts_nbus, value);
+	ts_nbus_start_transaction(ts_nbus);
+}
+
+/*
+ * read the value in the FPGA register at the given address.
+ */
+u16 ts_nbus_read(struct ts_nbus *ts_nbus, u8 adr)
+{
+	int i;
+	u16 val;
+
+	/* bus access must be atomic */
+	mutex_lock(&ts_nbus_lock);
+
+	/* set the bus in read mode */
+	ts_nbus_set_mode(ts_nbus, TS_NBUS_READ_MODE);
+
+	/* write address */
+	ts_nbus_write_bus(ts_nbus, TS_NBUS_WRITE_ADR, adr);
+
+	/* set the data gpios direction as input before reading */
+	ts_nbus_set_direction(ts_nbus, TS_NBUS_DIRECTION_IN);
+
+	/* reading value MSB first */
+	do {
+		val = 0;
+		for (i = 1; i >= 0; i--)
+			val |= (ts_nbus_read_bus(ts_nbus) << (i * 8));
+		gpiod_set_value_cansleep(ts_nbus->csn, 1);
+	} while (gpiod_get_value_cansleep(ts_nbus->rdy));
+
+	/* restore the data gpios direction as output after reading */
+	ts_nbus_set_direction(ts_nbus, TS_NBUS_DIRECTION_OUT);
+
+	mutex_unlock(&ts_nbus_lock);
+
+	return val;
+}
+EXPORT_SYMBOL_GPL(ts_nbus_read);
+
+/*
+ * write the desired value in the FPGA register at the given address.
+ */
+int ts_nbus_write(struct ts_nbus *ts_nbus, u8 adr, u16 value)
+{
+	int i;
+
+	/* bus access must be atomic */
+	mutex_lock(&ts_nbus_lock);
+
+	/* set the bus in write mode */
+	ts_nbus_set_mode(ts_nbus, TS_NBUS_WRITE_MODE);
+
+	/* write address */
+	ts_nbus_write_bus(ts_nbus, TS_NBUS_WRITE_ADR, adr);
+
+	/* writing value MSB first */
+	for (i = 1; i >= 0; i--)
+		ts_nbus_write_bus(ts_nbus, TS_NBUS_WRITE_VAL, (u8)(value >> (i * 8)));
+
+	/* wait for completion */
+	gpiod_set_value_cansleep(ts_nbus->csn, 1);
+	while (gpiod_get_value_cansleep(ts_nbus->rdy) != 0) {
+		gpiod_set_value_cansleep(ts_nbus->csn, 0);
+		gpiod_set_value_cansleep(ts_nbus->csn, 1);
+	}
+
+	mutex_unlock(&ts_nbus_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ts_nbus_write);
+
+static int ts_nbus_probe(struct platform_device *pdev)
+{
+	struct pwm_device *pwm;
+	struct pwm_args pargs;
+	struct device *dev = &pdev->dev;
+	struct ts_nbus *ts_nbus;
+	int ret;
+
+	ts_nbus = devm_kzalloc(dev, sizeof(*ts_nbus), GFP_KERNEL);
+	if (!ts_nbus)
+		return -ENOMEM;
+
+	ret = ts_nbus_init_pdata(pdev, ts_nbus);
+	if (ret < 0)
+		return ret;
+
+	pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(pwm)) {
+		ret = PTR_ERR(pwm);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "unable to request PWM\n");
+		return ret;
+	}
+
+	pwm_get_args(pwm, &pargs);
+	if (!pargs.period) {
+		dev_err(&pdev->dev, "invalid PWM period\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * FIXME: pwm_apply_args() should be removed when switching to
+	 * the atomic PWM API.
+	 */
+	pwm_apply_args(pwm);
+	ret = pwm_config(pwm, pargs.period, pargs.period);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * we can now start the FPGA and populate the peripherals.
+	 */
+	pwm_enable(pwm);
+	ts_nbus->pwm = pwm;
+
+	/*
+	 * let the child nodes retrieve this instance of the ts-nbus.
+	 */
+	dev_set_drvdata(dev, ts_nbus);
+
+	ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "initialized\n");
+
+	return 0;
+}
+
+static int ts_nbus_remove(struct platform_device *pdev)
+{
+	struct ts_nbus *ts_nbus = dev_get_drvdata(&pdev->dev);
+
+	/* shutdown the FPGA */
+	mutex_lock(&ts_nbus_lock);
+	pwm_disable(ts_nbus->pwm);
+	mutex_unlock(&ts_nbus_lock);
+
+	return 0;
+}
+
+static const struct of_device_id ts_nbus_of_match[] = {
+	{ .compatible = "technologic,ts-nbus", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ts_nbus_of_match);
+
+static struct platform_driver ts_nbus_driver = {
+	.probe		= ts_nbus_probe,
+	.remove		= ts_nbus_remove,
+	.driver		= {
+		.name	= "ts_nbus",
+		.of_match_table = ts_nbus_of_match,
+	},
+};
+
+module_platform_driver(ts_nbus_driver);
+
+MODULE_ALIAS("platform:ts_nbus");
+MODULE_AUTHOR("Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>");
+MODULE_DESCRIPTION("Technologic Systems NBUS");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/ts-nbus.h b/include/linux/ts-nbus.h
new file mode 100644
index 000000000000..c0055d9fc9e6
--- /dev/null
+++ b/include/linux/ts-nbus.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (c) 2016 - Savoir-faire Linux
+ * Author: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _TS_NBUS_H
+#define _TS_NBUS_H
+
+struct ts_nbus {
+	struct pwm_device *pwm;
+	struct gpio_descs *data;
+	struct gpio_desc *csn;
+	struct gpio_desc *txrx;
+	struct gpio_desc *strobe;
+	struct gpio_desc *ale;
+	struct gpio_desc *rdy;
+};
+
+extern u16 ts_nbus_read(struct ts_nbus *, u8 adr);
+extern int ts_nbus_write(struct ts_nbus *, u8 adr, u16 value);
+
+#endif /* _TS_NBUS_H */
-- 
2.11.0

