Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC9DC282E6
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C76820848
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfDNK0h (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:26:37 -0400
Received: from sauhun.de ([88.99.104.3]:32914 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfDNK0g (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 06:26:36 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id 005004A135E;
        Sun, 14 Apr 2019 12:26:34 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 06/16] watchdog: hpwdt: drop warning after calling watchdog_init_timeout
Date:   Sun, 14 Apr 2019 12:26:17 +0200
Message-Id: <20190414102627.5564-7-wsa+renesas@sang-engineering.com>
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
 drivers/watchdog/hpwdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ef30c7e9728d..db1bf6f546ae 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -311,8 +311,7 @@ static int hpwdt_init_one(struct pci_dev *dev,
 		goto error_init_nmi_decoding;
 
 	watchdog_set_nowayout(&hpwdt_dev, nowayout);
-	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
-		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
+	watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL);
 
 	if (pretimeout && hpwdt_dev.timeout <= PRETIMEOUT_SEC) {
 		dev_warn(&dev->dev, "timeout <= pretimeout. Setting pretimeout to zero\n");
-- 
2.11.0

