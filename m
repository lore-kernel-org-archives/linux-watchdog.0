Return-Path: <sangjung.woo@samsung.com>
From: Sangjung Woo <sangjung.woo@samsung.com>
To: Wim Van Sebroeck <wim@iguana.be>, Randy Dunlap <rdunlap@infradead.org>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
 trivial@kernel.org, linux-kernel@vger.kernel.org, again4you@gmail.com,
 Sangjung Woo <sangjung.woo@samsung.com>
Subject: [PATCH v2] Documentation: fix two typos in watchdog-api.txt
Date: Wed, 30 Jul 2014 09:56:21 +0900
Message-id: <1406681781-3533-1-git-send-email-sangjung.woo@samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

This patch changes 'go of' to 'go off' and 'pretimout' to
'pretimeout'.

Signed-off-by: Sangjung Woo <sangjung.woo@samsung.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/watchdog/watchdog-api.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/watchdog/watchdog-api.txt b/Documentation/watchdog/watchdog-api.txt
index eb7132e..b3a701f 100644
--- a/Documentation/watchdog/watchdog-api.txt
+++ b/Documentation/watchdog/watchdog-api.txt
@@ -118,7 +118,7 @@ resets.
 Note that the pretimeout is the number of seconds before the time
 when the timeout will go off.  It is not the number of seconds until
 the pretimeout.  So, for instance, if you set the timeout to 60 seconds
-and the pretimeout to 10 seconds, the pretimout will go of in 50
+and the pretimeout to 10 seconds, the pretimeout will go off in 50
 seconds.  Setting a pretimeout to zero disables it.
 
 There is also a get function for getting the pretimeout:
-- 
1.7.9.5
