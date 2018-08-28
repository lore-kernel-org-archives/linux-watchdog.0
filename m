Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39098 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeH1OMv (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 10:12:51 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/2] watchdog: core: fix null pointer dereference when releasing cdev
Date: Tue, 28 Aug 2018 12:13:47 +0200
Message-Id: <20180828101348.12443-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
References: <20180828101348.12443-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

watchdog_stop() calls watchdog_update_worker() which needs a valid
wdd->wd_data pointer. So, when unregistering the cdev, clear the
pointers after we call watchdog_stop(), not before.

Fixes: bb292ac1c602 ("watchdog: Introduce watchdog_stop_on_unregister helper")
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/watchdog_dev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ffbdc4642ea5..f6c24b22b37c 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1019,16 +1019,16 @@ static void watchdog_cdev_unregister(struct watchdog_device *wdd)
 		old_wd_data = NULL;
 	}
 
-	mutex_lock(&wd_data->lock);
-	wd_data->wdd = NULL;
-	wdd->wd_data = NULL;
-	mutex_unlock(&wd_data->lock);
-
 	if (watchdog_active(wdd) &&
 	    test_bit(WDOG_STOP_ON_UNREGISTER, &wdd->status)) {
 		watchdog_stop(wdd);
 	}
 
+	mutex_lock(&wd_data->lock);
+	wd_data->wdd = NULL;
+	wdd->wd_data = NULL;
+	mutex_unlock(&wd_data->lock);
+
 	hrtimer_cancel(&wd_data->timer);
 	kthread_cancel_work_sync(&wd_data->work);
 
-- 
2.11.0
