Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:9208
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753368Ab3JBSos (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Oct 2013 14:44:48 -0400
From: <dinguyen@altera.com>
To: <dinh.linux@gmail.com>
CC: Dinh Nguyen <dinguyen@altera.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>,
	Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ian.campbell@citrix.com>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Subject: [RESEND PATCHv2] watchdog: dw: Enable OF support for DW watchdog timer.
Date: Wed, 2 Oct 2013 13:44:32 -0500
Message-ID: <1380739472-26172-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: devicetree@vger.kernel.org
Cc: linux-watchdog@vger.kernel.org
---
v2:
- Use of_match_ptr() for of_match_table
---
 .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 ++++++++++++++++
 drivers/watchdog/dw_wdt.c                          |    8 ++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt

diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
new file mode 100644
index 0000000..29e150b
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
@@ -0,0 +1,16 @@
+Synopsys Designware Watchdog Timer
+
+Required Properties:
+
+- Compatiblity	: "snps,dw-wdt"
+- reg		: Base address of the watchdog timer register.
+
+Example:
+
+	watchdog0: wd@ffd02000 {
+		compatible = "snps,dw-wdt";
+		reg = <0xffd02000 0x1000>;
+		interrupts = <0 171 4>;
+		clocks = <&per_base_clk>;
+		status = "okay";
+	};
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 2037669..a720f9b 100644
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
@@ -343,12 +344,19 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
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


