Return-Path: <linux-watchdog-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42EDCD98E3
	for <linux-watchdog@archiver.kernel.org>; Tue, 10 Oct 2023 22:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbjJJWux (ORCPT
        <rfc822;linux-watchdog@archiver.kernel.org>);
        Tue, 10 Oct 2023 18:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344258AbjJJWua (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Oct 2023 18:50:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73019B
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Oct 2023 15:50:15 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3231df054c4so5644272f8f.0
        for <linux-watchdog@vger.kernel.org>; Tue, 10 Oct 2023 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696978214; x=1697583014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8meY4ujs++mlEMDCBMyLTigrPdJt2G7ihVPbm8apfRA=;
        b=PLxmRHczcbsNwPjUcY51WwgStUOpijp3hkmgJ9oekzZlnvdEkpKpDKz0rD0tQfifR2
         lt1YyFmq3zFGotTvk/9RiPpESiWSCqY+twuDEbc081Ganm5ofIFePO/AcW26e+CbJkuR
         eStSzuit3IpQYhDRmFgFY3qrfKLKDnCbTr9vfq3WIgVfXmNCLYvleBChMLgxCPYNDXqe
         xXYhSwlsusPzSHp5S7GEPQ0GJJLWEmCx/B7RWgc1RFGOm5tQFcq4cxeTpKiPPch5vIv8
         AZs2V9oV0CB8iViCFs+QzDKQg+/DYrwFPnc1LyVwiMTxe+v8YduMlOdnFbHLWCPYI83p
         ixVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696978214; x=1697583014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8meY4ujs++mlEMDCBMyLTigrPdJt2G7ihVPbm8apfRA=;
        b=ZyqN2hf7HVzs68MmJONade+fUwLpCnsgD5swbC6ASYqMSMIwYud50DO7tCSUBYQq1Z
         Xxe9oOXQv/JJp0l09uwPcOQHe/Ngq+JZs1qrVLxLTEOPYlauwx1C9Andz5mboK2MC+Pf
         YnWgKVO8RS10Wxf3usM3Fjx6ODBBgwbK+/BRyOmw5Fkvu1GlzVKeHCULP2T/5nLRDDlE
         8m0kE+lpsLg9IFIWBiNlTNuYpHja1m1C4bvA4Wy7INi03RsvsL3f3gQt8QbBwP4/4cHW
         2HUy+3p5vGiQ+zvvqfWUrULGKCErY/eYlEbMUQI93kgrJEY0tM9s8K9CiZnu5UWf5Yv8
         x+hw==
X-Gm-Message-State: AOJu0YyfBGBzuxl/6Lkwg9CnQpEvzI86s4lyP/tq8GBGUGgzKil2t2Au
        M2Hf29pZMvADdX3BpjwUb6VUaA==
X-Google-Smtp-Source: AGHT+IHVgNRfg9MJFj2fa8ZrT5Dql+nbZeDpWThiGHWgaXBzyVYZ59F732rF5W+8jo4YKOodKbt5oQ==
X-Received: by 2002:a5d:680d:0:b0:319:83e4:bbbf with SMTP id w13-20020a5d680d000000b0031983e4bbbfmr18331182wru.20.1696978214311;
        Tue, 10 Oct 2023 15:50:14 -0700 (PDT)
Received: from gpeter-l.lan (host-92-12-225-146.as13285.net. [92.12.225.146])
        by smtp.gmail.com with ESMTPSA id j13-20020adfe50d000000b003196b1bb528sm13689547wrm.64.2023.10.10.15.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 15:50:13 -0700 (PDT)
From:   Peter Griffin <peter.griffin@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, conor+dt@kernel.org, sboyd@kernel.org,
        tomasz.figa@gmail.com, s.nawrocki@samsung.com,
        linus.walleij@linaro.org, wim@linux-watchdog.org,
        linux@roeck-us.net, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, olof@lixom.net, cw00.choi@samsung.com
Cc:     peter.griffin@linaro.org, tudor.ambarus@linaro.org,
        andre.draszik@linaro.org, semen.protsenko@linaro.org,
        saravanak@google.com, willmcvicker@google.com, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        kernel-team@android.com, linux-serial@vger.kernel.org
Subject: [PATCH v2 19/20] arm64: defconfig: Enable Google Tensor SoC
Date:   Tue, 10 Oct 2023 23:49:27 +0100
Message-ID: <20231010224928.2296997-20-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231010224928.2296997-1-peter.griffin@linaro.org>
References: <20231010224928.2296997-1-peter.griffin@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-watchdog.vger.kernel.org>
X-Mailing-List: linux-watchdog@vger.kernel.org

Add the Google Tensor SoC to the arm64 defconfig

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 5315789f4868..8a34603b1822 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -41,6 +41,7 @@ CONFIG_ARCH_BCMBCA=y
 CONFIG_ARCH_BRCMSTB=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS=y
+CONFIG_ARCH_GOOGLE_TENSOR=y
 CONFIG_ARCH_SPARX5=y
 CONFIG_ARCH_K3=y
 CONFIG_ARCH_LG1K=y
-- 
2.42.0.609.gbb76f46606-goog

