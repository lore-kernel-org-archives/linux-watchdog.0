Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57267 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbbH2Tc4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 29 Aug 2015 15:32:56 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	Timo Kokkonen <timo.kokkonen@offcode.fi>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v3 9/9] watchdog: Always evaluate new timeout against min_timeout
Date: Sat, 29 Aug 2015 12:32:38 -0700
Message-Id: <1440876758-28047-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1440876758-28047-1-git-send-email-linux@roeck-us.net>
References: <1440876758-28047-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Up to now, a new timeout value is only evaluated against min_timeout
if max_timeout is provided. This does not really make sense; a driver
can have a minimum timeout even if it does not have a maximum timeout.
Ensure that it is not smaller than min_timeout, even if max_timeout
is not set.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: New patch
---
 include/linux/watchdog.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 5c7d0e9e1f3f..0d95b3a21556 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -141,9 +141,9 @@ static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool noway
 /* Use the following function to check if a timeout value is invalid */
 static inline bool watchdog_timeout_invalid(struct watchdog_device *wdd, unsigned int t)
 {
-	return t > UINT_MAX / 1000 ||
+	return t > UINT_MAX / 1000 || t < wdd->min_timeout ||
 		(!wdd->max_hw_timeout_ms && wdd->max_timeout &&
-		 (t < wdd->min_timeout || t > wdd->max_timeout));
+		 t > wdd->max_timeout);
 }
 
 /* Use the following functions to manipulate watchdog driver specific data */
-- 
2.1.4

