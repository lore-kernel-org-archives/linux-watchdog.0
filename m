Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38004 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdGVQEs (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 22 Jul 2017 12:04:48 -0400
Received: by mail-qt0-f195.google.com with SMTP id 14so1929854qtn.5
        for <linux-watchdog@vger.kernel.org>; Sat, 22 Jul 2017 09:04:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: linux@roeck-us.net, joshc@codeaurora.org,
        linux-watchdog@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] watchdog: qcom: Check for platform_get_resource() failure
Date: Sat, 22 Jul 2017 13:04:33 -0300
Message-Id: <1500739473-9982-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fabio Estevam <fabio.estevam@nxp.com>

platform_get_resource() may fail, so we should better check its
return value and propagate an error in case it fails.

This avoids a NULL pointer dereference a bit later in the code.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/watchdog/qcom-wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 4f47b5e..7809713 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -162,6 +162,8 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENOMEM;
 
 	/* We use CPU0's DGT for the watchdog */
 	if (of_property_read_u32(np, "cpu-offset", &percpu_offset))
-- 
2.7.4

