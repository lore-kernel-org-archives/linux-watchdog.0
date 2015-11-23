Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 5/8] watchdog: Simplify update_worker
Date: Sun, 22 Nov 2015 19:21:02 -0800
Message-Id: <1448248865-21684-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
References: <1448248865-21684-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Drop 'cancel' parameter; simply cancel worker unconditionally
if not needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5: Added patch.

 drivers/watchdog/watchdog_dev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 832bd5ac15b5..722ea86fcc7c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -96,15 +96,14 @@ static long watchdog_next_keepalive(struct watchdog_device *wdd)
 	return min_t(long, last_heartbeat - jiffies, keepalive_interval);
 }
 
-static inline void watchdog_update_worker(struct watchdog_device *wdd,
-					  bool cancel)
+static inline void watchdog_update_worker(struct watchdog_device *wdd)
 {
 	if (watchdog_need_worker(wdd)) {
 		long t = watchdog_next_keepalive(wdd);
 
 		if (t > 0)
 			mod_delayed_work(watchdog_wq, &wdd->work, t);
-	} else if (cancel) {
+	} else {
 		cancel_delayed_work(&wdd->work);
 	}
 }
@@ -133,7 +132,7 @@ static int _watchdog_ping(struct watchdog_device *wdd)
 	else
 		err = wdd->ops->start(wdd); /* restart watchdog */
 
-	watchdog_update_worker(wdd, false);
+	watchdog_update_worker(wdd);
 
 	return err;
 }
@@ -198,7 +197,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
 		wdd->last_keepalive = jiffies;
-		watchdog_update_worker(wdd, true);
+		watchdog_update_worker(wdd);
 	}
 
 out_start:
@@ -243,7 +242,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
-		watchdog_update_worker(wdd, true);
+		watchdog_update_worker(wdd);
 	}
 
 out_stop:
@@ -311,7 +310,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 	else
 		wdd->timeout = timeout;
 
-	watchdog_update_worker(wdd, true);
+	watchdog_update_worker(wdd);
 
 out_timeout:
 	mutex_unlock(&wdd->lock);
@@ -590,7 +589,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	}
 
 	cancel_delayed_work_sync(&wdd->work);
-	watchdog_update_worker(wdd, false);
+	watchdog_update_worker(wdd);
 
 	/*
 	 * Allow the owner module to be unloaded again unless the watchdog
-- 
2.1.4
