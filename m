Return-Path: <SRS0=JgZz=77=vger.kernel.org=linux-watchdog-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006A2C433DF
	for <linux-watchdog@archiver.kernel.org>; Thu, 18 Jun 2020 02:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96F420853
	for <linux-watchdog@archiver.kernel.org>; Thu, 18 Jun 2020 02:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446566;
	bh=H567rIveBQagBeIyCQT4uZJ6nC8iGaFQT5iuc7GH3jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VJFcQA+BpYqEQ6RGRaXWn5kNZBHpx+Ysz8JnZ4b6hPtm3aCdZoEL7fBJp07BsbuAa
	 ujBNGiiXFALo5hx+F1Z2zW21loma//c6R3lX5iQdgkC8qPnftASHBf3f1fV3oVtLI+
	 82346vn7PLDn0W2Kk5oBcKPGK0qPkHA7OKhemyG4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgFRCQF (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:16:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730298AbgFRBUX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 17 Jun 2020 21:20:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB57620663;
        Thu, 18 Jun 2020 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443222;
        bh=H567rIveBQagBeIyCQT4uZJ6nC8iGaFQT5iuc7GH3jU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bgu7DCubv2KG0ZuA1MKNueFPurf1cfXwc7EOtE7RQWp3G/Q3E/Nq5jFV2zaBqhz0x
         y7wz3mCa2x3B5lYX6/jBJQKKPOJE96sqbWPtdIJluRXMOSz/U/l5pMj++MUf+Ahtcv
         qCftXpK7fnZPQArPrp8EPWRUiBxy6QiV7YoRnJZM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stefan Riedmueller <s.riedmueller@phytec.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>, linux-watchdog@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 177/266] watchdog: da9062: No need to ping manually before setting timeout
Date:   Wed, 17 Jun 2020 21:15:02 -0400
Message-Id: <20200618011631.604574-177-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

From: Stefan Riedmueller <s.riedmueller@phytec.de>

[ Upstream commit a0948ddba65f4f6d3cfb5e2b84685485d0452966 ]

There is actually no need to ping the watchdog before disabling it
during timeout change. Disabling the watchdog already takes care of
resetting the counter.

This fixes an issue during boot when the userspace watchdog handler takes
over and the watchdog is already running. Opening the watchdog in this case
leads to the first ping and directly after that without the required
heartbeat delay a second ping issued by the set_timeout call. Due to the
missing delay this resulted in a reset.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Link: https://lore.kernel.org/r/20200403130728.39260-3-s.riedmueller@phytec.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/da9062_wdt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index e92f38fcb7a4..1b9bcfed39e9 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -55,11 +55,6 @@ static int da9062_wdt_update_timeout_register(struct da9062_watchdog *wdt,
 					      unsigned int regval)
 {
 	struct da9062 *chip = wdt->hw;
-	int ret;
-
-	ret = da9062_reset_watchdog_timer(wdt);
-	if (ret)
-		return ret;
 
 	regmap_update_bits(chip->regmap,
 				  DA9062AA_CONTROL_D,
-- 
2.25.1

