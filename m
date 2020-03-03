Return-Path: <SRS0=s/UX=4U=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1A01C3F2C6
	for <linux-watchdog@archiver.kernel.org>; Tue,  3 Mar 2020 10:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C89E24671
	for <linux-watchdog@archiver.kernel.org>; Tue,  3 Mar 2020 10:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgCCKCj (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:02:39 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:38680 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728242AbgCCKCi (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Mar 2020 05:02:38 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 023A1IvJ019843;
        Tue, 3 Mar 2020 12:01:18 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id 20D19603B0; Tue,  3 Mar 2020 12:01:18 +0200 (IST)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, avifishman70@gmail.com,
        tali.perry1@gmail.com, yuenn@google.com, benjaminfair@google.com
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 3/3] watchdog: npcm: remove whitespaces
Date:   Tue,  3 Mar 2020 12:01:14 +0200
Message-Id: <20200303100114.87786-4-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200303100114.87786-1-tmaimon77@gmail.com>
References: <20200303100114.87786-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/watchdog/npcm_wdt.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/npcm_wdt.c b/drivers/watchdog/npcm_wdt.c
index 84a728af6664..bd38bf1ee6a1 100644
--- a/drivers/watchdog/npcm_wdt.c
+++ b/drivers/watchdog/npcm_wdt.c
@@ -123,30 +123,29 @@ static int npcm_wdt_stop(struct watchdog_device *wdd)
 	return 0;
 }
 
-
 static int npcm_wdt_set_timeout(struct watchdog_device *wdd,
 				unsigned int timeout)
 {
 	if (timeout < 2)
 		wdd->timeout = 1;
 	else if (timeout < 3)
-	      wdd->timeout = 2;
+		wdd->timeout = 2;
 	else if (timeout < 6)
-	      wdd->timeout = 5;
+		wdd->timeout = 5;
 	else if (timeout < 11)
-	      wdd->timeout = 10;
+		wdd->timeout = 10;
 	else if (timeout < 22)
-	      wdd->timeout = 21;
+		wdd->timeout = 21;
 	else if (timeout < 44)
-	      wdd->timeout = 43;
+		wdd->timeout = 43;
 	else if (timeout < 87)
-	      wdd->timeout = 86;
+		wdd->timeout = 86;
 	else if (timeout < 173)
-	      wdd->timeout = 172;
+		wdd->timeout = 172;
 	else if (timeout < 688)
-	      wdd->timeout = 687;
+		wdd->timeout = 687;
 	else
-	      wdd->timeout = 2750;
+		wdd->timeout = 2750;
 
 	if (watchdog_active(wdd))
 		npcm_wdt_start(wdd);
-- 
2.22.0

