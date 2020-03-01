Return-Path: <SRS0=wJ0A=4S=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE3C3F2D1
	for <linux-watchdog@archiver.kernel.org>; Sun,  1 Mar 2020 10:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA4A4214DB
	for <linux-watchdog@archiver.kernel.org>; Sun,  1 Mar 2020 10:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgCAKIP (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Sun, 1 Mar 2020 05:08:15 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:38444 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725768AbgCAKIP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 1 Mar 2020 05:08:15 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 0219ehYm028747;
        Sun, 1 Mar 2020 11:40:43 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id C7D2660330; Sun,  1 Mar 2020 11:40:43 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, avifishman70@gmail.com,
        tali.perry1@gmail.com, yuenn@google.com, benjaminfair@google.com
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 2/4] watchdog: npcm: add restart priority support
Date:   Sun,  1 Mar 2020 11:40:38 +0200
Message-Id: <20200301094040.123189-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200301094040.123189-1-tmaimon77@gmail.com>
References: <20200301094040.123189-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add NPCM watchdog restart priority support.
The default restart priority is 128.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/watchdog/npcm_wdt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 9c773c3d6d5d..8609c7acf17d 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -181,6 +181,7 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct npcm_wdt *wdt;
+	u32 priority;
 	int irq;
 	int ret;
 
@@ -196,6 +197,11 @@ static int npcm_wdt_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
+	if (of_property_read_u32(pdev->dev.of_node, "nuvoton,restart-priority", &priority))
+		watchdog_set_restart_priority(&wdt->wdd, 128);
+	else
+		watchdog_set_restart_priority(&wdt->wdd, priority);
+
 	wdt->wdd.info = &npcm_wdt_info;
 	wdt->wdd.ops = &npcm_wdt_ops;
 	wdt->wdd.min_timeout = 1;
-- 
2.22.0

