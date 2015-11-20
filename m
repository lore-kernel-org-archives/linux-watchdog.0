Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 4/6] watchdog: gpio_wdt: use core reboot notifier
Date: Fri, 20 Nov 2015 16:54:54 -0500
Message-Id: <1448056496-2335-5-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Get rid of the custom reboot notifier block registration and use the one
provided by the watchdog core.

Note that this watchdog used to stop unconditionnaly on SYS_HALT and
SYS_POWER_OFF. The core function now calls ops->stop on SYS_HALT and
SYS_DOWN. To prevent the watchdog from being stopped on reboot, the
"always-running" property must be set, otherwise it will now be stopped.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirlinux.com>
---
 drivers/watchdog/gpio_wdt.c | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 90d59d3..035c238 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -12,10 +12,8 @@
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/module.h>
-#include <linux/notifier.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_device.h>
-#include <linux/reboot.h>
 #include <linux/watchdog.h>
 
 #define SOFT_TIMEOUT_MIN	1
@@ -36,7 +34,6 @@ struct gpio_wdt_priv {
 	unsigned int		hw_algo;
 	unsigned int		hw_margin;
 	unsigned long		last_jiffies;
-	struct notifier_block	notifier;
 	struct timer_list	timer;
 	struct watchdog_device	wdd;
 };
@@ -126,26 +123,6 @@ static int gpio_wdt_set_timeout(struct watchdog_device *wdd, unsigned int t)
 	return gpio_wdt_ping(wdd);
 }
 
-static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
-			       void *unused)
-{
-	struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
-						  notifier);
-
-	mod_timer(&priv->timer, 0);
-
-	switch (code) {
-	case SYS_HALT:
-	case SYS_POWER_OFF:
-		gpio_wdt_disable(priv);
-		break;
-	default:
-		break;
-	}
-
-	return NOTIFY_DONE;
-}
-
 static const struct watchdog_info gpio_wdt_ident = {
 	.options	= WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING |
 			  WDIOF_SETTIMEOUT,
@@ -224,23 +201,16 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 
 	setup_timer(&priv->timer, gpio_wdt_hwping, (unsigned long)&priv->wdd);
 
+	watchdog_stop_on_reboot(&priv->wdd);
+
 	ret = watchdog_register_device(&priv->wdd);
 	if (ret)
 		return ret;
 
-	priv->notifier.notifier_call = gpio_wdt_notify_sys;
-	ret = register_reboot_notifier(&priv->notifier);
-	if (ret)
-		goto error_unregister;
-
 	if (priv->always_running)
 		gpio_wdt_start_impl(priv);
 
 	return 0;
-
-error_unregister:
-	watchdog_unregister_device(&priv->wdd);
-	return ret;
 }
 
 static int gpio_wdt_remove(struct platform_device *pdev)
@@ -248,7 +218,6 @@ static int gpio_wdt_remove(struct platform_device *pdev)
 	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
 
 	del_timer_sync(&priv->timer);
-	unregister_reboot_notifier(&priv->notifier);
 	watchdog_unregister_device(&priv->wdd);
 
 	return 0;
-- 
2.5.0
