Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:53748 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752062AbdAFIsy (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Jan 2017 03:48:54 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] watchdog: softdog: make pretimeout support a compile option
Date: Fri,  6 Jan 2017 09:41:44 +0100
Message-Id: <20170106084144.22324-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

It occured to me that the panic pretimeout governor will stall the
softdog, because it is purely software which simply halts on panic.
Testing governors with the softdog on the other hand is really useful.
So, make this feature a compile time option which needs to be enabled
explicitly. This also removes the overhead if pretimeout support is not
used because it will now be compiled away (saving ~10% on ARM32).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/Kconfig   |  8 ++++++++
 drivers/watchdog/softdog.c | 27 +++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index acb00b53a5207b..70726ce3d166e8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -71,6 +71,14 @@ config SOFT_WATCHDOG
 	  To compile this driver as a module, choose M here: the
 	  module will be called softdog.
 
+config SOFT_WATCHDOG_PRETIMEOUT
+	bool "Software watchdog pretimeout governor support"
+	depends on SOFT_WATCHDOG && WATCHDOG_PRETIMEOUT_GOV
+	help
+	  Enable this if you want to use pretimeout governors with the software
+	  watchdog. Be aware that governors might affect the watchdog because it
+	  is purely software, e.g. the panic governor will stall it!
+
 config DA9052_WATCHDOG
 	tristate "Dialog DA9052 Watchdog"
 	depends on PMIC_DA9052
diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index c7bdc986dca1c2..bc8b7da61d8aa7 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -74,6 +74,7 @@ static struct timer_list softdog_ticktock =
 
 static struct watchdog_device softdog_dev;
 
+#if IS_ENABLED(CONFIG_SOFT_WATCHDOG_PRETIMEOUT)
 static void softdog_pretimeout(unsigned long data)
 {
 	watchdog_notify_pretimeout(&softdog_dev);
@@ -82,16 +83,23 @@ static void softdog_pretimeout(unsigned long data)
 static struct timer_list softdog_preticktock =
 		TIMER_INITIALIZER(softdog_pretimeout, 0, 0);
 
+static struct timer_list *softdog_preticktock_ptr = &softdog_preticktock;
+#else
+static void *softdog_preticktock_ptr = NULL;
+#endif /* CONFIG_SOFT_WATCHDOG_PRETIMEOUT */
+
 static int softdog_ping(struct watchdog_device *w)
 {
 	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
 		__module_get(THIS_MODULE);
 
-	if (w->pretimeout)
-		mod_timer(&softdog_preticktock, jiffies +
-			  (w->timeout - w->pretimeout) * HZ);
-	else
-		del_timer(&softdog_preticktock);
+	if (softdog_preticktock_ptr) {
+		if (w->pretimeout)
+			mod_timer(softdog_preticktock_ptr, jiffies +
+				  (w->timeout - w->pretimeout) * HZ);
+		else
+			del_timer(softdog_preticktock_ptr);
+	}
 
 	return 0;
 }
@@ -101,15 +109,15 @@ static int softdog_stop(struct watchdog_device *w)
 	if (del_timer(&softdog_ticktock))
 		module_put(THIS_MODULE);
 
-	del_timer(&softdog_preticktock);
+	if (softdog_preticktock_ptr)
+		del_timer(softdog_preticktock_ptr);
 
 	return 0;
 }
 
 static struct watchdog_info softdog_info = {
 	.identity = "Software Watchdog",
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
-		   WDIOF_PRETIMEOUT,
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
 };
 
 static const struct watchdog_ops softdog_ops = {
@@ -134,6 +142,9 @@ static int __init softdog_init(void)
 	watchdog_set_nowayout(&softdog_dev, nowayout);
 	watchdog_stop_on_reboot(&softdog_dev);
 
+	if (softdog_preticktock_ptr)
+		softdog_info.options |= WDIOF_PRETIMEOUT;
+
 	ret = watchdog_register_device(&softdog_dev);
 	if (ret)
 		return ret;
-- 
2.11.0

