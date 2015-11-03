Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([208.88.110.44]:58885 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283AbbKCQM6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 11:12:58 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 05/13] watchdog: imgpdc_wdt: use core restart handler
Date: Tue,  3 Nov 2015 11:12:38 -0500
Message-Id: <1446567166-10156-6-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1446567166-10156-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446567166-10156-1-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/imgpdc_wdt.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 15ab072..3679f2e 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -45,7 +45,6 @@
 #include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/watchdog.h>
 
@@ -87,7 +86,6 @@ struct pdc_wdt_dev {
 	struct clk *wdt_clk;
 	struct clk *sys_clk;
 	void __iomem *base;
-	struct notifier_block restart_handler;
 };
 
 static int pdc_wdt_keepalive(struct watchdog_device *wdt_dev)
@@ -152,6 +150,16 @@ static int pdc_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int pdc_wdt_restart(struct watchdog_device *wdt_dev)
+{
+	struct pdc_wdt_dev *wdt = watchdog_get_drvdata(wdt_dev);
+
+	/* Assert SOFT_RESET */
+	writel(0x1, wdt->base + PDC_WDT_SOFT_RESET);
+
+	return 0;
+}
+
 static struct watchdog_info pdc_wdt_info = {
 	.identity	= "IMG PDC Watchdog",
 	.options	= WDIOF_SETTIMEOUT |
@@ -165,20 +173,9 @@ static const struct watchdog_ops pdc_wdt_ops = {
 	.stop		= pdc_wdt_stop,
 	.ping		= pdc_wdt_keepalive,
 	.set_timeout	= pdc_wdt_set_timeout,
+	.restart        = pdc_wdt_restart,
 };
 
-static int pdc_wdt_restart(struct notifier_block *this, unsigned long mode,
-			   void *cmd)
-{
-	struct pdc_wdt_dev *wdt = container_of(this, struct pdc_wdt_dev,
-					       restart_handler);
-
-	/* Assert SOFT_RESET */
-	writel(0x1, wdt->base + PDC_WDT_SOFT_RESET);
-
-	return NOTIFY_OK;
-}
-
 static int pdc_wdt_probe(struct platform_device *pdev)
 {
 	u64 div;
@@ -282,6 +279,7 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	}
 
 	watchdog_set_nowayout(&pdc_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&pdc_wdt->wdt_dev, 128);
 
 	platform_set_drvdata(pdev, pdc_wdt);
 
@@ -289,13 +287,6 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto disable_wdt_clk;
 
-	pdc_wdt->restart_handler.notifier_call = pdc_wdt_restart;
-	pdc_wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&pdc_wdt->restart_handler);
-	if (ret)
-		dev_warn(&pdev->dev, "failed to register restart handler: %d\n",
-			 ret);
-
 	return 0;
 
 disable_wdt_clk:
@@ -316,7 +307,6 @@ static int pdc_wdt_remove(struct platform_device *pdev)
 {
 	struct pdc_wdt_dev *pdc_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&pdc_wdt->restart_handler);
 	pdc_wdt_stop(&pdc_wdt->wdt_dev);
 	watchdog_unregister_device(&pdc_wdt->wdt_dev);
 	clk_disable_unprepare(pdc_wdt->wdt_clk);
-- 
2.5.0

