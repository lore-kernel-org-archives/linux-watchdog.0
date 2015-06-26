Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp109.iad3a.emailsrvr.com ([173.203.187.109]:54537 "EHLO
	smtp109.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752146AbbFZNbj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 26 Jun 2015 09:31:39 -0400
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 2/5] watchdog: dw_wdt: reject additional device probes
Date: Fri, 26 Jun 2015 14:21:10 +0100
Message-Id: <1435324873-18318-3-git-send-email-abbotti@mev.co.uk>
In-Reply-To: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
References: <1435324873-18318-1-git-send-email-abbotti@mev.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Certain Altera FPGAs have an ARM-based Hard Processor System (HPS) that
includes two DesignWare Watchdog Timer peripherals.  Problems occur if
both are enabled in the device tree as the "dw_wdt" driver only supports
a single device, using a static variable (`dw_wdt`) to hold its state.
Typically, the timer queue gets corrupted, leading to a kernel Oops.

Use bit 1 of `dw_wdt.state` to indicate that a device has already been
probed, and reject attempts to probe extra devices.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/watchdog/dw_wdt.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 249ef09..cece633 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -61,6 +61,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 
 /* dw_wdt.state bit numbers */
 #define DW_WDT_IN_USE		0
+#define DW_WDT_PROBED		1
 
 static struct {
 	void __iomem		*regs;
@@ -335,17 +336,26 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	int ret;
 	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 
+	if (test_and_set_bit(DW_WDT_PROBED, &dw_wdt.state)) {
+		pr_err("This driver only supports one device\n");
+		return -ENODEV;
+	}
+
 	dw_wdt.regs = devm_ioremap_resource(&pdev->dev, mem);
-	if (IS_ERR(dw_wdt.regs))
-		return PTR_ERR(dw_wdt.regs);
+	if (IS_ERR(dw_wdt.regs)) {
+		ret = PTR_ERR(dw_wdt.regs);
+		goto out_unmark_probed;
+	}
 
 	dw_wdt.clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(dw_wdt.clk))
-		return PTR_ERR(dw_wdt.clk);
+	if (IS_ERR(dw_wdt.clk)) {
+		ret = PTR_ERR(dw_wdt.clk);
+		goto out_unmark_probed;
+	}
 
 	ret = clk_prepare_enable(dw_wdt.clk);
 	if (ret)
-		return ret;
+		goto out_unmark_probed;
 
 	ret = misc_register(&dw_wdt_miscdev);
 	if (ret)
@@ -366,6 +376,9 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 out_disable_clk:
 	clk_disable_unprepare(dw_wdt.clk);
 
+out_unmark_probed:
+	clear_bit(DW_WDT_PROBED, &dw_wdt.state);
+
 	return ret;
 }
 
@@ -377,6 +390,8 @@ static int dw_wdt_drv_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(dw_wdt.clk);
 
+	clear_bit(DW_WDT_PROBED, &dw_wdt.state);
+
 	return 0;
 }
 
-- 
2.1.4

