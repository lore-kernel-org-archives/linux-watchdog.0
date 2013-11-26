Return-Path: <dianders@google.com>
Return-Path: <dianders@google.com>
From: Doug Anderson <dianders@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Doug Anderson <dianders@chromium.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] watchdog: core: Fix watchdog_init_timeout() when invalid param / valid dt
Date: Tue, 26 Nov 2013 10:22:53 -0800
Message-Id: <1385490173-7511-2-git-send-email-dianders@chromium.org>
In-Reply-To: <1385490173-7511-1-git-send-email-dianders@chromium.org>
References: <1385490173-7511-1-git-send-email-dianders@chromium.org>
List-ID: <linux-watchdog@vger.kernel.org>

There was a minor bug in watchdog_init_timeout() where it would return
an error code if someone specified an invalid parameter on the
command line but then there was a valid parameter in the device tree
as "timeout-sec".

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/watchdog/watchdog_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index cec9b55..8d27753 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -82,12 +82,12 @@ int watchdog_init_timeout(struct watchdog_device *wdd,
 		wdd->timeout = timeout_parm;
 		return ret;
 	}
-	if (timeout_parm)
-		ret = -EINVAL;
 
-	/* try to get the timeout_sec property */
+	/* if no device tree then we're done */
 	if (dev == NULL || dev->of_node == NULL)
-		return ret;
+		return (timeout_parm) ? -EINVAL : ret;
+
+	/* try to get the timeout_sec property */
 	of_property_read_u32(dev->of_node, "timeout-sec", &t);
 	if (!watchdog_timeout_invalid(wdd, t) && t)
 		wdd->timeout = t;
-- 
1.8.4.1
