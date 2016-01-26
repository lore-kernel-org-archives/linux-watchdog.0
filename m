Return-path: <linux@roeck-us.net>
From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v7 5/9] watchdog: Simplify update_worker
Date: Mon, 25 Jan 2016 18:53:12 -0800
Message-Id: <1453776796-3885-6-git-send-email-patchwork@patchwork.roeck-us.net>
In-Reply-To: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
References: <1453776796-3885-1-git-send-email-patchwork@patchwork.roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

From: Guenter Roeck <linux@roeck-us.net>

Drop 'cancel' parameter; simply cancel worker unconditionally
if not needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v7: Rebased to v4.5-rc1
v6: Rebased to v4.4-rc2
v5: Introduced patch
---
 drivers/watchdog/watchdog_dev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ff03cbc8e081..47e854be862c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -122,8 +122,7 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
 	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
 }
 
-static inline void watchdog_update_worker(struct watchdog_device *wdd,
-					  bool cancel)
+static inline void watchdog_update_worker(struct watchdog_device *wdd)
 {
 	struct watchdog_core_data *wd_data = wdd->wd_data;
 
@@ -132,7 +131,7 @@ static inline void watchdog_update_worker(struct watchdog_device *wdd,
 
 		if (t > 0)
 			mod_delayed_work(watchdog_wq, &wd_data->work, t);
-	} else if (cancel) {
+	} else {
 		cancel_delayed_work(&wd_data->work);
 	}
 }
@@ -157,7 +156,7 @@ static int __watchdog_ping(struct watchdog_device *wdd)
 	else
 		err = wdd->ops->start(wdd); /* restart watchdog */
 
-	watchdog_update_worker(wdd, false);
+	watchdog_update_worker(wdd);
 
 	return err;
 }
@@ -228,7 +227,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
 		wd_data->last_keepalive = started_at;
-		watchdog_update_worker(wdd, true);
+		watchdog_update_worker(wdd);
 	}
 
 	return err;
@@ -266,7 +265,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
-		watchdog_update_worker(wdd, true);
+		watchdog_update_worker(wdd);
 	}
 
 	return err;
@@ -313,7 +312,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 	else
 		wdd->timeout = timeout;
 
-	watchdog_update_worker(wdd, true);
+	watchdog_update_worker(wdd);
 
 	return err;
 }
@@ -737,7 +736,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	}
 
 	cancel_delayed_work_sync(&wd_data->work);
-	watchdog_update_worker(wdd, false);
+	watchdog_update_worker(wdd);
 
 	/* make sure that /dev/watchdog can be re-opened */
 	clear_bit(_WDOG_DEV_OPEN, &wd_data->status);
-- 
2.1.4
