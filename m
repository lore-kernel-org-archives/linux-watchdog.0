Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:24597 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071AbcGNJ0d (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2016 05:26:33 -0400
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	<linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC 2/3] watchdog: introduce watchdog_worker_should_ping helper
Date: Thu, 14 Jul 2016 11:16:27 +0200
Message-ID: <1468487788-22457-3-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This will be useful when the condition becomes slightly more
complicated in the next patch.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/watchdog_dev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index 14f8a92..da549e5 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -188,18 +188,23 @@ static int watchdog_ping(struct watchdog_device *wdd)
 	return __watchdog_ping(wdd);
 }
 
+static bool watchdog_worker_should_ping(struct watchdog_core_data *wd_data)
+{
+	struct watchdog_device *wdd = wd_data->wdd;
+
+	return wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd));
+}
+
 static void watchdog_ping_work(struct work_struct *work)
 {
 	struct watchdog_core_data *wd_data;
-	struct watchdog_device *wdd;
 
 	wd_data = container_of(to_delayed_work(work), struct watchdog_core_data,
 			       work);
 
 	mutex_lock(&wd_data->lock);
-	wdd = wd_data->wdd;
-	if (wdd && (watchdog_active(wdd) || watchdog_hw_running(wdd)))
-		__watchdog_ping(wdd);
+	if (watchdog_worker_should_ping(wd_data))
+		__watchdog_ping(wd_data->wdd);
 	mutex_unlock(&wd_data->lock);
 }
 
-- 
2.5.0

