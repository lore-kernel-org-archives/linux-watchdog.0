Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:40557 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755412AbcH3PDV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 Aug 2016 11:03:21 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] watchdog: softdog: implement pretimeout support
Date: Tue, 30 Aug 2016 17:03:06 +0200
Message-Id: <20160830150306.2254-1-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Give devices which do not have hardware support for pretimeout at least a
software version of it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since v1: added 'else' block in softdog_ping(), to actually
disable the timer when pretimeout value got cleared.

Depends on the V4 pretimeout series from Vladimir.

Vladimir: Maybe you could add this patch to the next revision of your
pretimeout series? Then people have something to play around with
right away.

 drivers/watchdog/softdog.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index b067edf246dff2..bab31b8df847a5 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -72,10 +72,27 @@ static void softdog_fire(unsigned long data)
 static struct timer_list softdog_ticktock =
 		TIMER_INITIALIZER(softdog_fire, 0, 0);
 
+static struct watchdog_device softdog_dev;
+
+static void softdog_pretimeout(unsigned long data)
+{
+	watchdog_notify_pretimeout(&softdog_dev);
+}
+
+static struct timer_list softdog_preticktock =
+		TIMER_INITIALIZER(softdog_pretimeout, 0, 0);
+
 static int softdog_ping(struct watchdog_device *w)
 {
 	if (!mod_timer(&softdog_ticktock, jiffies + (w->timeout * HZ)))
 		__module_get(THIS_MODULE);
+
+	if (w->pretimeout)
+		mod_timer(&softdog_preticktock, jiffies +
+		          (w->timeout - w->pretimeout) * HZ);
+	else
+		del_timer(&softdog_preticktock);
+
 	return 0;
 }
 
@@ -84,12 +101,15 @@ static int softdog_stop(struct watchdog_device *w)
 	if (del_timer(&softdog_ticktock))
 		module_put(THIS_MODULE);
 
+	del_timer(&softdog_preticktock);
+
 	return 0;
 }
 
 static struct watchdog_info softdog_info = {
 	.identity = "Software Watchdog",
-	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
+		   WDIOF_PRETIMEOUT,
 };
 
 static struct watchdog_ops softdog_ops = {
-- 
2.9.3

