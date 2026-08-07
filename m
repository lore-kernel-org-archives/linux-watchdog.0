Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4CE391832
	for <linux-watchdog@vger.kernel.org>; Fri,  7 Aug 2026 08:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090629; cv=none; b=QUYXQIGG6gArS8o0U3814MM4hUSithvlMD8w6mLWz+AsHoXDL01ekSP0yp0NINVGrmOrRQdPKVu+GqndW7PsVMFGhOIjmOwvvf18Tgo5UX0UUGjLrWXPcB4TpHJyhHTM8TaaQo3/k96NJMzNhPW+ECp6s7xy638ZFdBiiWJmImc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090629; c=relaxed/simple;
	bh=plo6tBu8X2ctkZExTJI8GrKt9edUDqw8X8oOIBpFgLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujeNumq90mEx9LS+kjqyCPuHk9pZf1ywpvcWXaZX3BI3oX/9kTYD9jE0+PhqxDhuMDT/zR+hW2tEZe6hjGgm1TaNdCY1xI74hgWyQHVU/cYZPpmwmhqZe+b+nepuKaP9dGqDmKSjsobyzUlITLOL0KLy2dyhrxf4SHYOYorwj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8pnuMOw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8pnuMOw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so2112013a91.1
        for <linux-watchdog@vger.kernel.org>; Fri, 07 Aug 2026 01:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786090628; x=1786695428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Og8epPMT2luMUJBXRpFI2/AU8UKubYJ4m2A5JNHJ56Y=;
        b=a8pnuMOwU0c+SIrY59DMP/uxPgMIXDjgh0UigxbpyRSq8TGCHvvJ+Kl0nbQKqMuNhs
         dYLtngw5vRD3+uPTMGHl+2wl6tl38juudlODNftMnma+vvPtzP64NnlT1NE6dCQ+4BoU
         Emm65mJl+oSYTW0QkmvGFXp3AadJ6VQkUIHMKpCLRbyLMW+RhoigxoOHW2lY0D9Xqo/q
         x3MERB3Dsppj2LU+RxNZdUFZhXPhsT8LEADQHXPG5Tyi6HlhL38u4EbTb6rcHJe9lMJh
         jEHaQKNKRwtFy4s4if4dhYFF8gjooyA6eXaqJ8WWTLhNtaQa9J/nhWsNeZ00qfCbZNxK
         KR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786090628; x=1786695428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Og8epPMT2luMUJBXRpFI2/AU8UKubYJ4m2A5JNHJ56Y=;
        b=lrbQd9Uod/i0M5kETR+LtjUiEcd2QIalA9T4FU4C7+qRD4TliLZ7EuisY9DFff/Ms6
         DdNaoa3pHsPHz/6Tb32XHt8KH4WBzva6Nprl4J/LRi54qHcc7TwU7JA0NPHOznYHoIYs
         d+SQv4TliW3WwI62J1ZX66XHIj0W3r1c4GenJItROrQH+5jimjGSCDGuuK70O9I7VubJ
         VRGSESL5yBoTo5yftSFnYbjPuf4VW6hVh+lz2WTjYqLnx6WGNCpE7yLv1cpwU3RKZTbT
         ny7gPEDpsXQ8e9wfoDZVofoVk/3dZSXcIbus+j5IJpD753KBzuCR4DxBKmpfxTaKfMF9
         xfkw==
X-Forwarded-Encrypted: i=1; AHgh+RqEYWFT+QLny+cmkbzVqMmBXXVKJ1ISS/j9rb7T/dnLVKG6ryit0Nhu7rISZeDB/3ifg43oRlIH3xzQDsa+dQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6wqq4Y+KQ7lvWYzi/cXINN5tjgmEUQCh4LhymyU/hgIJXW+pd
	gGlE6T5slk5IypkwIBD482rkKMu1+ksmtR5jETAB2Zc4/lAJBg84yaVw
X-Gm-Gg: AR+sD12f9cQdAGToUWNX3ByMKWq020pLTpeyN175zilDgA79VQmHTkgQ8K5UbDehn9s
	Z5gRJW780D0c/pf278XQngImD21P/MsO289L50f76d4lPRQfelYZdPIedST0n+PnJl8ONQLfEFC
	NLT+2PojhH7QK5Pl7pHQcyxJtjthHY9YYBBuW2VxE2iGFyi+bpEEysamctUnphft/j44h6Mo50q
	W1aXvFYYZi727haBgToRz4q6nbMTLAi5Lnt83ejUFkrI4I4e230iQ56cDlZfPi829KgeKF1xdjv
	rB10I4vRxCtYBmkWNVIz6Ib2grNqCVAh8+dQSw8Ha/h8G+S0MKhkRXFeSlJR4161RCMCwyX5G2U
	2ToTikweD6Nm1HZC6D3xLDIpaDep9BuTg/ctD5XqxS+uxqPMG/HXjPKPNJhZT5ISVAxnTiR+vhO
	WpBxzAnoyevG3ONcGikGA4nMc52+Ps3nw2+yYABTsM4AxJsfLSxpe10qYscnVVpjOzk6QAa4cT3
	JhANRiVN1rvV3VhNIXLpcC59k2hRGBM2lFAy+l6B/PxaKSuBGfnjUhdic4C6wzCENlackhsXNxg
	7BLkt/b1z/lhD9w=
X-Received: by 2002:a17:90b:51ca:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-3909d79f8f5mr8625493a91.3.1786090627565;
        Fri, 07 Aug 2026 01:17:07 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de8ddcsm3913377a91.6.2026.08.07.01.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:17:07 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/4] watchdog: qcom: Propagate errors from optional IRQ lookup
Date: Fri,  7 Aug 2026 15:16:49 +0700
Message-ID: <20260807081652.38692-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

platform_get_irq_optional() returns a positive IRQ number on success or
a negative error code on failure. For an optional IRQ, -ENXIO indicates
that no IRQ is available, while other errors should be propagated.

Instead of only checking for -EPROBE_DEFER, propagate all error codes
returned by platform_get_irq_optional() other than -ENXIO, so that
failures are properly reported to the caller.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/watchdog/qcom-wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 49bd04841f0c..a8eb1d8f24f0 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -298,8 +298,8 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		wdt->wdd.info = &qcom_wdt_pt_info;
 		wdt->wdd.pretimeout = 1;
 	} else {
-		if (irq == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (irq != -ENXIO)
+			return irq;
 
 		wdt->wdd.info = &qcom_wdt_info;
 	}
-- 
2.43.0

