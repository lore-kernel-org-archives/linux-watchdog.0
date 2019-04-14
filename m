Return-Path: <SRS0=S62/=SQ=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082D4C10F13
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBA62148E
	for <linux-watchdog@archiver.kernel.org>; Sun, 14 Apr 2019 10:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbfDNKDV (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:03:21 -0400
Received: from sauhun.de ([88.99.104.3]:60932 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfDNKDV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 14 Apr 2019 06:03:21 -0400
Received: from localhost (p5486CDCF.dip0.t-ipconnect.de [84.134.205.207])
        by pokefinder.org (Postfix) with ESMTPSA id 203282CF687;
        Sun, 14 Apr 2019 12:03:18 +0200 (CEST)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-watchdog@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] watchdog: renesas_wdt: drop superfluous glob pattern
Date:   Sun, 14 Apr 2019 12:03:06 +0200
Message-Id: <20190414100306.1221-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

If we want to match all revisions, it is enough to leave the field
empty.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Only build tested, no HW. Found by code review.

 drivers/watchdog/renesas_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 94cd8830ba9a..565dbc1ec638 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -151,7 +151,6 @@ static const struct soc_device_attribute rwdt_quirks_match[] = {
 		.data = (void *)1,	/* needs single CPU */
 	}, {
 		.soc_id = "r8a7792",
-		.revision = "*",
 		.data = (void *)0,	/* needs SMP disabled */
 	},
 	{ /* sentinel */ }
-- 
2.11.0

