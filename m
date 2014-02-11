Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:26745 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767AbaBKMl5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 07:41:57 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0U00D310LV0F20@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 21:41:55 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'H Hartley Sweeten' <hsweeten@visionengravers.com>
Subject: [PATCH 1/3] watchdog: ep93xx_wdt: Use devm_ioremap_resource()
Date: Tue, 11 Feb 2014 21:41:54 +0900
Message-id: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_ioremap_resource() in order to make the code simpler,
and remove redundant return value check of platform_get_resource()
because the value is checked by devm_ioremap_resource().

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/ep93xx_wdt.c |   13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index d1d07f2..5e4f3de 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -118,16 +118,9 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	int err;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENXIO;
-
-	if (!devm_request_mem_region(&pdev->dev, res->start,
-				     resource_size(res), pdev->name))
-		return -EBUSY;
-
-	mmio_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	if (!mmio_base)
-		return -ENXIO;
+	mmio_base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mmio_base))
+		return PTR_ERR(mmio_base);
 
 	if (timeout < 1 || timeout > 3600) {
 		timeout = WDT_TIMEOUT;
-- 
1.7.10.4


