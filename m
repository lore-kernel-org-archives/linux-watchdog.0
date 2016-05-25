Return-path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>,
	linux-renesas-soc@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
	Robin Gong <b38343@freescale.com>
Subject: [PATCH 7/7] watchdog: softdog: implement pretimeout support
Date: Wed, 25 May 2016 15:32:31 +0200
Message-Id: <1464183151-4912-8-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
References: <1464183151-4912-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Give devices which do not have hardware support for pretimeout at least a
software version of it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/softdog.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index b067edf246dff2..adfb3899296f0f 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -72,10 +72,25 @@ static void softdog_fire(unsigned long data)
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
+
 	return 0;
 }
 
@@ -84,12 +99,15 @@ static int softdog_stop(struct watchdog_device *w)
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
