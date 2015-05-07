Return-path: <dianders@chromium.org>
From: Doug Anderson <dianders@chromium.org>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: jszhang@marvell.com,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] watchdog: dw_wdt: Use a mutex, not a spinlock
Date: Thu,  7 May 2015 15:09:23 -0700
Message-Id: <1431036564-4189-1-git-send-email-dianders@chromium.org>
List-ID: <linux-watchdog@vger.kernel.org>

Right now the dw_wdt uses a spinlock to protect dw_wdt_open().  The
problem is that while holding the spinlock we call:
-> dw_wdt_set_top()
   -> dw_wdt_top_in_seconds()
      -> clk_get_rate()
         -> clk_prepare_lock()
            -> mutex_lock()

Locking a mutex while holding a spinlock is not allowed and leads to
warnings like "BUG: spinlock wrong CPU on CPU#1", among other
problems.

There's no reason to use a spinlock, so switch to a mutex.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/watchdog/dw_wdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index d0bb949..3fa2f19 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -30,12 +30,12 @@
 #include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/mutex.h>
 #include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
-#include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
@@ -61,7 +61,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 #define WDT_TIMEOUT		(HZ / 2)
 
 static struct {
-	spinlock_t		lock;
+	struct mutex		lock;
 	void __iomem		*regs;
 	struct clk		*clk;
 	unsigned long		in_use;
@@ -177,7 +177,7 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 	/* Make sure we don't get unloaded. */
 	__module_get(THIS_MODULE);
 
-	spin_lock(&dw_wdt.lock);
+	mutex_lock(&dw_wdt.lock);
 	if (!dw_wdt_is_enabled()) {
 		/*
 		 * The watchdog is not currently enabled. Set the timeout to
@@ -190,7 +190,7 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 
 	dw_wdt_set_next_heartbeat();
 
-	spin_unlock(&dw_wdt.lock);
+	mutex_unlock(&dw_wdt.lock);
 
 	return nonseekable_open(inode, filp);
 }
@@ -348,7 +348,7 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	spin_lock_init(&dw_wdt.lock);
+	mutex_init(&dw_wdt.lock);
 
 	ret = misc_register(&dw_wdt_miscdev);
 	if (ret)
-- 
2.2.0.rc0.207.ga3a616c
