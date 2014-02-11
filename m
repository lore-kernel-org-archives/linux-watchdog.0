Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:15269 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaBKGvU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:51:20 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T00AKJKDJMO10@mailout2.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 15:51:19 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Ashish Jangam' <ashish.jangam@kpitcummins.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: [PATCH 3/8] watchdog: da9052: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:51:18 +0900
Message-id: <000401cf26f5$aa972970$ffc57c50$%han@samsung.com>
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
 drivers/watchdog/da9052_wdt.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index f09c54e..2e95896 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -185,7 +185,6 @@ static int da9052_wdt_probe(struct platform_device *pdev)
 	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
 				   GFP_KERNEL);
 	if (!driver_data) {
-		dev_err(da9052->dev, "Unable to alloacate watchdog device\n");
 		ret = -ENOMEM;
 		goto err;
 	}
-- 
1.7.10.4


