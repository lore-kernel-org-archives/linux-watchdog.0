Return-Path: <groeck7@gmail.com>
Return-path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Steffen Trumtrar <s.trumtrar@pengutronix.de>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] watchdog: Fix potential kref imbalance when opening watchdog
Date: Mon, 25 Sep 2017 09:17:01 -0700
Message-Id: <1506356222-528-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

If a watchdog driver's open function sets WDOG_HW_RUNNING with the
expectation that the watchdog can not be stopped, but then stops the
watchdog anyway in its stop function, kref_get() wil not be called in
watchdog_open(). If the watchdog then stops on close, WDOG_HW_RUNNING
will be cleared and kref_put() will be called, causing a kref imbalance.
As result the character device data structure will be released, which in
turn will cause the system to crash on the next call to watchdog_open().

Fixes: ee142889e32f5 ("watchdog: Introduce WDOG_HW_RUNNING flag")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/watchdog_dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 0826e663bd5a..e6edf3737ea7 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -768,6 +768,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 {
 	struct watchdog_core_data *wd_data;
 	struct watchdog_device *wdd;
+	bool hw_running;
 	int err;
 
 	/* Get the corresponding watchdog device */
@@ -787,7 +788,8 @@ static int watchdog_open(struct inode *inode, struct file *file)
 	 * If the /dev/watchdog device is open, we don't want the module
 	 * to be unloaded.
 	 */
-	if (!watchdog_hw_running(wdd) && !try_module_get(wdd->ops->owner)) {
+	hw_running = watchdog_hw_running(wdd);
+	if (!hw_running && !try_module_get(wdd->ops->owner)) {
 		err = -EBUSY;
 		goto out_clear;
 	}
@@ -798,7 +800,7 @@ static int watchdog_open(struct inode *inode, struct file *file)
 
 	file->private_data = wd_data;
 
-	if (!watchdog_hw_running(wdd))
+	if (!hw_running)
 		kref_get(&wd_data->kref);
 
 	/* dev/watchdog is a virtual (and thus non-seekable) filesystem */
-- 
2.7.4
