Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39146 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeH1OUO (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 10:20:14 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH] watchdog: HACK: disable bind attributes with NOWAYOUT
Date: Tue, 28 Aug 2018 12:29:06 +0200
Message-Id: <20180828102906.12840-1-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

With NOWAYOUT, prevent bind/unbind possibilities in SYSFS.
Proof-of-concept, not for upstream yet.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

So, this is really an RFC to check if something like this is considered useful
or not. If so, we probably need to do it differently because modifying the
parent's driver is likely a layering violation. We could add the driver to
modify as an optional parameter to watchdog_set_nowayout(). I wouldn't favor
another seperate function to configure this, but am open for discussion.

Thanks,

   Wolfram

 include/linux/watchdog.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/watchdog.h b/include/linux/watchdog.h
index 44985c4a1e86..241de0fa0010 100644
--- a/include/linux/watchdog.h
+++ b/include/linux/watchdog.h
@@ -143,8 +143,10 @@ static inline bool watchdog_hw_running(struct watchdog_device *wdd)
 /* Use the following function to set the nowayout feature */
 static inline void watchdog_set_nowayout(struct watchdog_device *wdd, bool nowayout)
 {
-	if (nowayout)
+	if (nowayout) {
 		set_bit(WDOG_NO_WAY_OUT, &wdd->status);
+		wdd->parent->driver->suppress_bind_attrs = true;
+	}
 }
 
 /* Use the following function to stop the watchdog on reboot */
-- 
2.11.0
