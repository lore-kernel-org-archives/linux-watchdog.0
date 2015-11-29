Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52956 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbbK2T3C (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 29 Nov 2015 14:29:02 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Doug Anderson <dianders@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 5/9] watchdog: Simplify update_worker
Date: Sun, 29 Nov 2015 11:28:47 -0800
Message-Id: <1448825331-28840-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
References: <1448825331-28840-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Drop 'cancel' parameter; simply cancel worker unconditionally
if not needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>

---
v6: Rebased to v4.4-rc2
v5: Introduced patch
---
 drivers/watchdog/watchdog_dev.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 82706d43e0c8..be65b388e277 100644
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
@@ -200,7 +199,7 @@ static int watchdog_start(struct watchdog_device *wdd)
 	if (err == 0) {
 		set_bit(WDOG_ACTIVE, &wdd->status);
 		wdd->last_keepalive = started_at;
-		watchdog_update_worker(wdd, true);
+		watchdog_update_worker(wdd);
 	}
 
 out_start:
@@ -245,7 +244,7 @@ static int watchdog_stop(struct watchdog_device *wdd)
 
 	if (err == 0) {
 		clear_bit(WDOG_ACTIVE, &wdd->status);
-		watchdog_update_worker(wdd, true);
+		watchdog_update_worker(wdd);
 	}
 
 out_stop:
@@ -313,7 +312,7 @@ static int watchdog_set_timeout(struct watchdog_device *wdd,
 	else
 		wdd->timeout = timeout;
 
-	watchdog_update_worker(wdd, true);
+	watchdog_update_worker(wdd);
 
 out_timeout:
 	mutex_unlock(&wdd->lock);
@@ -592,7 +591,7 @@ static int watchdog_release(struct inode *inode, struct file *file)
 	}
 
 	cancel_delayed_work_sync(&wdd->work);
-	watchdog_update_worker(wdd, false);
+	watchdog_update_worker(wdd);
 
 	/*
 	 * Allow the owner module to be unloaded again unless the watchdog
-- 
2.1.4

