Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:44972 "EHLO
        mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934130AbcLNXMv (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Dec 2016 18:12:51 -0500
From: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
To: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com
Cc: mark@embeddedarm.com, kris@embeddedarm.com,
        horms+renesas@verge.net.au, treding@nvidia.com,
        jonathanh@nvidia.com, f.fainelli@gmail.com, fabio.estevam@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org, linux@armlinux.org.uk,
        linux@roeck-us.net, wim@iguana.be, mark.rutland@arm.com,
        robh+dt@kernel.org, damien.riegel@savoirfairelinux.com,
        lucile.quirion@savoirfairelinux.com, olof@lixom.net, arnd@arndb.de,
        suzuki.poulose@arm.com, linus.walleij@linaro.org,
        will.deacon@arm.com, yamada.masahiro@socionext.com,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Subject: [PATCH 4/6] bus: add driver for the Technologic Systems NBUS
Date: Wed, 14 Dec 2016 18:12:34 -0500
Message-Id: <20161214231237.17496-5-sebastien.bourdelin@savoirfairelinux.com>
In-Reply-To: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
References: <20161214231237.17496-1-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver implements a GPIOs bit-banged bus, called the NBUS by
Technologic Systems. It is used to communicate with the peripherals in
the FPGA on the TS-4600 SoM.

Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
---
 drivers/bus/Kconfig     |   9 +
 drivers/bus/Makefile    |   1 +
 drivers/bus/ts-nbus.c   | 451 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ts-nbus.h |  17 ++
 4 files changed, 478 insertions(+)
 create mode 100644 drivers/bus/ts-nbus.c
 create mode 100644 include/linux/ts-nbus.h

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 7875105..74e72b3 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -150,6 +150,15 @@ config TEGRA_ACONNECT
 	  Driver for the Tegra ACONNECT bus which is used to interface with
 	  the devices inside the Audio Processing Engine (APE) for Tegra210.
 
+config TS_NBUS
+	tristate "Technologic Systems NBUS Driver"
+	default y
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
index c6cfa6b..83f874a 100644
--- a/drivers/bus/Makefile
+++ b/drivers/bus/Makefile
@@ -19,5 +19,6 @@ obj-$(CONFIG_QCOM_EBI2)		+= qcom-ebi2.o
 obj-$(CONFIG_SUNXI_RSB)		+= sunxi-rsb.o
 obj-$(CONFIG_SIMPLE_PM_BUS)	+= simple-pm-bus.o
 obj-$(CONFIG_TEGRA_ACONNECT)	+= tegra-aconnect.o
+obj-$(CONFIG_TS_NBUS)		+= ts-nbus.o
 obj-$(CONFIG_UNIPHIER_SYSTEM_BUS)	+= uniphier-system-bus.o
 obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
diff --git a/drivers/bus/ts-nbus.c b/drivers/bus/ts-nbus.c
new file mode 100644
index 0000000..44fc89d
--- /dev/null
+++ b/drivers/bus/ts-nbus.c
@@ -0,0 +1,451 @@
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
+#include <linux/gpio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+static DEFINE_MUTEX(ts_nbus_lock);
+static bool ts_nbus_ready;
+
+#define TS_NBUS_READ_MODE  0
+#define TS_NBUS_WRITE_MODE 1
+#define TS_NBUS_DIRECTION_IN  0
+#define TS_NBUS_DIRECTION_OUT 1
+#define TS_NBUS_WRITE_ADR 0
+#define TS_NBUS_WRITE_VAL 1
+
+struct ts_nbus {
+	struct pwm_device *pwm;
+	int num_data;
+	int *data;
+	int csn;
+	int txrx;
+	int strobe;
+	int ale;
+	int rdy;
+};
+
+static struct ts_nbus *ts_nbus;
+
+/*
+ * request all gpios required by the bus.
+ */
+static int ts_nbus_init(struct platform_device *pdev)
+{
+	int err;
+	int i;
+
+	for (i = 0; i < ts_nbus->num_data; i++) {
+		err = devm_gpio_request_one(&pdev->dev, ts_nbus->data[i],
+					    GPIOF_OUT_INIT_HIGH,
+					    "TS NBUS data");
+		if (err)
+			return err;
+	}
+
+	err = devm_gpio_request_one(&pdev->dev, ts_nbus->csn,
+				    GPIOF_OUT_INIT_HIGH,
+				    "TS NBUS csn");
+	if (err)
+		return err;
+
+	err = devm_gpio_request_one(&pdev->dev, ts_nbus->txrx,
+				    GPIOF_OUT_INIT_HIGH,
+				    "TS NBUS txrx");
+	if (err)
+		return err;
+
+	err = devm_gpio_request_one(&pdev->dev, ts_nbus->strobe,
+				    GPIOF_OUT_INIT_HIGH,
+				    "TS NBUS strobe");
+	if (err)
+		return err;
+
+	err = devm_gpio_request_one(&pdev->dev, ts_nbus->ale,
+				    GPIOF_OUT_INIT_HIGH,
+				    "TS NBUS ale");
+	if (err)
+		return err;
+
+	err = devm_gpio_request_one(&pdev->dev, ts_nbus->rdy,
+				    GPIOF_IN,
+				    "TS NBUS rdy");
+	if (err)
+		return err;
+
+	return 0;
+}
+
+/*
+ * retrieve all gpios used by the bus from the device tree.
+ */
+static int ts_nbus_get_of_pdata(struct device *dev, struct device_node *np)
+{
+	int num_data;
+	int *data;
+	int ret;
+	int i;
+
+	ret = of_gpio_named_count(np, "data-gpios");
+	if (ret < 0) {
+		dev_err(dev,
+			"failed to count GPIOs in DT property data-gpios\n");
+		return ret;
+	}
+	num_data = ret;
+	data = devm_kzalloc(dev, num_data * sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	for (i = 0; i < num_data; i++) {
+		ret = of_get_named_gpio(np, "data-gpios", i);
+		if (ret < 0) {
+			dev_err(dev, "failed to retrieve data-gpio from dts\n");
+			return ret;
+		}
+		data[i] = ret;
+	}
+	ts_nbus->num_data = num_data;
+	ts_nbus->data = data;
+
+	ret = of_get_named_gpio(np, "csn-gpios", 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to retrieve csn-gpio from dts\n");
+		return ret;
+	}
+	ts_nbus->csn = ret;
+
+	ret = of_get_named_gpio(np, "txrx-gpios", 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to retrieve txrx-gpio from dts\n");
+		return ret;
+	}
+	ts_nbus->txrx = ret;
+
+	ret = of_get_named_gpio(np, "strobe-gpios", 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to retrieve strobe-gpio from dts\n");
+		return ret;
+	}
+	ts_nbus->strobe = ret;
+
+	ret = of_get_named_gpio(np, "ale-gpios", 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to retrieve ale-gpio from dts\n");
+		return ret;
+	}
+	ts_nbus->ale = ret;
+
+	ret = of_get_named_gpio(np, "rdy-gpios", 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to retrieve rdy-gpio from dts\n");
+		return ret;
+	}
+	ts_nbus->rdy = ret;
+
+	return 0;
+}
+
+/*
+ * the txrx gpio is used by the FPGA to know if the following transactions
+ * should be handled to read or write a value.
+ */
+static inline void ts_nbus_set_mode(int mode)
+{
+	if (mode == TS_NBUS_READ_MODE)
+		gpio_set_value(ts_nbus->txrx, 0);
+	else
+		gpio_set_value(ts_nbus->txrx, 1);
+}
+
+/*
+ * the data gpios are used for reading and writing values, their directions
+ * should be adjusted accordingly.
+ */
+static inline void ts_nbus_set_direction(int direction)
+{
+	int i;
+
+	for (i = 0; i < ts_nbus->num_data; i++) {
+		if (direction == TS_NBUS_DIRECTION_IN)
+			gpio_direction_input(ts_nbus->data[i]);
+		else
+			gpio_direction_output(ts_nbus->data[i], 1);
+	}
+}
+
+/*
+ * reset the bus in its initial state.
+ */
+static inline void ts_nbus_reset_bus(void)
+{
+	int i;
+
+	for (i = 0; i < ts_nbus->num_data; i++)
+		gpio_set_value(ts_nbus->data[i], 0);
+
+	gpio_set_value(ts_nbus->csn, 0);
+	gpio_set_value(ts_nbus->strobe, 0);
+	gpio_set_value(ts_nbus->ale, 0);
+}
+
+/*
+ * let the FPGA knows it can process.
+ */
+static inline void ts_nbus_start_transaction(void)
+{
+	gpio_set_value(ts_nbus->strobe, 1);
+}
+
+/*
+ * return the byte value read from the data gpios.
+ */
+static inline u8 ts_nbus_read_byte(void)
+{
+	int i;
+	u8 value = 0;
+
+	for (i = 0; i < ts_nbus->num_data; i++)
+		if (ts_nbus->data[i])
+			value |= 1 << i;
+
+	return value;
+}
+
+/*
+ * set the data gpios accordingly to the byte value.
+ */
+static inline void ts_nbus_write_byte(u8 byte)
+{
+	int i;
+
+	for (i = 0; i < ts_nbus->num_data; i++)
+		if (byte & (1 << i))
+			gpio_set_value(ts_nbus->data[i], 1);
+}
+
+/*
+ * reading the bus consists of resetting the bus, then notifying the FPGA to
+ * send the data in the data gpios and return the read value.
+ */
+static inline u8 ts_nbus_read_bus(void)
+{
+	ts_nbus_reset_bus();
+	ts_nbus_start_transaction();
+
+	return ts_nbus_read_byte();
+}
+
+/*
+ * writing to the bus consists of resetting the bus, then define the type of
+ * command (address/value), write the data and notify the FPGA to retrieve the
+ * value in the data gpios.
+ */
+static inline void ts_nbus_write_bus(int cmd, u8 value)
+{
+	ts_nbus_reset_bus();
+
+	if (cmd == TS_NBUS_WRITE_ADR)
+		gpio_set_value(ts_nbus->ale, 1);
+
+	ts_nbus_write_byte(value);
+	ts_nbus_start_transaction();
+}
+
+/*
+ * read the value in the FPGA register at the given address.
+ */
+u16 ts_nbus_read(u8 adr)
+{
+	int i;
+	u16 val;
+
+	/* bus access must be atomic */
+	mutex_lock(&ts_nbus_lock);
+
+	/* set the bus in read mode */
+	ts_nbus_set_mode(TS_NBUS_READ_MODE);
+
+	/* write address */
+	ts_nbus_write_bus(TS_NBUS_WRITE_ADR, adr);
+
+	/* set the data gpios direction as input before reading */
+	ts_nbus_set_direction(TS_NBUS_DIRECTION_IN);
+
+	/* reading value MSB first */
+	do {
+		val = 0;
+		for (i = 1; i >= 0; i--)
+			val |= (ts_nbus_read_bus() << (i * 8));
+		gpio_set_value(ts_nbus->csn, 1);
+	} while (gpio_get_value(ts_nbus->rdy));
+
+	/* restore the data gpios direction as output after reading */
+	ts_nbus_set_direction(TS_NBUS_DIRECTION_OUT);
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
+int ts_nbus_write(u8 adr, u16 value)
+{
+	int i;
+
+	/* bus access must be atomic */
+	mutex_lock(&ts_nbus_lock);
+
+	/* set the bus in write mode */
+	ts_nbus_set_mode(TS_NBUS_WRITE_MODE);
+
+	/* write address */
+	ts_nbus_write_bus(TS_NBUS_WRITE_ADR, adr);
+
+	/* writing value MSB first */
+	for (i = 1; i >= 0; i--)
+		ts_nbus_write_bus(TS_NBUS_WRITE_VAL, (u8)(value >> (i * 8)));
+
+	/* wait for completion */
+	gpio_set_value(ts_nbus->csn, 1);
+	while (gpio_get_value(ts_nbus->rdy) != 0) {
+		gpio_set_value(ts_nbus->csn, 0);
+		gpio_set_value(ts_nbus->csn, 1);
+	}
+
+	mutex_unlock(&ts_nbus_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ts_nbus_write);
+
+/*
+ * helper function to know the state of the bus.
+ * this function is useful to let peripherals defer their probing while the bus
+ * is not ready.
+ */
+bool ts_nbus_is_ready(void)
+{
+	bool nbus_state;
+
+	mutex_lock(&ts_nbus_lock);
+	nbus_state = ts_nbus_ready;
+	mutex_unlock(&ts_nbus_lock);
+
+	return nbus_state;
+}
+EXPORT_SYMBOL_GPL(ts_nbus_is_ready);
+
+static int ts_nbus_probe(struct platform_device *pdev)
+{
+	struct pwm_device *pwm;
+	struct pwm_args pargs;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	ts_nbus = devm_kzalloc(dev, sizeof(*ts_nbus), GFP_KERNEL);
+	if (!ts_nbus)
+		return -ENOMEM;
+
+	ret = ts_nbus_get_of_pdata(dev, np);
+	if (ret)
+		return ret;
+	ret = ts_nbus_init(pdev);
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
+	 * we can now start the FPGA and let the peripherals knows the bus is
+	 * ready.
+	 */
+	pwm_enable(pwm);
+	ts_nbus->pwm = pwm;
+
+	mutex_lock(&ts_nbus_lock);
+	ts_nbus_ready = true;
+	mutex_unlock(&ts_nbus_lock);
+
+	dev_info(dev, "initialized\n");
+
+	return 0;
+}
+
+static int ts_nbus_remove(struct platform_device *pdev)
+{
+	/* disable bus access */
+	mutex_lock(&ts_nbus_lock);
+	ts_nbus_ready = false;
+	mutex_unlock(&ts_nbus_lock);
+
+	/* shutdown the FPGA */
+	pwm_disable(ts_nbus->pwm);
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
index 0000000..5fcdb96
--- /dev/null
+++ b/include/linux/ts-nbus.h
@@ -0,0 +1,17 @@
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
+extern u16 ts_nbus_read(u8 adr);
+extern int ts_nbus_write(u8 adr, u16 value);
+extern bool ts_nbus_is_ready(void);
+
+#endif /* _TS_NBUS_H */
-- 
2.10.2

