Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45853 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbaB0Flo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Feb 2014 00:41:44 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N1N00FS03TJA440@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Thu, 27 Feb 2014 14:41:43 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'H Hartley Sweeten' <hsweeten@visionengravers.com>,
	'Mika Westerberg' <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/6] watchdog: ep93xx_wdt: split module author names
Date: Thu, 27 Feb 2014 14:41:42 +0900
Message-id: <004301cf337e$97e7a3f0$c7b6ebd0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Split module author names in order to fix the following
checkpatch warning.

  WARNING: quoted string split across lines

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/ep93xx_wdt.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 5e4f3de..5f54e1e 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -165,9 +165,9 @@ static struct platform_driver ep93xx_wdt_driver = {
 
 module_platform_driver(ep93xx_wdt_driver);
 
-MODULE_AUTHOR("Ray Lehtiniemi <rayl@mail.com>,"
-		"Alessandro Zummo <a.zummo@towertech.it>,"
-		"H Hartley Sweeten <hsweeten@visionengravers.com>");
+MODULE_AUTHOR("Ray Lehtiniemi <rayl@mail.com>");
+MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
+MODULE_AUTHOR("H Hartley Sweeten <hsweeten@visionengravers.com>");
 MODULE_DESCRIPTION("EP93xx Watchdog");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(WDT_VERSION);
-- 
1.7.10.4


