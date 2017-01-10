Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 20/62] watchdog: iTCO_wdt: Replace shutdown function with call to watchdog_stop_on_reboot
Date: Tue, 10 Jan 2017 15:34:37 -0800
Message-Id: <1484091325-9199-21-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The shutdown function calls the stop function.
Call watchdog_stop_on_reboot() from probe instead.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/iTCO_wdt.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index d8bb7bf5e669..3d0abc0d59b4 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -520,6 +520,7 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 			WATCHDOG_TIMEOUT);
 	}
 
+	watchdog_stop_on_reboot(&p->wddev);
 	ret = devm_watchdog_register_device(dev, &p->wddev);
 	if (ret != 0) {
 		pr_err("cannot register watchdog device (err=%d)\n", ret);
@@ -543,13 +544,6 @@ static int iTCO_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void iTCO_wdt_shutdown(struct platform_device *pdev)
-{
-	struct iTCO_wdt_private *p = platform_get_drvdata(pdev);
-
-	iTCO_wdt_stop(&p->wddev);
-}
-
 #ifdef CONFIG_PM_SLEEP
 /*
  * Suspend-to-idle requires this, because it stops the ticks and timekeeping, so
@@ -603,7 +597,6 @@ static const struct dev_pm_ops iTCO_wdt_pm = {
 static struct platform_driver iTCO_wdt_driver = {
 	.probe          = iTCO_wdt_probe,
 	.remove         = iTCO_wdt_remove,
-	.shutdown       = iTCO_wdt_shutdown,
 	.driver         = {
 		.name   = DRV_NAME,
 		.pm     = ITCO_WDT_PM_OPS,
-- 
2.7.4
