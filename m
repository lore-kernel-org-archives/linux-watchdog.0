Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:16718 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755441AbcLNNuh (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 14 Dec 2016 08:50:37 -0500
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] watchdog: introduce watchdog_worker_should_ping helper
Date: Wed, 14 Dec 2016 14:37:33 +0100
Message-ID: <1481722654-6266-2-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1481722654-6266-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1481722654-6266-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This will be useful when the condition becomes slightly more
complicated in the next patch.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/watchdog_dev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 32930a0..ca0a000 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -192,6 +192,11 @@ static int watchdog_ping(struct watchdog_device *wdd)
 	return __watchdog_ping(wdd);
 }
 
+static bool watchdog_worker_should_ping(struct watchdog_device *wdd)
+{
+	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
+}
+
 static void watchdog_ping_work(struct work_struct *work)
 {
 	struct watchdog_core_data *wd_data;
@@ -202,7 +207,7 @@ static void watchdog_ping_work(struct work_struct *work)
 
 	mutex_lock(&wd_data->lock);
 	wdd = wd_data->wdd;
-	if (wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd)))
+	if (watchdog_worker_should_ping(wdd))
 		__watchdog_ping(wdd);
 	mutex_unlock(&wd_data->lock);
 }
-- 
2.7.4

