Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:57422 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949Ab3JaHu5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 03:50:57 -0400
Received: by mail-bk0-f45.google.com with SMTP id r7so822170bkg.4
        for <linux-watchdog@vger.kernel.org>; Thu, 31 Oct 2013 00:50:55 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 31 Oct 2013 15:50:55 +0800
Message-ID: <CAPgLHd9HvoJKtv4x=WyQfRauH43vnYtr0vXDugbJWwUGL_0U2A@mail.gmail.com>
Subject: [PATCH -next] watchdog: rt2880_wdt: fix return value check in rt288x_wdt_probe()
From: Wei Yongjun <weiyj.lk@gmail.com>
To: wim@iguana.be, grant.likely@linaro.org, rob.herring@calxeda.com
Cc: yongjun_wei@trendmicro.com.cn, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_request_and_ioremap() returns NULL
pointer not ERR_PTR(). Fix it by using devm_ioremap_resource() instead
of devm_request_and_ioremap().

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/watchdog/rt2880_wdt.c | 2 +-
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
 

