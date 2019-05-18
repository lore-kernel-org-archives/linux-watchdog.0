Return-Path: <SRS0=RYhm=TS=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49770C072AF
	for <linux-watchdog@archiver.kernel.org>; Sat, 18 May 2019 21:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A03620675
	for <linux-watchdog@archiver.kernel.org>; Sat, 18 May 2019 21:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfERV2S (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sat, 18 May 2019 17:28:18 -0400
Received: from sauhun.de ([88.99.104.3]:35826 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729535AbfERV2S (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 18 May 2019 17:28:18 -0400
Received: from localhost (p5486CE4C.dip0.t-ipconnect.de [84.134.206.76])
        by pokefinder.org (Postfix) with ESMTPSA id 103BF2C2356;
        Sat, 18 May 2019 23:28:17 +0200 (CEST)
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
Subject: [PATCH 17/46] watchdog: imx_sc_wdt: drop warning after registering device
Date:   Sat, 18 May 2019 23:27:32 +0200
Message-Id: <20190518212801.31010-18-wsa+renesas@sang-engineering.com>
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
 drivers/watchdog/imx_sc_wdt.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
index 49848b66186c..847aa1c3b5c2 100644
--- a/drivers/watchdog/imx_sc_wdt.c
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -122,13 +122,7 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
 	watchdog_stop_on_reboot(imx_sc_wdd);
 	watchdog_stop_on_unregister(imx_sc_wdd);
 
-	ret = devm_watchdog_register_device(dev, imx_sc_wdd);
-	if (ret) {
-		dev_err(dev, "Failed to register watchdog device\n");
-		return ret;
-	}
-
-	return 0;
+	return devm_watchdog_register_device(dev, imx_sc_wdd);
 }
 
 static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
-- 
2.19.1

