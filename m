Return-Path: <SRS0=RixM=TX=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F8C282DD
	for <linux-watchdog@archiver.kernel.org>; Thu, 23 May 2019 09:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CA52133D
	for <linux-watchdog@archiver.kernel.org>; Thu, 23 May 2019 09:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbfEWJ3s (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 23 May 2019 05:29:48 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:10869 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWJ3s (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 23 May 2019 05:29:48 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4N9TiJN043746;
        Thu, 23 May 2019 18:29:44 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Thu, 23 May 2019 18:29:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from localhost (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4N9TdJr043711
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 18:29:44 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
From:   Nguyen An Hoan <na-hoan@jinso.co.jp>
To:     linux-renesas-soc@vger.kernel.org, geert+renesas@glider.be,
        linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux@roeck-us.net, wsa+renesas@sang-engineering.com
Cc:     kuninori.morimoto.gx@renesas.com, yoshihiro.shimoda.uh@renesas.com,
        h-inayoshi@jinso.co.jp, cv-dong@jinso.co.jp
Subject: [PATCH] watchdog: renesas_wdt: Fix interrupt enable for timer
Date:   Thu, 23 May 2019 18:29:37 +0900
Message-Id: <1558603778-20848-1-git-send-email-na-hoan@jinso.co.jp>
X-Mailer: git-send-email 2.7.4
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Hoan Nguyen An <na-hoan@jinso.co.jp>

Fix setting for bit WOVFE of RWTCSRA. Keep it enable follow hardware document.

Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
---
 drivers/watchdog/renesas_wdt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 565dbc1..a6aca0e 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -19,6 +19,7 @@
 
 #define RWTCNT		0
 #define RWTCSRA		4
+#define RWTCSRA_WOVFE	BIT(3)
 #define RWTCSRA_WOVF	BIT(4)
 #define RWTCSRA_WRFLG	BIT(5)
 #define RWTCSRA_TME	BIT(7)
@@ -82,13 +83,14 @@ static int rwdt_start(struct watchdog_device *wdev)
 	rwdt_write(priv, val, RWTCSRA);
 
 	rwdt_init_timeout(wdev);
-	rwdt_write(priv, priv->cks, RWTCSRA);
+	val |= priv->cks;
+	rwdt_write(priv, val, RWTCSRA);
 	rwdt_write(priv, 0, RWTCSRB);
 
 	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
 		cpu_relax();
-
-	rwdt_write(priv, priv->cks | RWTCSRA_TME, RWTCSRA);
+	/* Enable interrupt and timer */
+	rwdt_write(priv, val | RWTCSRA_WOVFE | RWTCSRA_TME, RWTCSRA);
 
 	return 0;
 }
-- 
2.7.4

