Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:52190 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752411AbcJGMlr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 7 Oct 2016 08:41:47 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v6 6/7] watchdog: softdog: implement pretimeout support
Date: Fri, 7 Oct 2016 15:41:38 +0300
Message-ID: <1475844099-26074-1-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1475843826-25830-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1475843826-25830-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Give devices which do not have hardware support for pretimeout at least a
software version of it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes from v5 to v6:
* rebased on top of Wim's watchdog/master branch resolving a minor conflict
* added Guenter's reviewed-by tag to the commit message

Changes from Wolfram's v2 to v5:
* new change in the series.
* fixed a minor whitespace issue reported by checkpatch

Changes in Wolfram's series from v1 to v2
* added 'else' block in softdog_ping(), to actually
  disable the timer when pretimeout value got cleared.

 drivers/watchdog/softdog.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 1ae469e94045..c7bdc986dca1 100644
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
+			  (w->timeout - w->pretimeout) * HZ);
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
 
 static const struct watchdog_ops softdog_ops = {
-- 
2.8.1

