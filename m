Return-path: <andrew.smirnov@gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linux-watchdog@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
	cphealy@gmail.com,
	linux-kernel@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] watchdog: core: Make use of devm_register_reboot_notifier()
Date: Tue,  4 Apr 2017 07:10:48 -0700
Message-Id: <20170404141048.16828-1-andrew.smirnov@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Save a bit of cleanup code by leveraging newly added
devm_register_reboot_notifier().

Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

All:

This patch is a follow up to this thread
https://lkml.org/lkml/2017/3/20/671. I am not sure what's the best way
to manager cross-tree dependency here, so, if there's something to be
done, please let me know.

Thanks,
Andrey Smirnov

 drivers/watchdog/watchdog_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index 74265b2..9d868f1 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -247,7 +247,8 @@ static int __watchdog_register_device(struct watchdog_device *wdd)
 	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status)) {
 		wdd->reboot_nb.notifier_call = watchdog_reboot_notifier;
 
-		ret = register_reboot_notifier(&wdd->reboot_nb);
+		ret = devm_register_reboot_notifier(wdd->parent,
+						    &wdd->reboot_nb);
 		if (ret) {
 			pr_err("watchdog%d: Cannot register reboot notifier (%d)\n",
 			       wdd->id, ret);
@@ -302,9 +303,6 @@ static void __watchdog_unregister_device(struct watchdog_device *wdd)
 	if (wdd->ops->restart)
 		unregister_restart_handler(&wdd->restart_nb);
 
-	if (test_bit(WDOG_STOP_ON_REBOOT, &wdd->status))
-		unregister_reboot_notifier(&wdd->reboot_nb);
-
 	watchdog_dev_unregister(wdd);
 	ida_simple_remove(&watchdog_ida, wdd->id);
 }
-- 
2.9.3
