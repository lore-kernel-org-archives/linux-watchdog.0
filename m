Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27576 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab3IWKPx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Sep 2013 06:15:53 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTK00B5RPU77RB0@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 23 Sep 2013 19:15:52 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	Jamie Iles <jamie@jamieiles.com>,
	'Kevin Strasser' <kevin.strasser@linux.intel.com>,
	'Jingoo Han' <jg1.han@samsung.com>
Subject: [PATCH RESEND 1/3] watchdog: dw_wdt: Add __user annotation
Date: Mon, 23 Sep 2013 19:15:52 +0900
Message-id: <003401ceb845$e21479d0$a63d6d70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Added __user annotation to fix the following sparse warnings.

drivers/watchdog/dw_wdt.c:206:38: warning: incorrect type in argument 1 (different address spaces)
drivers/watchdog/dw_wdt.c:206:38:    expected void [noderef] <asn:1>*to
drivers/watchdog/dw_wdt.c:206:38:    got struct watchdog_info *<noident>
drivers/watchdog/dw_wdt.c:211:24: warning: incorrect type in initializer (different address spaces)
drivers/watchdog/dw_wdt.c:211:24:    expected int const [noderef] <asn:1>*register __p
drivers/watchdog/dw_wdt.c:211:24:    got int *<noident>

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Jamie Iles <jamie@jamieiles.com>
---
 drivers/watchdog/dw_wdt.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index e621098..cd5befb 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -203,12 +203,12 @@ static long dw_wdt_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		return copy_to_user((struct watchdog_info *)arg, &dw_wdt_ident,
+		return copy_to_user((void __user *)arg, &dw_wdt_ident,
 				    sizeof(dw_wdt_ident)) ? -EFAULT : 0;
 
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
-		return put_user(0, (int *)arg);
+		return put_user(0, (int __user *)arg);
 
 	case WDIOC_KEEPALIVE:
 		dw_wdt_set_next_heartbeat();
-- 
1.7.10.4


