Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395247;
	b=FT5SbLHvq8q4/Gm/Lo4IDSzsTRF74hy0Gqs/cJT3muZofTEA4406Q1AYmugWRsRVHvVn
	 jjvGgQ3MhbohktmwRvkB5i5rzzpPyeEMHICeqXhpJVLCVBiZ2rOss7+TT6yEVDQEhcJpO
	 JQ5a+gXW+YLaT4ukAfASZLD5V2DbTCX9ZUZHjJacVkACKdYX7yuHoSzAmaeBajyhB29HH
	 PFVfJj3EVvcARX8Yt+AqorI/exYeDN7230K2TyV8EhEgcgCtBYyTKS/IzdkX/9IPg1N1p
	 Stp+9zIV/1DVHY3/dcAN/V+cdZyqpkIO1lFJWeU3ZjtODm75u/FaPBLwdt8af3oVQ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=n7jE022UMmN+ZLB+al6dQVRyXDSvEj4PVxUiWuWub7w=;
	b=jGALux6lyy9Qhtc0kbndFvfJ1iO9Gj6zeumaE1PsnKhWasKM6zupKxffSCqeOn1qsAyL
	 zE8YJgaxG8yIcygKJxVAV/8xC//PZ3a6E1FLjjqUDfSUyMARrpmwP7wlvYdoZSeELbLq7
	 jg8fo+wCLC8pSsNrwF8rBPdWIwxGuyDSHoCl0w1kyps1n4BDstcjkoGH03njG+VVy2mL1
	 vZud4WJRFwHRnDTlfSd622ei/cwNOggHtqOa8XTD79Ho8hgFLjHhdWhv6o0OccJz1/FjA
	 6EYUyVPLNInjl65n0OI+f5cvqXh6q2FRgCd/E2GUI/KwCPiDb11oTP8pjHcxNCs5ihg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KV5BJQEa;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4926D606A8A9
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 11:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4926D606A8A9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KV5BJQEa
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso32406855e9.1
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 03:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395245; x=1795000045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n7jE022UMmN+ZLB+al6dQVRyXDSvEj4PVxUiWuWub7w=;
        b=KV5BJQEaU4htQDaRkbnxr7DuDzj4kgGeEfhToTDv1CrTxoIOjCIvWU3RBgL9h7DIgL
         O6wMLLwkNiBHGmNNJu7Tyy8SwnIl62SQ+7IKS6P6JBf6PoR9tWJptCpon2bwWsWqshKD
         y7JxqYFHyvdoC85pKBsbHEIVXnvHa7S8iQVQ4G6ofsFRtRgVYmQ1jLkhd7XmzWlgVq18
         LFznO4HsikwwUcUedN+JvAlG1eU++1ioINed2uxEzcVV1uQcsWLBDemePUSTN3ecXts2
         cIQfkjI28RD63/5CulQjxKYwgHxd6gcIoULHhGSq7T/TOvB5okJernHgXYLtXyfl9yHd
         YCIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395245; x=1795000045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n7jE022UMmN+ZLB+al6dQVRyXDSvEj4PVxUiWuWub7w=;
        b=m4poy11m05S8i9hrMH5/kNptwLy7V4Hu6o87kOKCU1etLZD2B6UVQtIplnMY39PirN
         3GnAaxtgWIPRbqGsYVssaOlGCW2A86lCaDx8+OqHYkb5UFtUta+tva29dAG6CCxRe2Qa
         smhPRlJ3W2ndau2SxE7m4H4C7UyUuIHKe/6LeI92dGZ2J9jYt6unyw1wlMrS42/CX1S0
         I1BUDxol7YKuDZLurUqw1KFLFio/QLLC4vN4Lbjtft6qEUgQhGZlHtpBbuzQOF3jBmND
         bJurpJGDjCw2ibHdP95ZrPK2zQ7yJUbytnSfcI+TmqbRq5PrrpCP7LvvinFqVXMFtxnU
         Lv8A==
X-Forwarded-Encrypted: i=1; AL+hErF5hPdurMcTNVitwGVV9hUMwjXyPi8KOLufJKxNkN/MKfPTVsu+LwBvNVsDfcYuRMFfOgbx6VUcWbyaQAZGcQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+HbNx6MfVrpFcj0tuwSzrwgu7GjZeCG8HmpL85+J+RQTUPvkSs
	JYQC3ucIYUegSPrCvpmrCILTfr2NEin82D7WpkwZZhI97uFbhBwnXLjn
