Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 3/7] watchdog: cadence_wdt: use core reboot notifier
Date: Wed, 18 Nov 2015 16:02:18 -0500
Message-Id: <1447880542-19320-4-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom reboot notifier block registration and use the one
provided by the watchdog core.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
---
 drivers/watchdog/cadence_wdt.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index bcfd2a2..abf64eb 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -18,7 +18,6 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #define CDNS_WDT_DEFAULT_TIMEOUT	10
@@ -72,7 +71,6 @@ MODULE_PARM_DESC(nowayout,
  * @ctrl_clksel: counter clock prescaler selection
  * @io_lock: spinlock for IO register access
  * @cdns_wdt_device: watchdog device structure
- * @cdns_wdt_notifier: notifier structure
  *
  * Structure containing parameters specific to cadence watchdog.
  */
@@ -84,7 +82,6 @@ struct cdns_wdt {
 	u32			ctrl_clksel;
 	spinlock_t		io_lock;
 	struct watchdog_device	cdns_wdt_device;
-	struct notifier_block	cdns_wdt_notifier;
 };
 
 /* Write access to Registers */
@@ -280,29 +277,6 @@ static struct watchdog_ops cdns_wdt_ops = {
 	.set_timeout = cdns_wdt_settimeout,
 };
 
-/**
- * cdns_wdt_notify_sys - Notifier for reboot or shutdown.
- *
- * @this: handle to notifier block
- * @code: turn off indicator
- * @unused: unused
- * Return: NOTIFY_DONE
- *
- * This notifier is invoked whenever the system reboot or shutdown occur
- * because we need to disable the WDT before system goes down as WDT might
- * reset on the next boot.
- */
-static int cdns_wdt_notify_sys(struct notifier_block *this, unsigned long code,
-			       void *unused)
-{
-	struct cdns_wdt *wdt = container_of(this, struct cdns_wdt,
-					    cdns_wdt_notifier);
-	if (code == SYS_DOWN || code == SYS_HALT)
-		cdns_wdt_stop(&wdt->cdns_wdt_device);
-
-	return NOTIFY_DONE;
-}
-
 /************************Platform Operations*****************************/
 /**
  * cdns_wdt_probe - Probe call for the device.
@@ -360,6 +334,7 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 	}
 
 	watchdog_set_nowayout(cdns_wdt_device, nowayout);
+	watchdog_stop_on_reboot(cdns_wdt_device);
 	watchdog_set_drvdata(cdns_wdt_device, wdt);
 
 	wdt->clk = devm_clk_get(&pdev->dev, NULL);
@@ -386,14 +361,6 @@ static int cdns_wdt_probe(struct platform_device *pdev)
 
 	spin_lock_init(&wdt->io_lock);
 
-	wdt->cdns_wdt_notifier.notifier_call = &cdns_wdt_notify_sys;
-	ret = register_reboot_notifier(&wdt->cdns_wdt_notifier);
-	if (ret != 0) {
-		dev_err(&pdev->dev, "cannot register reboot notifier err=%d)\n",
-			ret);
-		goto err_clk_disable;
-	}
-
 	ret = watchdog_register_device(cdns_wdt_device);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register wdt device\n");
@@ -427,7 +394,6 @@ static int cdns_wdt_remove(struct platform_device *pdev)
 
 	cdns_wdt_stop(&wdt->cdns_wdt_device);
 	watchdog_unregister_device(&wdt->cdns_wdt_device);
-	unregister_reboot_notifier(&wdt->cdns_wdt_notifier);
 	clk_disable_unprepare(wdt->clk);
 
 	return 0;
-- 
2.5.0
