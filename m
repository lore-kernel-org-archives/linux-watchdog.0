Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:24551 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751357AbdE3I5P (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 04:57:15 -0400
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
CC: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        <esben.haabendal@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Esben Haabendal <esben@haabendal.dk>,
        <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/3] watchdog: introduce watchdog_worker_should_ping helper
Date: Tue, 30 May 2017 10:56:45 +0200
Message-ID: <1496134608-7375-2-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1496134608-7375-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
 <1496134608-7375-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This will be useful when the condition becomes slightly more
complicated in the next patch.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/watchdog/watchdog_dev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index d5d2bbd..caa4b90 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -192,18 +192,23 @@ static int watchdog_ping(struct watchdog_device *wdd)
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
2.7.4

