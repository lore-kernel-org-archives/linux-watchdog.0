Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EF3C282E7
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C99206BA
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfDNK0h (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:26:37 -0400
Received: from sauhun.de ([88.99.104.3]:32916 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbfDNK0h (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 06:26:37 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id 5C0FE4A135F;
        Sun, 14 Apr 2019 12:26:35 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 07/16] watchdog: i6300esb: drop warning after calling watchdog_init_timeout
Date:   Sun, 14 Apr 2019 12:26:18 +0200
Message-Id: <20190414102627.5564-8-wsa+renesas@sang-engineering.com>
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
 drivers/watchdog/i6300esb.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index e312a2aeecad..17941c03996b 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -311,10 +311,7 @@ static int esb_probe(struct pci_dev *pdev,
 	edev->wdd.min_timeout = ESB_HEARTBEAT_MIN;
 	edev->wdd.max_timeout = ESB_HEARTBEAT_MAX;
 	edev->wdd.timeout = ESB_HEARTBEAT_DEFAULT;
-	if (watchdog_init_timeout(&edev->wdd, heartbeat, NULL))
-		dev_info(&pdev->dev,
-			"heartbeat value must be " ESB_HEARTBEAT_RANGE
-			", using %u\n", edev->wdd.timeout);
+	watchdog_init_timeout(&edev->wdd, heartbeat, NULL);
 	watchdog_set_nowayout(&edev->wdd, nowayout);
 	watchdog_stop_on_reboot(&edev->wdd);
 	watchdog_stop_on_unregister(&edev->wdd);
-- 
2.11.0

