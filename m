Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [RFC PATCH 04/13] watchdog: digicolor_wdt: use core restart handler
Date: Mon,  2 Nov 2015 20:36:17 -0500
Message-Id: <1446514586-31455-5-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/digicolor_wdt.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 50abe1b..1ccb0b2 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 #include <linux/watchdog.h>
-#include <linux/reboot.h>
 #include <linux/platform_device.h>
 #include <linux/of_address.h>
 
@@ -28,7 +27,6 @@
 struct dc_wdt {
 	void __iomem		*base;
 	struct clk		*clk;
-	struct notifier_block	restart_handler;
 	spinlock_t		lock;
 };
 
@@ -50,16 +48,15 @@ static void dc_wdt_set(struct dc_wdt *wdt, u32 ticks)
 	spin_unlock_irqrestore(&wdt->lock, flags);
 }
 
-static int dc_restart_handler(struct notifier_block *this, unsigned long mode,
-			      void *cmd)
+static int dc_wdt_restart(struct watchdog_device *wdog)
 {
-	struct dc_wdt *wdt = container_of(this, struct dc_wdt, restart_handler);
+	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 
 	dc_wdt_set(wdt, 1);
 	/* wait for reset to assert... */
 	mdelay(500);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int dc_wdt_start(struct watchdog_device *wdog)
@@ -104,6 +101,7 @@ static struct watchdog_ops dc_wdt_ops = {
 	.stop		= dc_wdt_stop,
 	.set_timeout	= dc_wdt_set_timeout,
 	.get_timeleft	= dc_wdt_get_timeleft,
+	.restart        = dc_wdt_restart,
 };
 
 static struct watchdog_info dc_wdt_info = {
@@ -148,6 +146,7 @@ static int dc_wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 
 	watchdog_set_drvdata(&dc_wdt_wdd, wdt);
+	watchdog_set_restart_priority(&dc_wdt_wdd, 128);
 	watchdog_init_timeout(&dc_wdt_wdd, timeout, dev);
 	ret = watchdog_register_device(&dc_wdt_wdd);
 	if (ret) {
@@ -155,12 +154,6 @@ static int dc_wdt_probe(struct platform_device *pdev)
 		goto err_iounmap;
 	}
 
-	wdt->restart_handler.notifier_call = dc_restart_handler;
-	wdt->restart_handler.priority = 128;
-	ret = register_restart_handler(&wdt->restart_handler);
-	if (ret)
-		dev_warn(&pdev->dev, "cannot register restart handler\n");
-
 	return 0;
 
 err_iounmap:
@@ -172,7 +165,6 @@ static int dc_wdt_remove(struct platform_device *pdev)
 {
 	struct dc_wdt *wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&wdt->restart_handler);
 	watchdog_unregister_device(&dc_wdt_wdd);
 	iounmap(wdt->base);
 
-- 
2.5.0
