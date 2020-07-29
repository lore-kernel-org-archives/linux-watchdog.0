Return-Path: <SRS0=BU60=BI=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8E5C433E3
	for <linux-watchdog@archiver.kernel.org>; Wed, 29 Jul 2020 16:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16BD22B48
	for <linux-watchdog@archiver.kernel.org>; Wed, 29 Jul 2020 16:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596039084;
	bh=uLH0k9yXld4hTNdbwWzAjYudxsPRRnlkO31c2TpKt3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R37DbocTcbnoq7a3Hc4Y9xQiQnG3LatbnDPrfj63rArtq/uxGMXJoGNiqiuSQdpuk
	 kmsYCFAMKMrap246dh82oCf3hSOUMZA6t8b0d++sN5653Jdg59Mxc7XoqJqy90GLD0
	 of8xWGswodoX4j3isyn5DY1K8boV+X5TtiQ9bc+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgG2QLX (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgG2QLX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Jul 2020 12:11:23 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C3E22B47;
        Wed, 29 Jul 2020 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596039082;
        bh=uLH0k9yXld4hTNdbwWzAjYudxsPRRnlkO31c2TpKt3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N9Eu/5fddM7rBP4snpAEvafBY+ZSF2PxObcc7VZxzMvYFEj18yxP/nekXpYIQcAtw
         +rcZJ+tpc1bnNwUlIt1Yonig8p512LdVgFmNKe2ibTSChLaZnQ33xiVr1+3h1Q8EU1
         /Z3SeqKWKq+cGoh3+D4GEgZSZRyJxRwoCKUbRrGs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vincent Sanders <vince@simtec.co.uk>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        patches@opensource.cirrus.com, linux-clk@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Sergio Prado <sergio.prado@e-labworks.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Cedric Roux <sed@free.fr>, Lihua Yao <ylhuajnu@outlook.com>
Subject: [PATCH 4/7] ARM: samsung: Fix language typo
Date:   Wed, 29 Jul 2020 18:09:39 +0200
Message-Id: <20200729160942.28867-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729160942.28867-1-krzk@kernel.org>
References: <20200729160942.28867-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Fix Complie -> Compile

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/plat-samsung/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 301e572651c0..43a8b2bd16ff 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -154,7 +154,7 @@ config S3C_DEV_WDT
 	bool
 	default y if ARCH_S3C24XX
 	help
-	  Complie in platform device definition for Watchdog Timer
+	  Compile in platform device definition for Watchdog Timer
 
 config S3C_DEV_NAND
 	bool
@@ -169,7 +169,7 @@ config S3C_DEV_ONENAND
 config S3C_DEV_RTC
 	bool
 	help
-	  Complie in platform device definition for RTC
+	  Compile in platform device definition for RTC
 
 config SAMSUNG_DEV_ADC
 	bool
-- 
2.17.1

