Return-Path: <dinguyen@altera.com>
From: <dinguyen@altera.com>
To: <dinh.linux@gmail.com>
CC: Dinh Nguyen <dinguyen@altera.com>, Guenter Roeck <linux@roeck-us.net>,
	Jamie Iles <jamie@jamieiles.com>, Viresh Kumar <viresh.linux@gmail.com>, Wim
 Van Sebroeck <wim@iguana.be>, Pavel Machek <pavel@denx.de>, Rob Herring
	<rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
	<mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell
	<ijc+devicetree@hellion.org.uk>, <devicetree@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>
Subject: [PATCHv3] watchdog: dw: Enable OF support for DW watchdog timer
Date: Tue, 22 Oct 2013 04:29:41 -0500
Message-ID: <1382434181-16936-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: dinguyen@altera.com
List-ID: <linux-watchdog@vger.kernel.org>

From: Dinh Nguyen <dinguyen@altera.com>

Add device tree support to the DW watchdog timer.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Pavel Machek <pavel@denx.de>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
---
v3:
- Clean up documentation
v2:
- Use of_match_ptr() for of_match_table
---
 .../devicetree/bindings/watchdog/dw_wdt.txt        |   14 ++++++++++++++
 drivers/watchdog/dw_wdt.c                          |    8 ++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
new file mode 100644
index 0000000..c5e9b65
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
@@ -0,0 +1,14 @@
+Synopsys Designware Watchdog Timer
+
+Required Properties:
+
+- compatible	: Should be "snps,dw-wdt"
+- reg		: Base address and size of the watchdog timer register.
+
+Example:
+
+	watchdog0: wd@ffd02000 {
+		compatible = "snps,dw-wdt";
+		reg = <0xffd02000 0x1000>;
+		clocks = <&per_base_clk>;
+	};
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index e621098..261fa42 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -29,6 +29,7 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
@@ -340,12 +341,19 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id dw_wdt_of_match[] = {
+	{ .compatible = "snps,dw-wdt", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, dw_wdt_of_match);
+
 static struct platform_driver dw_wdt_driver = {
 	.probe		= dw_wdt_drv_probe,
 	.remove		= dw_wdt_drv_remove,
 	.driver		= {
 		.name	= "dw_wdt",
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(dw_wdt_of_match),
 #ifdef CONFIG_PM
 		.pm	= &dw_wdt_pm_ops,
 #endif /* CONFIG_PM */
-- 
1.7.9.5
