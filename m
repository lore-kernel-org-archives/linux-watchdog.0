Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22354 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453Ab3IWKRW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Sep 2013 06:17:22 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTK00CGAPVBCS31@mailout3.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 23 Sep 2013 19:17:21 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jamie Iles' <jamie@jamieiles.com>,
	'Kevin Strasser' <kevin.strasser@linux.intel.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <003401ceb845$e21479d0$a63d6d70$%han@samsung.com>
In-reply-to: <003401ceb845$e21479d0$a63d6d70$%han@samsung.com>
Subject: [PATCH RESEND 3/3] watchdog: kempld_wdt: Add __user annotation
Date: Mon, 23 Sep 2013 19:17:21 +0900
Message-id: <003601ceb846$16dbad00$44930700$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Added __user annotation to fix the following sparse warnings.
Also, it makes 'kempld_prescaler' static because it is used
only in this file.

drivers/watchdog/kempld_wdt.c:70:11: warning: symbol 'kempld_prescaler' was not declared. Should it be static?
drivers/watchdog/kempld_wdt.c:364:23: warning: incorrect type in initializer (different address spaces)
drivers/watchdog/kempld_wdt.c:364:23:    expected int const [noderef] <asn:1>*register __p
drivers/watchdog/kempld_wdt.c:364:23:    got int *<noident>

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/kempld_wdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 5c3d4df..8a8e3ec 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -67,7 +67,7 @@ enum {
 	PRESCALER_12,
 };
 
-const u32 kempld_prescaler[] = {
+static const u32 kempld_prescaler[] = {
 	[PRESCALER_21] = (1 << 21) - 1,
 	[PRESCALER_17] = (1 << 17) - 1,
 	[PRESCALER_12] = (1 << 12) - 1,
@@ -361,7 +361,7 @@ static long kempld_wdt_ioctl(struct watchdog_device *wdd, unsigned int cmd,
 		ret = kempld_wdt_keepalive(wdd);
 		break;
 	case WDIOC_GETPRETIMEOUT:
-		ret = put_user(wdt_data->pretimeout, (int *)arg);
+		ret = put_user(wdt_data->pretimeout, (int __user *)arg);
 		break;
 	}
 
-- 
1.7.10.4


