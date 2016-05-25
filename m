Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34467 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751418AbcEYGiT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 May 2016 02:38:19 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/7] watchdog: softdog: remove forward declaration
Date: Wed, 25 May 2016 08:37:46 +0200
Message-Id: <1464158269-2447-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
References: <1464158269-2447-1-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/softdog.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 0a29f5a0833787..42faa3d424d5ca 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -54,11 +54,6 @@ module_param(soft_panic, int, 0);
 MODULE_PARM_DESC(soft_panic,
 	"Softdog action, set to 1 to panic, 0 to reboot (default=0)");
 
-static void softdog_fire(unsigned long);
-
-static struct timer_list softdog_ticktock =
-		TIMER_INITIALIZER(softdog_fire, 0, 0);
-
 static void softdog_fire(unsigned long data)
 {
 	module_put(THIS_MODULE);
@@ -74,6 +69,9 @@ static void softdog_fire(unsigned long data)
 	}
 }
 
+static struct timer_list softdog_ticktock =
+		TIMER_INITIALIZER(softdog_fire, 0, 0);
+
 static int softdog_ping(struct watchdog_device *w)
 {
 	if (!mod_timer(&softdog_ticktock, jiffies+(w->timeout*HZ)))
-- 
2.8.1

