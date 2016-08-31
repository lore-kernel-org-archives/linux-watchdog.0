Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:38219 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932616AbcHaLw7 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 Aug 2016 07:52:59 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Wolfram Sang <wsa@the-dreams.de>
CC: <linux-watchdog@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v5 08/10] watchdog: softdog: implement pretimeout support
Date: Wed, 31 Aug 2016 14:52:48 +0300
Message-ID: <1472644370-16982-9-git-send-email-vladimir_zapolskiy@mentor.com>
In-Reply-To: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1472644370-16982-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Give devices which do not have hardware support for pretimeout at least a
software version of it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
New change in the series.

Changes from Wolfram's v2 to v5:
* fixed a minor whitespace issue reported by checkpatch

Changes in Wolfram's series from v1 to v2
* added 'else' block in softdog_ping(), to actually
  disable the timer when pretimeout value got cleared.

 drivers/watchdog/softdog.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index b067edf246df..1b914a0d94c3 100644
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
 
 static struct watchdog_ops softdog_ops = {
-- 
2.8.1

