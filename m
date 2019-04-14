Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F67C282E2
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A56218FF
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfDNK0j (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:26:39 -0400
Received: from sauhun.de ([88.99.104.3]:32912 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727041AbfDNK0i (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 06:26:38 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id 917DB2CF687;
        Sun, 14 Apr 2019 12:26:37 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 13/16] watchdog: st_lpc_wdt: drop warning after calling watchdog_init_timeout
Date:   Sun, 14 Apr 2019 12:26:24 +0200
Message-Id: <20190414102627.5564-14-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
References: <20190414102627.5564-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

The core will print out details now.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/st_lpc_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 9a5ed95c3403..7a90184eb950 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -224,10 +224,8 @@ static int st_wdog_probe(struct platform_device *pdev)
 
 	/* Init Watchdog timeout with value in DT */
 	ret = watchdog_init_timeout(&st_wdog_dev, 0, dev);
-	if (ret) {
-		dev_err(dev, "Unable to initialise watchdog timeout\n");
+	if (ret)
 		return ret;
-	}
 
 	ret = devm_watchdog_register_device(dev, &st_wdog_dev);
 	if (ret) {
-- 
2.11.0

