Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:53928 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbdJSPG4 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 19 Oct 2017 11:06:56 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: y2038@lists.linaro.org, xen-devel@lists.xenproject.org,
        Jan Beulich <JBeulich@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: xen: use time64_t for timeouts
Date: Thu, 19 Oct 2017 17:05:48 +0200
Message-Id: <20171019150558.3202408-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Xen watchdog driver uses __kernel_time_t and ktime_to_timespec()
internally for managing its timeouts. Both are deprecated because of
y2038 problems. The driver itself is fine, since it only uses monotonic
times, but converting it to use ktime_get_seconds() avoids the deprecated
interfaces and is slightly simpler.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/xen_wdt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index cf0e650c2015..5dd5c3494d55 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -35,7 +35,7 @@
 static struct platform_device *platform_device;
 static DEFINE_SPINLOCK(wdt_lock);
 static struct sched_watchdog wdt;
-static __kernel_time_t wdt_expires;
+static time64_t wdt_expires;
 static bool is_active, expect_release;
 
 #define WATCHDOG_TIMEOUT 60 /* in seconds */
@@ -49,15 +49,15 @@ module_param(nowayout, bool, S_IRUGO);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started "
 	"(default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-static inline __kernel_time_t set_timeout(void)
+static inline time64_t set_timeout(void)
 {
 	wdt.timeout = timeout;
-	return ktime_to_timespec(ktime_get()).tv_sec + timeout;
+	return ktime_get_seconds() + timeout;
 }
 
 static int xen_wdt_start(void)
 {
-	__kernel_time_t expires;
+	time64_t expires;
 	int err;
 
 	spin_lock(&wdt_lock);
@@ -98,7 +98,7 @@ static int xen_wdt_stop(void)
 
 static int xen_wdt_kick(void)
 {
-	__kernel_time_t expires;
+	time64_t expires;
 	int err;
 
 	spin_lock(&wdt_lock);
@@ -222,7 +222,7 @@ static long xen_wdt_ioctl(struct file *file, unsigned int cmd,
 		return put_user(timeout, argp);
 
 	case WDIOC_GETTIMELEFT:
-		retval = wdt_expires - ktime_to_timespec(ktime_get()).tv_sec;
+		retval = wdt_expires - ktime_get_seconds();
 		return put_user(retval, argp);
 	}
 
-- 
2.9.0

