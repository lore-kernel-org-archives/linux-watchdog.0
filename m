Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:8958 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3HAFkw (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Aug 2013 01:40:52 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQU00MOE7QPJPJ0@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 01 Aug 2013 14:40:51 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Kevin Strasser' <kevin.strasser@linux.intel.com>,
	Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 2/2] watchdong: kempld_wdt: fix bit mask definition
Date: Thu, 01 Aug 2013 14:40:51 +0900
Message-id: <003801ce8e79$aea68a20$0bf39e60$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

STAGE_CFG bits are defined as [5:4] bits. However, '(((x) & 0x30) << 4)'
handles [9:8] bits. Thus, it should be fixed in order to handle
[5:4] bits.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/kempld_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index d204258..8a8e3ec 100644
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


