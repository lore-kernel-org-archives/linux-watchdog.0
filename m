Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-cys01nam02on0066.outbound.protection.outlook.com ([104.47.37.66]:12992
	"EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751512AbcHLGSJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 12 Aug 2016 02:18:09 -0400
From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <soren.brinkmann@xilinx.com>, <shubhrajyoti.datta@gmail.com>,
	<michal.simek@xilinx.com>, <wim@iguana.be>,
	Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCHv4] watchdog: xilinx: Add clock support
Date: Fri, 12 Aug 2016 11:47:44 +0530
Message-ID: <1470982664-13228-1-git-send-email-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add support for the clock. Currently we enable
at probe and relinquish at remove.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Acked-by: Sören Brinkmann <soren.brinkmann@xilinx.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
fix spaces and error path.
v3
do not fail existing dts
v4:
fix the error prints as the clock is optional

 .../devicetree/bindings/watchdog/of-xilinx-wdt.txt |  3 +++
 drivers/watchdog/of_xilinx_wdt.c                   | 27 ++++++++++++++++++++--
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
index 6d63782..c6ae9c9 100644
--- a/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/of-xilinx-wdt.txt
@@ -7,6 +7,8 @@ Required properties:
 - reg			: Physical base address and size
 
 Optional properties:
+- clocks		: Input clock specifier. Refer to common clock
+			  bindings.
 - clock-frequency	: Frequency of clock in Hz
 - xlnx,wdt-enable-once	: 0 - Watchdog can be restarted
 			  1 - Watchdog can be enabled just once
@@ -17,6 +19,7 @@ Example:
 axi-timebase-wdt@40100000 {
 	clock-frequency = <50000000>;
 	compatible = "xlnx,xps-timebase-wdt-1.00.a";
+	clocks = <&clkc 15>;
 	reg = <0x40100000 0x10000>;
 	xlnx,wdt-enable-once = <0x0>;
 	xlnx,wdt-interval = <0x1b>;
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index b2e1b4c..f757e6d 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -10,6 +10,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -45,6 +46,7 @@ struct xwdt_device {
 	u32 wdt_interval;
 	spinlock_t spinlock;
 	struct watchdog_device xilinx_wdt_wdd;
+	struct clk		*clk;
 };
 
 static int xilinx_wdt_start(struct watchdog_device *wdd)
@@ -195,16 +197,32 @@ static int xwdt_probe(struct platform_device *pdev)
 	spin_lock_init(&xdev->spinlock);
 	watchdog_set_drvdata(xilinx_wdt_wdd, xdev);
 
+	xdev->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(xdev->clk)) {
+		if (PTR_ERR(xdev->clk) == -ENOENT) {
+			dev_info(&pdev->dev, "input clock not provided\n");
+			xdev->clk = NULL;
+		} else {
+			return PTR_ERR(xdev->clk);
+		}
+	}
+
+	rc = clk_prepare_enable(xdev->clk);
+	if (rc) {
+		dev_err(&pdev->dev, "unable to enable clock\n");
+		return rc;
+	}
+
 	rc = xwdt_selftest(xdev);
 	if (rc == XWT_TIMER_FAILED) {
 		dev_err(&pdev->dev, "SelfTest routine error\n");
-		return rc;
+		goto err_clk_disable;
 	}
 
 	rc = watchdog_register_device(xilinx_wdt_wdd);
 	if (rc) {
 		dev_err(&pdev->dev, "Cannot register watchdog (err=%d)\n", rc);
-		return rc;
+		goto err_clk_disable;
 	}
 
 	dev_info(&pdev->dev, "Xilinx Watchdog Timer at %p with timeout %ds\n",
@@ -213,6 +231,10 @@ static int xwdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, xdev);
 
 	return 0;
+err_clk_disable:
+	clk_disable_unprepare(xdev->clk);
+
+	return rc;
 }
 
 static int xwdt_remove(struct platform_device *pdev)
@@ -220,6 +242,7 @@ static int xwdt_remove(struct platform_device *pdev)
 	struct xwdt_device *xdev = platform_get_drvdata(pdev);
 
 	watchdog_unregister_device(&xdev->xilinx_wdt_wdd);
+	clk_disable_unprepare(xdev->clk);
 
 	return 0;
 }
-- 
2.1.1

