Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35941 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932696AbbI2I1l (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 29 Sep 2015 04:27:41 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 1/9] watchdog: Always evaluate new timeout against min_timeout
Date: Tue, 29 Sep 2015 01:27:24 -0700
Message-Id: <1443515252-30085-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1443515252-30085-1-git-send-email-linux@roeck-us.net>
References: <1443515252-30085-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Up to now, a new timeout value is only evaluated against min_timeout
if max_timeout is provided. This does not really make sense; a driver
can have a minimum timeout even if it does not have a maximum timeout.
Ensure that it is not smaller than min_timeout, even if max_timeout
is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Now first patch of series.
    Added comments.
v3: New patch.
---
 include/linux/watchdog.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index d74a0e907b9e..e90e3ea5ebeb 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -119,8 +119,15 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
 /* Use the following function to check if a timeout value is invalid */
 static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
 {
-	return ((wdd->max_timeout != 0) &&
-		(t < wdd->min_timeout || t > wdd->max_timeout));
+	/*
+	 * The timeout is invalid if
+	 * - the requested value is smaller than the configured minimum timeout,
+	 * or
+	 * - a maximum timeout is configured, and the requested value is larger
+	 *   than the maximum timeout.
+	 */
+	return t < wdd->min_timeout ||
+		(wdd->max_timeout && t > wdd->max_timeout);
 }
 
 /* Use the following functions to manipulate watchdog driver specific data */
-- 
2.1.4

