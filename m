Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: Ensure that wdd is not dereferenced if NULL
Date: Tue,  8 Mar 2016 18:46:13 -0800
Message-Id: <1457491573-9145-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Smatch rightfully complains that wdd is dereferenced in the watchdog
release function after being checked for NULL. Also make sure that it
is not accessed outside mutex protection to avoid use-after-free problems.

Fixes: e6c71e84e4c0 ("watchdog: Introduce WDOG_HW_RUNNING flag")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Wim,

please feel free to merge with the original commit if your prefer.

Thanks,
Guenter

 drivers/watchdog/watchdog_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 2d6110278eac..e2c5abbb45ff 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -711,6 +711,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	struct watchdog_core_data *wd_data = file->private_data;
 	struct watchdog_device *wdd;
 	int err = -EBUSY;
+	bool running;
 
 	mutex_lock(&wd_data->lock);
 
@@ -742,14 +743,15 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
 
 done:
+	running = wdd && watchdog_hw_running(wdd);
 	mutex_unlock(&wd_data->lock);
 	/*
 	 * Allow the owner module to be unloaded again unless the watchdog
 	 * is still running. If the watchdog is still running, it can not
 	 * be stopped, and its driver must not be unloaded.
 	 */
-	if (!watchdog_hw_running(wdd)) {
-		module_put(wdd->ops->owner);
+	if (!running) {
+		module_put(wd_data->cdev.owner);
 		kref_put(&wd_data->kref, watchdog_core_data_release);
 	}
 	return 0;
-- 
2.5.0
