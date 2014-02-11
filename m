Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:10730 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbaBKG7l (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:59:41 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T00G4RKRE9M30@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 15:59:38 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Mika Westerberg' <mika.westerberg@linux.intel.com>
Subject: [PATCH] watchdog: ts72xx_wdt: make 'ts72xx_wdt_pdev' static
Date: Tue, 11 Feb 2014 15:59:38 +0900
Message-id: <001a01cf26f6$d4636dd0$7d2a4970$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Make 'ts72xx_wdt_pdev' static, because it is used only in this
file. It also fixes the following sparse warning.

  warning: symbol 'ts72xx_wdt_pdev' was not declared. Should it be static?

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/ts72xx_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 6959fa0..afa9d6e 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -61,7 +61,7 @@ struct ts72xx_wdt {
 	struct platform_device *pdev;
 };
 
-struct platform_device *ts72xx_wdt_pdev;
+static struct platform_device *ts72xx_wdt_pdev;
 
 /*
  * TS-72xx Watchdog supports following timeouts (value written
-- 
1.7.10.4


