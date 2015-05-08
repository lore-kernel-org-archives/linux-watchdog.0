Return-path: <dianders@chromium.org>
From: Doug Anderson <dianders@chromium.org>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: jszhang@marvell.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] watchdog: dw_wdt: No need for a spinlock
Date: Thu,  7 May 2015 21:27:44 -0700
Message-Id: <1431059265-9204-1-git-send-email-dianders@chromium.org>
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

There's no reason to use a spinlock.  Only dw_wdt_open() was protected
and the test_and_set_bit() at the start of that function protects us
anyway.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v2:
- Don't switch to mutex; just don't use spinlock at all as per Dmitry

 drivers/watchdog/dw_wdt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index d0bb949..a284abd 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -35,7 +35,6 @@
 #include <linux/pm.h>
 #include <linux/platform_device.h>
 #include <linux/reboot.h>
-#include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
@@ -61,7 +60,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 #define WDT_TIMEOUT		(HZ / 2)
 
 static struct {
-	spinlock_t		lock;
 	void __iomem		*regs;
 	struct clk		*clk;
 	unsigned long		in_use;
@@ -177,7 +175,6 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 	/* Make sure we don't get unloaded. */
 	__module_get(THIS_MODULE);
 
-	spin_lock(&dw_wdt.lock);
 	if (!dw_wdt_is_enabled()) {
 		/*
 		 * The watchdog is not currently enabled. Set the timeout to
@@ -190,8 +187,6 @@ static int dw_wdt_open(struct inode *inode, struct file *filp)
 
 	dw_wdt_set_next_heartbeat();
 
-	spin_unlock(&dw_wdt.lock);
-
 	return nonseekable_open(inode, filp);
 }
 
@@ -348,8 +343,6 @@ static int dw_wdt_drv_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	spin_lock_init(&dw_wdt.lock);
-
 	ret = misc_register(&dw_wdt_miscdev);
 	if (ret)
 		goto out_disable_clk;
-- 
2.2.0.rc0.207.ga3a616c
