Return-Path: <SRS0=DRey=BH=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DA8C433EA
	for <linux-watchdog@archiver.kernel.org>; Tue, 28 Jul 2020 06:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3A25207E8
	for <linux-watchdog@archiver.kernel.org>; Tue, 28 Jul 2020 06:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgG1GrI (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:47:08 -0400
Received: from inva021.nxp.com ([92.121.34.21]:49264 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgG1GrG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Jul 2020 02:47:06 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3511D200AF9;
        Tue, 28 Jul 2020 08:47:04 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E9E6200B56;
        Tue, 28 Jul 2020 08:47:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C66DC4030E;
        Tue, 28 Jul 2020 08:46:54 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 2/2] watchdog: imx7ulp: Watchdog should continue running for wait/stop mode
Date:   Tue, 28 Jul 2020 14:42:47 +0800
Message-Id: <1595918567-2017-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595918567-2017-1-git-send-email-Anson.Huang@nxp.com>
References: <1595918567-2017-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

When kernel idle, system will enter wait/stop mode, wdog should continue
running in this scenario, and the refresh thread can wake up system from
wait/stop mode.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index b414ecf..271a2e4 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -22,6 +22,8 @@
 #define WDOG_CS_CLK		(LPO_CLK << LPO_CLK_SHIFT)
 #define WDOG_CS_EN		BIT(7)
 #define WDOG_CS_UPDATE		BIT(5)
+#define WDOG_CS_WAIT		BIT(1)
+#define WDOG_CS_STOP		BIT(0)
 
 #define WDOG_CNT	0x4
 #define WDOG_TOVAL	0x8
@@ -174,7 +176,8 @@ static void imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
 	/* set an initial timeout value in TOVAL */
 	writel(timeout, base + WDOG_TOVAL);
 	/* enable 32bit command sequence and reconfigure */
-	val = WDOG_CS_CMD32EN | WDOG_CS_CLK | WDOG_CS_UPDATE;
+	val = WDOG_CS_CMD32EN | WDOG_CS_CLK | WDOG_CS_UPDATE |
+	      WDOG_CS_WAIT | WDOG_CS_STOP;
 	writel(val, base + WDOG_CS);
 	imx7ulp_wdt_wait(base, WDOG_CS_RCS);
 	local_irq_enable();
-- 
2.7.4

