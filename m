Return-Path: <SRS0=ZOXR=CK=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C23C433E6
	for <linux-watchdog@archiver.kernel.org>; Tue,  1 Sep 2020 16:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2BA206EF
	for <linux-watchdog@archiver.kernel.org>; Tue,  1 Sep 2020 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977773;
	bh=2TOcs6pEYZ/R2ZwIOWWycu5Eesv8Cv5fL5GCe6HBCDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v7Od9ZrC8cP7cY1wdI6irFEBJwPX7fAKkJo9iSCLT5b/XutkUGE5MmHY8Q67ZSqAG
	 teW5X3bmes2X+Ertn/edpvWmLlwfwqcc5rFKRGQc5UHanq1FeVzlDnPhrm1npmH8SD
	 6MVeuxuHYRCDQAQNsILGo9TdLmJ2J6l3WkVevtgI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgIAQ3F (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730828AbgIAPb7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 1 Sep 2020 11:31:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473702158C;
        Tue,  1 Sep 2020 15:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974319;
        bh=2TOcs6pEYZ/R2ZwIOWWycu5Eesv8Cv5fL5GCe6HBCDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O4OLORC3rltkj827+yJajf2QcHJtT2oxnZTQsXi20OKUSQHgCT+wj0aGLff3EXq8i
         nEtnJJJa63q1o7Dh3ts6vf1NyQn+wMbbX2s3okILwikBh4T+1xFOKTcxCDVWp69XFe
         iaF2jvzo7AN1Rq3uyWHZ/QXW/iMUcTnYKzbB4/dw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] watchdog: davinci: Simplify with dev_err_probe()
Date:   Tue,  1 Sep 2020 17:31:40 +0200
Message-Id: <20200901153141.18960-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901153141.18960-1-krzk@kernel.org>
References: <20200901153141.18960-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/davinci_wdt.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 2b3f3cd382ef..e6eaba6bae5b 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -206,12 +206,9 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	davinci_wdt->clk = devm_clk_get(dev, NULL);
-
-	if (IS_ERR(davinci_wdt->clk)) {
-		if (PTR_ERR(davinci_wdt->clk) != -EPROBE_DEFER)
-			dev_err(dev, "failed to get clock node\n");
-		return PTR_ERR(davinci_wdt->clk);
-	}
+	if (IS_ERR(davinci_wdt->clk))
+		return dev_err_probe(dev, PTR_ERR(davinci_wdt->clk),
+				     "failed to get clock node\n");
 
 	ret = clk_prepare_enable(davinci_wdt->clk);
 	if (ret) {
-- 
2.17.1

