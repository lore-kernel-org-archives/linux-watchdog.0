Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45083 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751744AbeB1I7P (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 28 Feb 2018 03:59:15 -0500
Received: by mail-pg0-f67.google.com with SMTP id i133so699333pgc.12
        for <linux-watchdog@vger.kernel.org>; Wed, 28 Feb 2018 00:59:15 -0800 (PST)
From: Igor Pylypiv <igor.pylypiv@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, igor.pylypiv@gmail.com
Subject: [PATCH] watchdog: f71808e_wdt: Fix magic close handling
Date: Wed, 28 Feb 2018 00:59:12 -0800
Message-Id: <1519808352-17278-1-git-send-email-igor.pylypiv@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Watchdog close is "expected" when any byte is 'V' not just the last one.
Writing "V" to the device fails because the last byte is the end of string.

$ echo V > /dev/watchdog
f71808e_wdt: Unexpected close, not stopping watchdog!

Signed-off-by: Igor Pylypiv <igor.pylypiv@gmail.com>
---
 drivers/watchdog/f71808e_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index e0678c1..3a33c53 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -566,7 +566,8 @@ static ssize_t watchdog_write(struct file *file, const char __user *buf,
 				char c;
 				if (get_user(c, buf + i))
 					return -EFAULT;
-				expect_close = (c == 'V');
+				if (c == 'V')
+					expect_close = true;
 			}
 
 			/* Properly order writes across fork()ed processes */
-- 
2.7.4

