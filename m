Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22265 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488Ab3IWKQ6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Sep 2013 06:16:58 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTK00CGAPVBCS31@mailout3.samsung.com> for
 linux-watchdog@vger.kernel.org; Mon, 23 Sep 2013 19:16:57 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jamie Iles' <jamie@jamieiles.com>,
	'Kevin Strasser' <kevin.strasser@linux.intel.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <003401ceb845$e21479d0$a63d6d70$%han@samsung.com>
In-reply-to: <003401ceb845$e21479d0$a63d6d70$%han@samsung.com>
Subject: [PATCH RESEND 2/3] watchdog: kempld_wdt: Fix bit mask definition
Date: Mon, 23 Sep 2013 19:16:57 +0900
Message-id: <003501ceb846$08d39ab0$1a7ad010$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

STAGE_CFG bits are defined as [5:4] bits. However, '(((x) & 0x30) << 4)'
handles [9:8] bits. Thus, it should be fixed in order to handle
[5:4] bits.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/kempld_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 491419e..5c3d4df 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -35,7 +35,7 @@
 #define KEMPLD_WDT_STAGE_TIMEOUT(x)	(0x1b + (x) * 4)
 #define KEMPLD_WDT_STAGE_CFG(x)		(0x18 + (x))
 #define STAGE_CFG_GET_PRESCALER(x)	(((x) & 0x30) >> 4)
-#define STAGE_CFG_SET_PRESCALER(x)	(((x) & 0x30) << 4)
+#define STAGE_CFG_SET_PRESCALER(x)	(((x) & 0x3) << 4)
 #define STAGE_CFG_PRESCALER_MASK	0x30
 #define STAGE_CFG_ACTION_MASK		0x7
 #define STAGE_CFG_ASSERT		(1 << 3)
-- 
1.7.10.4


