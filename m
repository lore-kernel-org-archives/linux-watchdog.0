Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:12610
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753897Ab3GJPPg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Jul 2013 11:15:36 -0400
From: <dinguyen@altera.com>
To: <linux-watchdog@vger.kernel.org>,
	<devicetree-discuss@lists.ozlabs.org>
CC: <dinh.linux@gmail.com>, Dinh Nguyen <dinguyen@altera.com>,
	Jamie Iles <jamie@jamieiles.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Pavel Machek <pavel@denx.de>
Subject: [PATCHv2] watchdog: dw: Enable OF support for DW watchdog timer.
Date: Wed, 10 Jul 2013 10:14:57 -0500
Message-ID: <1373469297-30082-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Dinh Nguyen <dinguyen@altera.com>

Add device tree support to the DW watchdog timer.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Pavel Machek <pavel@denx.de>

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


