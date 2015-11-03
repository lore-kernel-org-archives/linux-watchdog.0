Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [RFC PATCH 08/13] watchdog: meson_wdt: use core restart handler
Date: Mon,  2 Nov 2015 20:36:21 -0500
Message-Id: <1446514586-31455-9-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1446514586-31455-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom restart handler by using the one provided by the
watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/meson_wdt.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 1f4155e..9047c8a 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -20,7 +20,6 @@
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/types.h>
 #include <linux/watchdog.h>
 
@@ -45,23 +44,19 @@ static unsigned int timeout = MESON_WDT_TIMEOUT;
 struct meson_wdt_dev {
 	struct watchdog_device wdt_dev;
 	void __iomem *wdt_base;
-	struct notifier_block restart_handler;
 };
 
-static int meson_restart_handle(struct notifier_block *this, unsigned long mode,
-				void *cmd)
+static int meson_wdt_restart(struct watchdog_device *wdt_dev)
 {
+	struct meson_wdt_dev *meson_wdt = watchdog_get_drvdata(wdt_dev);
 	u32 tc_reboot = MESON_WDT_DC_RESET | MESON_WDT_TC_EN;
-	struct meson_wdt_dev *meson_wdt = container_of(this,
-						       struct meson_wdt_dev,
-						       restart_handler);
 
 	while (1) {
 		writel(tc_reboot, meson_wdt->wdt_base + MESON_WDT_TC);
 		mdelay(5);
 	}
 
-	return NOTIFY_DONE;
+	return 0;
 }
 
 static int meson_wdt_ping(struct watchdog_device *wdt_dev)
@@ -136,6 +131,7 @@ static const struct watchdog_ops meson_wdt_ops = {
 	.stop		= meson_wdt_stop,
 	.ping		= meson_wdt_ping,
 	.set_timeout	= meson_wdt_set_timeout,
+	.restart        = meson_wdt_restart,
 };
 
 static int meson_wdt_probe(struct platform_device *pdev)
@@ -164,6 +160,7 @@ static int meson_wdt_probe(struct platform_device *pdev)
 
 	watchdog_init_timeout(&meson_wdt->wdt_dev, timeout, &pdev->dev);
 	watchdog_set_nowayout(&meson_wdt->wdt_dev, nowayout);
+	watchdog_set_restart_priority(&meson_wdt->wdt_dev, 128);
 
 	meson_wdt_stop(&meson_wdt->wdt_dev);
 
@@ -173,13 +170,6 @@ static int meson_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, meson_wdt);
 
-	meson_wdt->restart_handler.notifier_call = meson_restart_handle;
-	meson_wdt->restart_handler.priority = 128;
-	err = register_restart_handler(&meson_wdt->restart_handler);
-	if (err)
-		dev_err(&pdev->dev,
-			"cannot register restart handler (err=%d)\n", err);
-
 	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
 		 meson_wdt->wdt_dev.timeout, nowayout);
 
@@ -190,8 +180,6 @@ static int meson_wdt_remove(struct platform_device *pdev)
 {
 	struct meson_wdt_dev *meson_wdt = platform_get_drvdata(pdev);
 
-	unregister_restart_handler(&meson_wdt->restart_handler);
-
 	watchdog_unregister_device(&meson_wdt->wdt_dev);
 
 	return 0;
-- 
2.5.0
