Return-Path: <SRS0=q9YU=EE=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDDEC55179
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Oct 2020 07:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A123620EDD
	for <linux-watchdog@archiver.kernel.org>; Thu, 29 Oct 2020 07:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsgIMHwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbgJ2H4Y (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgJ2HyI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Oct 2020 03:54:08 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B39C0613D5;
        Thu, 29 Oct 2020 00:54:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so1651641pfa.10;
        Thu, 29 Oct 2020 00:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=45WrHfAKbdYHjpbC20AMO5osfugbGDlzHaoUzU5Icuo=;
        b=tsgIMHwo30bupNgyRYBxQu2rGAfExKotwCphoybjhufKRCTb3vJjtsAJJRcXjKXvD6
         LRTFzBRuz3x95vTMXb8osjf93WFT5UR6Bs/VHkhu3r5z7w1+yRur1hslaq3eobRenbYe
         6V8kG40I7rI6J6KchdjtOqMHhifU6t9nHd1YYeMzMOrKBp+0dbeE+I9ohPgj8h8oJZYV
         cU6v80uAlvJwWelSuQFgrl9AxBXVCpNilmSjDW9++G8ZuczFzdjG+C9q5boqW+tISfOF
         Mw1PYGFmsgt4oZZbHm/ql1hyE4mwyudvcuq16AC0kjhn/hEhB3NvsSwXn1icU8S0FTFY
         c6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=45WrHfAKbdYHjpbC20AMO5osfugbGDlzHaoUzU5Icuo=;
        b=FKQcm6wRpL4fpLVKnTIs8C1WWylrlhW+mKobrw2qp3b87kXcGsACVBIjSdVcP/5YWK
         eSzxq7/yU1EZ13Hekjr7bosG/uclO/9LAICQBu31S0lmdmKckoFCWmRxb8BE7w8+dOf0
         HZ5sJePmBrOmBzNcQaZ4P3lfD2nJD0nCpgX3zW8/4OqxubygnCmCzk5qnwnZXBRR4zdC
         C2xCy5J9nGsmvj789JLwaD/61Xu4ms5QtswDzIJixWuIaNVzPC8qdKPTCuYQWXH5s2r9
         maciq51PXj1Aiynay7Wg7Zd7gxhDBbobJvP+t0QX9m4c9J0N2DhYfKHTHaiAJ1gHYQvF
         PBIQ==
X-Gm-Message-State: AOAM530lKCIg0FdB93aQa7t4WkWRQRzInHmsU8TKQPHM8Q/0Eiv3Q6yY
        p/NxDTg6u6l1QDYWaKqNwug=
X-Google-Smtp-Source: ABdhPJx99n1MhtdolJkw34LO55uySelHItQmK6db7xOJvZRohQV+1cIV/6MP4ynkPxX2n4qvV/sq2A==
X-Received: by 2002:a63:f40a:: with SMTP id g10mr3027586pgi.66.1603958047062;
        Thu, 29 Oct 2020 00:54:07 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id 65sm1573098pge.37.2020.10.29.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:54:06 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Barry Song <baohua@kernel.org>,
        linux-watchdog@vger.kernel.org (open list:WATCHDOG DEVICE DRIVERS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/CSR SIRFPRIMA2
        MACHINE SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] watchdog: sirfsoc_wdt: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:53:27 +0800
Message-Id: <20201029075327.228570-3-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029075327.228570-1-coiby.xu@gmail.com>
References: <20201029075327.228570-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/watchdog/sirfsoc_wdt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 734cf2966ecb..dc8341cd7d44 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -170,7 +170,6 @@ static int sirfsoc_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef	CONFIG_PM_SLEEP
 static int sirfsoc_wdt_suspend(struct device *dev)
 {
 	return 0;
@@ -189,7 +188,6 @@ static int sirfsoc_wdt_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(sirfsoc_wdt_pm_ops,
 		sirfsoc_wdt_suspend, sirfsoc_wdt_resume);
-- 
2.28.0

