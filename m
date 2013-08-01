Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:8752 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3HAFjs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Aug 2013 01:39:48 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQU00JLK7PX2XJ0@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 01 Aug 2013 14:39:47 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Kevin Strasser' <kevin.strasser@linux.intel.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH 1/2] watchdong: kempld_wdt: Add __user annotation
Date: Thu, 01 Aug 2013 14:39:46 +0900
Message-id: <003201ce8e79$885e46f0$991ad4d0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
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
---
 drivers/watchdog/kempld_wdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 491419e..d204258 100644
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


