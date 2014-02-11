Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:58923 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaBKGy5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:54:57 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T006MNKJKLH20@mailout3.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 15:54:56 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Mika Westerberg' <mika.westerberg@linux.intel.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: [PATCH 7/8] watchdog: ts72xx_wdt: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:54:56 +0900
Message-id: <000801cf26f6$2c18d930$844a8b90$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/ts72xx_wdt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 09d4831..6959fa0 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -394,10 +394,8 @@ static int ts72xx_wdt_probe(struct platform_device *pdev)
 	int error = 0;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(struct ts72xx_wdt), GFP_KERNEL);
-	if (!wdt) {
-		dev_err(&pdev->dev, "failed to allocate memory\n");
+	if (!wdt)
 		return -ENOMEM;
-	}
 
 	r1 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->control_reg = devm_ioremap_resource(&pdev->dev, r1);
-- 
1.7.10.4