X-Gm-Gg: AYBFou28Ee8ioP3XJFKNnX34cKjfl3/C0w4ctWG/Ffg12HAdGtGDaktLIDolEnJQENs
	FT3mo3x8jdpLPGddYfaQLALwn92VPi61sGRsULMY/TaoY2irkf5v14I2iSZYLR2WmYGZA7L+2yr
	pShIGEwoP3EtO4faelo/o1PVHjsrvMx45LAS6/2hJTb0l3ekhWoDZ0ap5aJ7ejtDQ2/twh4k6IP
	cjjFJ4TBa6tOHMmK7535nLbN/Slc3Sughl6zzF8xzANUZ3Ec9ABOmBwh/sI0sf6KWtcDoKJM6pd
	9/JaWgD+3Qiuvf9SDW81SIZdSPukES6Na/XabQyfF06W47HT0kXKi7JkZlm5ae3DPldq7992bor
	XeNdcDXDyvDfWCFgSxlj/jCogi9wJbd2mgY/YJpr4Mo7Mgv/8yjZ2q+Z7SMk0VILlF8HuxuTEKT
	wOF37j3XaQB8oNayWuVKq5PDYg+lAD3gy6XVDukbP7dTZi7N96BkoJhYrBsa56RHkaGangUGmNt
	vYr8AVqjr9Dcz6bybwR93EPb/0G6zM8W3rtRPnGt9lxxHTPyEFMkBP7d+SMNTWXpWVPD4yurNwl
	Q4BLiW2y0EL2C89NezynkTPMMiC8lwNUXR2TX2CdYGVaFCZbj4wfgcy1OoiVg9yd3oftwJC8AAC
	dUXXtyyFcOAbpIPpqPvTqF599TdcvLadecK63+mABUxn81HDfBj5+IVf4GunvfInw0JTODyYmUS
	NO2sk6iDrJ
X-Received: by 2002:a05:600c:4f10:b0:4b6:267a:dd6e with SMTP id 5b1f17b1804b1-4ba093c53e1mr41140325e9.28.1794395244647;
        Wed, 11 Nov 2026 03:07:24 -0800 (PST)
Received: from iku.example.org ([2a00:23c8:254f:fd01:783d:786e:fe55:f40d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm146727295e9.5.2026.11.11.03.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:07:24 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v9 4/4] arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
Date: Wed, 11 Nov 2026 11:07:00 +0000
Message-ID: <20261111110700.3331225-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261111110700.3331225-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111110700.3331225-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCR registers for wdt0-wdt5 reside in the second register region of
the CPG/MSSR block. This multi-function block is now exposed via a unified
syscon regmap interface.

Replace the direct mapping of the individual WDTDCR registers with the
new "renesas,sysc" phandle property pointing to the CPG/MSSR block syscon
node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v8->v9:
- No change

v7->v8:
- No change

v6->v7:
- No change

v5->v6:
- No change

v4->v5:
- Added review-by tag.

v3->v4:
- No change

v2->v3:
- Renamed the "renesas,sys" property to "renesas,sysc"
- Updated commit message

v1->v2:
- No change.
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 243b851cc0f1..9056df917a2e 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
@@ -327,61 +327,61 @@ channel1 {
 
 		wdt0: watchdog@80082000 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082000 0 0x400>,
-			      <0 0x81295100 0 0x04>;
+			reg = <0 0x80082000 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 0>;
 			status = "disabled";
 		};
 
 		wdt1: watchdog@80082400 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082400 0 0x400>,
-			      <0 0x81295104 0 0x04>;
+			reg = <0 0x80082400 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 1>;
 			status = "disabled";
 		};
 
 		wdt2: watchdog@80082800 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082800 0 0x400>,
-			      <0 0x81295108 0 0x04>;
+			reg = <0 0x80082800 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 2>;
 			status = "disabled";
 		};
 
 		wdt3: watchdog@80082c00 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80082c00 0 0x400>,
-			      <0 0x8129510c 0 0x04>;
+			reg = <0 0x80082c00 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 3>;
 			status = "disabled";
 		};
 
 		wdt4: watchdog@80083000 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80083000 0 0x400>,
-			      <0 0x81295110 0 0x04>;
+			reg = <0 0x80083000 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 4>;
 			status = "disabled";
 		};
 
 		wdt5: watchdog@80083400 {
 			compatible = "renesas,r9a09g087-wdt", "renesas,r9a09g077-wdt";
-			reg = <0 0x80083400 0 0x400>,
-			      <0 0x81295114 0 0x04>;
+			reg = <0 0x80083400 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G087_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sysc = <&cpg 5>;
 			status = "disabled";
 		};
 
-- 
2.56.1

