Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34471 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299AbcEYGiW (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 02:38:22 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 7/7] watchdog: softdog: improve coding style
Date: Wed, 25 May 2016 08:37:49 +0200
Message-Id: <1464158269-2447-8-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/softdog.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 5e3a30b99d4415..b067edf246dff2 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -57,9 +57,9 @@ MODULE_PARM_DESC(soft_panic,
 static void softdog_fire(unsigned long data)
 {
 	module_put(THIS_MODULE);
-	if (soft_noboot)
+	if (soft_noboot) {
 		pr_crit("Triggered - Reboot ignored\n");
-	else if (soft_panic) {
+	} else if (soft_panic) {
 		pr_crit("Initiating panic\n");
 		panic("Software Watchdog Timer expired");
 	} else {
@@ -74,7 +74,7 @@ static struct timer_list softdog_ticktock =
 
 static int softdog_ping(struct watchdog_device *w)
 {
-	if (!mod_timer(&softdog_ticktock, jiffies+(w->timeout*HZ)))
+	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
 		__module_get(THIS_MODULE);
 	return 0;
 }
-- 
2.8.1

