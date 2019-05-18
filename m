Return-Path: <SRS0=RYhm=TS=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818CFC04AAF
	for <linux-watchdog@archiver.kernel.org>; Sat, 18 May 2019 21:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFD220675
	for <linux-watchdog@archiver.kernel.org>; Sat, 18 May 2019 21:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfERV2S (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 18 May 2019 17:28:18 -0400
Received: from sauhun.de ([88.99.104.3]:35850 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729597AbfERV2R (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 18 May 2019 17:28:17 -0400
Received: from localhost (p5486CE4C.dip0.t-ipconnect.de [84.134.206.76])
        by pokefinder.org (Postfix) with ESMTPSA id 818D32C0963;
        Sat, 18 May 2019 23:28:16 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH 16/46] watchdog: imx2_wdt: drop warning after registering device
Date:   Sat, 18 May 2019 23:27:31 +0200
Message-Id: <20190518212801.31010-17-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190518212801.31010-1-wsa+renesas@sang-engineering.com>
References: <20190518212801.31010-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The core will print out details now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/imx2_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index a606005dd65f..32af3974e6bb 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -316,10 +316,8 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	regmap_write(wdev->regmap, IMX2_WDT_WMCR, 0);
 
 	ret = watchdog_register_device(wdog);
-	if (ret) {
-		dev_err(&pdev->dev, "cannot register watchdog device\n");
+	if (ret)
 		goto disable_clk;
-	}
 
 	dev_info(&pdev->dev, "timeout %d sec (nowayout=%d)\n",
 		 wdog->timeout, nowayout);
-- 
2.19.1

