Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:45646 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab3JaLJp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 07:09:45 -0400
Received: by mail-pa0-f48.google.com with SMTP id kq14so2324980pab.7
        for <linux-watchdog@vger.kernel.org>; Thu, 31 Oct 2013 04:09:45 -0700 (PDT)
From: Tushar Behera <tushar.behera@linaro.org>
To: linux-kernel@vger.kernel.org
Cc: patches@linaro.org, linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4/5] watchdog: ralink: Use devm_ioremap_resource
Date: Thu, 31 Oct 2013 16:38:06 +0530
Message-Id: <1383217687-12037-5-git-send-email-tushar.behera@linaro.org>
In-Reply-To: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
References: <1383217687-12037-1-git-send-email-tushar.behera@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
CC: linux-watchdog@vger.kernel.org
CC: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/rt2880_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index a9f8491..53d37fe 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -144,7 +144,7 @@ static int rt288x_wdt_probe(struct platform_device *pdev)
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	rt288x_wdt_base = devm_request_and_ioremap(&pdev->dev, res);
+	rt288x_wdt_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rt288x_wdt_base))
 		return PTR_ERR(rt288x_wdt_base);
 
-- 
1.7.9.5

