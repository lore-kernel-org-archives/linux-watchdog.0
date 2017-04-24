Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S977458AbdDXWFd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 24 Apr 2017 18:05:33 -0400
From: Moritz Fischer <mdf@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: moritz.fischer@ettus.com, linux-watchdog@vger.kernel.org,
        linux@roeck-us.net, wim@iguana.be, a.zummo@towertech.it,
        alexandre.belloni@free-electrons.com, rtc-linux@googlegroups.com,
        alex.williams@ni.com, Moritz Fischer <mdf@kernel.org>
Subject: [PATCH 1/2] rtc: ds1374: wdt: Fix issue with timeout scaling from secs to wdt ticks
Date: Mon, 24 Apr 2017 15:05:11 -0700
Message-Id: <1493071512-5718-2-git-send-email-mdf@kernel.org>
In-Reply-To: <1493071512-5718-1-git-send-email-mdf@kernel.org>
References: <1493071512-5718-1-git-send-email-mdf@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix commit 920f91e50c5b ("drivers/rtc/rtc-ds1374.c: add watchdog support")

The issue is that the internal counter that triggers the watchdog reset
is actually running at 4096 Hz instead of 1Hz, therefore the value
given by userland (in sec) needs to be multiplied by 4096 to get the
correct behavior.

Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 drivers/rtc/rtc-ds1374.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
index 4cd115e..2a8b5b3 100644
--- a/drivers/rtc/rtc-ds1374.c
+++ b/drivers/rtc/rtc-ds1374.c
@@ -525,6 +525,10 @@ static long ds1374_wdt_ioctl(struct file *file, unsigned int cmd,
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
 
+		/* the hardware's tick rate is 4096 Hz, so
+		 * the counter value needs to be scaled accordingly
+		 */
+		new_margin <<= 12;
 		if (new_margin < 1 || new_margin > 16777216)
 			return -EINVAL;
 
@@ -533,7 +537,8 @@ static long ds1374_wdt_ioctl(struct file *file, unsigned int cmd,
 		ds1374_wdt_ping();
 		/* fallthrough */
 	case WDIOC_GETTIMEOUT:
-		return put_user(wdt_margin, (int __user *)arg);
+		/* when returning ... inverse is true */
+		return put_user((wdt_margin >> 12), (int __user *)arg);
 	case WDIOC_SETOPTIONS:
 		if (copy_from_user(&options, (int __user *)arg, sizeof(int)))
 			return -EFAULT;
-- 
2.7.4

