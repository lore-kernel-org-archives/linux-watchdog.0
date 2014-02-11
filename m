Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:17442 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758AbaBKMp6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Feb 2014 07:45:58 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0U000WJ0SLYHD0@mailout1.samsung.com> for
 linux-watchdog@vger.kernel.org; Tue, 11 Feb 2014 21:45:57 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Wim Van Sebroeck' <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	'Guenter Roeck' <linux@roeck-us.net>,
	'Jingoo Han' <jg1.han@samsung.com>,
	'Michal Simek' <michal.simek@xilinx.com>,
	'Viresh Kumar' <viresh.kumar@linaro.org>
References: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
In-reply-to: <000e01cf2726$a511a030$ef34e090$%han@samsung.com>
Subject: [PATCH 3/3] watchdog: sp805_wdt: Use devm_ioremap_resource()
Date: Tue, 11 Feb 2014 21:45:56 +0900
Message-id: <001001cf2727$355d2ba0$a01782e0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-language: ko
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use devm_ioremap_resource() in order to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/watchdog/sp805_wdt.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 3f786ce..cf35036 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -209,13 +209,6 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 	struct sp805_wdt *wdt;
 	int ret = 0;
 
-	if (!devm_request_mem_region(&adev->dev, adev->res.start,
-				resource_size(&adev->res), "sp805_wdt")) {
-		dev_warn(&adev->dev, "Failed to get memory region resource\n");
-		ret = -ENOENT;
-		goto err;
-	}
-
 	wdt = devm_kzalloc(&adev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt) {
 		dev_warn(&adev->dev, "Kzalloc failed\n");
@@ -223,13 +216,9 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err;
 	}
 
-	wdt->base = devm_ioremap(&adev->dev, adev->res.start,
-			resource_size(&adev->res));
-	if (!wdt->base) {
-		ret = -ENOMEM;
-		dev_warn(&adev->dev, "ioremap fail\n");
-		goto err;
-	}
+	wdt->base = devm_ioremap_resource(&adev->dev, &adev->res);
+	if (IS_ERR(wdt->base))
+		return PTR_ERR(wdt->base);
 
 	wdt->clk = devm_clk_get(&adev->dev, NULL);
 	if (IS_ERR(wdt->clk)) {
-- 
1.7.10.4


