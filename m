Return-Path: <SRS0=NT8S=EB=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F4CC2D0A3
	for <linux-watchdog@archiver.kernel.org>; Mon, 26 Oct 2020 08:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C90FE223AC
	for <linux-watchdog@archiver.kernel.org>; Mon, 26 Oct 2020 08:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7xNbXh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771232AbgJZIJz (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Mon, 26 Oct 2020 04:09:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38722 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771221AbgJZIJy (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Oct 2020 04:09:54 -0400
Received: by mail-pg1-f194.google.com with SMTP id i26so5319078pgl.5;
        Mon, 26 Oct 2020 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r7+hYfn+gbSeLrAAfhP7X98tPIxZ+UfIaYisMl/0Cuk=;
        b=N7xNbXh7i6ECJp2De64rcZn7TNhAcIQ5rNbsSa5K1K0hSjYYtCJSSDwDeIQsBLfIp3
         u+bp8OCR38zSbYZz4IiP3LU26tAi78jMHEDhTH5AX5LJ+GHK6MSn9K+9PSao0Xe3kvvs
         s/Ltivgw0AoUizq9AlX8mPpExgVZbnl0jdoNfeUH+p4qgixYXmIkoTGhQ0kygPavqGbi
         MhOrumdOQ/Ave531LoEWE7F9RAZ+u5Nl4AKIh3bGupCyRxGmM+ZYnsT+4s7n/9RCawAg
         uhV2IKuMv1KVkUW5nEEJCBEAhcdKKRBNEteI30j6FAZtCcnYhOOtV3gxaVudKk7QUZl5
         NcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r7+hYfn+gbSeLrAAfhP7X98tPIxZ+UfIaYisMl/0Cuk=;
        b=Jegajih3Lu1PctkwpuvyPgigDllLw9PKJSJ7YHt+GCcuvZ+y29nSzNV6JuqLa60wYi
         XJynPLdfKrOIXiR1bJ5K57jCwF5mDbMZlN1hc4G3nmV919s+U65y95RZRVWDF8A31X93
         wuBKPf/XYXGTrJvQ5kmLSrSCqQ+drLJzf1Cq5B1ZwZCZuZtQau6U4GEjXICpqDFOq7bl
         lGfL+RVRzDo21111Hrd2udY65XMqVBaSnk7sviB5GSiEH46LUdECS5ovMTvH3DZGwRAG
         iaXKWEzPVN+RxmWmzgLIdoak14hdX137RzYC/Oo5HMhNyu4/7ETruFNs5+q9N8TG2JvN
         aV3Q==
X-Gm-Message-State: AOAM532/KGno3nA1996dgCm9EvfON7fRx5OdfMMf2jaavT5CSM8nysAV
        YrBTDUBSbjUMnUQDPwooCk8=
X-Google-Smtp-Source: ABdhPJwN6e0Xq0ARGK5+rVycn4cMrVwi1rpBUFn+xzN2qNxTYUhk8ed7nwiG+tQIsG83Q3MtbB1WUA==
X-Received: by 2002:a65:5c86:: with SMTP id a6mr15148191pgt.227.1603699792318;
        Mon, 26 Oct 2020 01:09:52 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id j2sm542825pgi.48.2020.10.26.01.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 01:09:51 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH 3/3] watchdog: sprd: check busy bit before kick watchdog
Date:   Mon, 26 Oct 2020 16:09:19 +0800
Message-Id: <20201026080919.28413-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201026080919.28413-1-zhang.lyra@gmail.com>
References: <20201026080919.28413-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Lingling Xu <ling_ling.xu@unisoc.com>

As the specification described, checking busy bit must be done before kick
watchdog.

Fixes: 477603467009 ("watchdog: Add Spreadtrum watchdog driver")
Signed-off-by: Lingling Xu <ling_ling.xu@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/watchdog/sprd_wdt.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index 4f2a8c6d6485..14071c66ff49 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -108,20 +108,8 @@ static int sprd_wdt_load_value(struct sprd_wdt *wdt, u32 timeout,
 	u32 tmr_step = timeout * SPRD_WDT_CNT_STEP;
 	u32 prtmr_step = pretimeout * SPRD_WDT_CNT_STEP;
 
-	sprd_wdt_unlock(wdt->base);
-	writel_relaxed((tmr_step >> SPRD_WDT_CNT_HIGH_SHIFT) &
-		      SPRD_WDT_LOW_VALUE_MASK, wdt->base + SPRD_WDT_LOAD_HIGH);
-	writel_relaxed((tmr_step & SPRD_WDT_LOW_VALUE_MASK),
-		       wdt->base + SPRD_WDT_LOAD_LOW);
-	writel_relaxed((prtmr_step >> SPRD_WDT_CNT_HIGH_SHIFT) &
-			SPRD_WDT_LOW_VALUE_MASK,
-		       wdt->base + SPRD_WDT_IRQ_LOAD_HIGH);
-	writel_relaxed(prtmr_step & SPRD_WDT_LOW_VALUE_MASK,
-		       wdt->base + SPRD_WDT_IRQ_LOAD_LOW);
-	sprd_wdt_lock(wdt->base);
-
 	/*
-	 * Waiting the load value operation done,
+	 * Waiting the last load value operation done,
 	 * it needs two or three RTC clock cycles.
 	 */
 	do {
@@ -134,6 +122,19 @@ static int sprd_wdt_load_value(struct sprd_wdt *wdt, u32 timeout,
 
 	if (delay_cnt >= SPRD_WDT_LOAD_TIMEOUT)
 		return -EBUSY;
+
+	sprd_wdt_unlock(wdt->base);
+	writel_relaxed((tmr_step >> SPRD_WDT_CNT_HIGH_SHIFT) &
+		      SPRD_WDT_LOW_VALUE_MASK, wdt->base + SPRD_WDT_LOAD_HIGH);
+	writel_relaxed((tmr_step & SPRD_WDT_LOW_VALUE_MASK),
+		       wdt->base + SPRD_WDT_LOAD_LOW);
+	writel_relaxed((prtmr_step >> SPRD_WDT_CNT_HIGH_SHIFT) &
+			SPRD_WDT_LOW_VALUE_MASK,
+		       wdt->base + SPRD_WDT_IRQ_LOAD_HIGH);
+	writel_relaxed(prtmr_step & SPRD_WDT_LOW_VALUE_MASK,
+		       wdt->base + SPRD_WDT_IRQ_LOAD_LOW);
+	sprd_wdt_lock(wdt->base);
+
 	return 0;
 }
 
-- 
2.20.1

