Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:63352 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaBKGwA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 01:52:00 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0T00DIOKENTY90@mailout4.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 15:51:59 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Ashish Jangam' <ashish.jangam@kpitcummins.com>
References: <000101cf26f5$06c21760$14464620$%han@samsung.com>
In-reply-to: <000101cf26f5$06c21760$14464620$%han@samsung.com>
Subject: [PATCH 4/8] watchdog: da9055: Remove unnecessary OOM messages
Date: Tue, 11 Feb 2014 15:51:58 +0900
Message-id: <000501cf26f5$c26ba030$4742e090$%han@samsung.com>
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
 drivers/watchdog/da9055_wdt.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 575f37a..495089d 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -151,10 +151,8 @@ static int da9055_wdt_probe(struct platform_device *pdev)
 
 	driver_data = devm_kzalloc(&pdev->dev, sizeof(*driver_data),
 				   GFP_KERNEL);
-	if (!driver_data) {
-		dev_err(da9055->dev, "Failed to allocate watchdog device\n");
+	if (!driver_data)
 		return -ENOMEM;
-	}
 
 	driver_data->da9055 = da9055;
 
-- 
1.7.10.4


