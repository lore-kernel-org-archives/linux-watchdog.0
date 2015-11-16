Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 09/13] watchdog: moxart_wdt: use core restart handler
Date: Mon, 16 Nov 2015 12:28:07 -0500
Message-Id: <1447694891-24831-10-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/moxart_wdt.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 60b0605..885c81b 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -15,9 +15,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
-#include <linux/notifier.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 #include <linux/moduleparam.h>
 
@@ -29,22 +27,19 @@ struct moxart_wdt_dev {
 	struct watchdog_device dev;
 	void __iomem *base;
 	unsigned int clock_frequency;
-	struct notifier_block restart_handler;
 };
 
 static int heartbeat;
 
-static int moxart_restart_handle(struct notifier_block *this,
-				 unsigned long mode, void *cmd)
+static int moxart_wdt_restart(struct watchdog_device *wdt_dev)
 {
-	struct moxart_wdt_dev *moxart_wdt = container_of(this,
-							 struct moxart_wdt_dev,
-							 restart_handler);
+	struct moxart_wdt_dev *moxart_wdt = watchdog_get_drvdata(wdt_dev);
+
 	writel(1, moxart_wdt->base + REG_COUNT);
 	writel(0x5ab9, moxart_wdt->base + REG_MODE);
 	writel(0x03, moxart_wdt->base + REG_ENABLE);
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int moxart_wdt_stop(struct watchdog_device *wdt_dev)
@@ -87,6 +82,7 @@ static const struct watchdog_ops moxart_wdt_ops = {
 	.start          = moxart_wdt_start,
 	.stop           = moxart_wdt_stop,
 	.set_timeout    = moxart_wdt_set_timeout,
+	.restart        = moxart_wdt_restart,
 };
 
 static int moxart_wdt_probe(struct platform_device *pdev)
@@ -134,6 +130,7 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&moxart_wdt->dev, heartbeat, dev);
 	watchdog_set_nowayout(&moxart_wdt->dev, nowayout);
+	watchdog_set_restart_priority(&moxart_wdt->dev, 128);
 
 	watchdog_set_drvdata(&moxart_wdt->dev, moxart_wdt);
 
@@ -141,13 +138,6 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	moxart_wdt->restart_handler.notifier_call = moxart_restart_handle;
-	moxart_wdt->restart_handler.priority = 128;
-	err = register_restart_handler(&moxart_wdt->restart_handler);
-	if (err)
-		dev_err(dev, "cannot register restart notifier (err=%d)\n",
-			err);
-
 	dev_dbg(dev, "Watchdog enabled (heartbeat=%d sec, nowayout=%d)\n",
 		moxart_wdt->dev.timeout, nowayout);
 
@@ -158,7 +148,6 @@ static int moxart_wdt_remove(struct platform_device *pdev)
 {
 	struct moxart_wdt_dev *moxart_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&moxart_wdt->restart_handler);
 	moxart_wdt_stop(&moxart_wdt->dev);
 
 	return 0;
-- 
2.5.0
