Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F34CA292
	for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 18:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778525476; cv=none; b=DT61O669JZnGNMf5K6AB/9lfgefERDh8qYJkwcKZggu5vDdL0mNaONr/Z0WDa4lx2vahsXMo5Gkpp9Y46eCdCKhjSw2FdQ2QdHmWIUuGUa8NOQo/WxJa1tD/a0u50u+OXmOvhQRwwH/fhI2rNlLWCfkz7E5fjGJWPTNchoR/VWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778525476; c=relaxed/simple;
	bh=gsf8O/A4uFSb5xiWCs8Lvej9IiVzo6qsPV5Xik3YnM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tEs2RZLTyiAT1+gN1v9ULPKol94zw8dmQp6wx2uhG1L8wrvN/dE3ACTF4WUTJDbzaR8V6v/hrSfzUVi9imBjhTlZ1By1lVG1SoDztC3ipBO0ACnlH0X+I4XEwxWZ8sdeBEvkTawrEdDFdJrJHo7eqbBj0KlV7qF1CI4xoWwmMZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iW8fr/QJ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iW8fr/QJ"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2538878f8f.1
        for <linux-watchdog@vger.kernel.org>; Mon, 11 May 2026 11:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778525472; x=1779130272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVviRRXyOpOFqlFXNeMmtSmK6+R7+16vmQsfofx/k+I=;
        b=iW8fr/QJHIGZrqwSG9m2vdDynRDk4XZ9gDphPceMVvXcAndcHtWTMyfaKrMuJRZZvk
         HSWyWGrH2ZeJK6MYOcb9xheOOQrgREkwe01fISC0p7UFXs15HfSfgHZNTaOfGhecVRt3
         djtXXUBMT5swzisvwnuWAouDLoMu0STFMhuWjWwwjbeF5KAt+MRPZsedZCZqxFr3G5Cb
         WRbQo/TgY/P8oXnFov/vzKw1pw3UgOn2CGkgswniulACvCame7PghkMKv6n/7k1NVwxA
         73WxA2Eff8Oc3q45c7QNgcokOpUxrxHeTq8tuJipy+UAVP8hqI+3jyyBoyZSmZ+YF7o+
         ljTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778525472; x=1779130272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jVviRRXyOpOFqlFXNeMmtSmK6+R7+16vmQsfofx/k+I=;
        b=stzFNyPokvFtgcdap8XnYPM8CLLVOG++HvihO0L4by4b32QOdUiTvIshEGnshe67xy
         Ld/REXXvRm2eDUALalL0yMdbkqaf5XoT3GMKZLiLumtFf8z6SybJRX7Vk7duAAg69o/d
         c3pHoctuiyDnnPc2fEHrW8sryBBRzOJwzh6EM+hBAKUNz9S1Mf3bcTIc1N6jl/CkUevT
         or8LTHyUwu3luaIWWBDeMFlk2Y+GRlF2r8LEnpdniMsnxpKFgPL9doS/3zu3tkEEuY8j
         pSM5ASAY4P+zeo2aHgWXphoVJeQD/VpYQK4q8ucW7A3XrttTiWYt0uNfa9oPHjBp93V4
         IuRQ==
X-Forwarded-Encrypted: i=1; AFNElJ8kgo58AYu8XAiHmYOKEWSq7pTRAhKGi8QRVBFO/WRriakiuDNld7yhyZ08GwQLE2w453RczkcxqyvMMV4LXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzaA47vsVSmqDOroJ1Bb6LmCW1gzg+aRaTDlX2E8zxaj+/YvoER
	h666F6nBZH1uBaRicSx45ofwE7ye1qo+Te2edCQcgD/IJrJy/8VxQtou
X-Gm-Gg: Acq92OHEO9SLG4YVbzxG7wQA2lqBqq4gjOu64Pl6zBoebRbprd2+2Zi2/XPHtFHeiZb
	OgFuaCOdobvEGvgE79imUzl6pD4+TLNgMLAnne3UjosfnR0dhO8eb/SrfzeBiRPIQF9eD6DX3jy
	lgexO4doTFsPc7f4hoZeiNqc1f3KIYl8oMI1V0hMGnAKCZIRXfOvSKRsX1/ev2mA1TrEqUX2k3o
	FZp+wgP2O0z/rYUjNM4e/xGAfeDXNiS/fFhgvl6HI340SksDhu/dEHNJLmtIpQ4C4WEPRtC64nr
	3YFmQbOBFJljGSu7yCS8SEbz5WsIOciuRTo4FcVDA4oN7IAkEuE6F2EQdFCxkc/FbrHMn0ossPe
	zdnAL+nhk1cXDR5X/x056FYBTxzvoA7p8idnwKfOdZG6l0hFvJDKP7+HeJhCMSGjlwj2hqCUhxj
	LJ8ECwyaDxEWRIYzJACwOSGDBGBUzflEXU7jtRT/02fye1iKdY/w5aQ9tQf83VetxVAdvbqEXKg
	RFTUvQeLWX12/o2HHboyQf7xyuJK3v+hTJYwQ==
X-Received: by 2002:a05:600c:8b0c:b0:48a:7a10:4f47 with SMTP id 5b1f17b1804b1-48e51e0a620mr407790805e9.3.1778525472435;
        Mon, 11 May 2026 11:51:12 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:e687:6094:b849:9886])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm854775e9.2.2026.05.11.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:51:12 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 8/9] arm64: dts: renesas: r9a09g077: Use SYS syscon for WDTDCR access
Date: Mon, 11 May 2026 19:50:57 +0100
Message-ID: <20260511185058.1926869-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260511185058.1926869-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCR registers for wdt0-wdt5 reside in the second region of the
System Controller (SYS) block at 0x81290000, which is now managed by
the dedicated SYS driver and exposed via a unified syscon regmap
interface.

Replace the direct mapping of the individual WDTDCR registers with the
new "renesas,sys" phandle property pointing to the SYS syscon node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 59e5de743826..b076bea9cb70 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
@@ -327,61 +327,61 @@ channel1 {
 
 		wdt0: watchdog@80082000 {
 			compatible = "renesas,r9a09g077-wdt";
-			reg = <0 0x80082000 0 0x400>,
-			      <0 0x81295100 0 0x04>;
+			reg = <0 0x80082000 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sys = <&sys1 0>;
 			status = "disabled";
 		};
 
 		wdt1: watchdog@80082400 {
 			compatible = "renesas,r9a09g077-wdt";
-			reg = <0 0x80082400 0 0x400>,
-			      <0 0x81295104 0 0x04>;
+			reg = <0 0x80082400 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sys = <&sys1 1>;
 			status = "disabled";
 		};
 
 		wdt2: watchdog@80082800 {
 			compatible = "renesas,r9a09g077-wdt";
-			reg = <0 0x80082800 0 0x400>,
-			      <0 0x81295108 0 0x04>;
+			reg = <0 0x80082800 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sys = <&sys1 2>;
 			status = "disabled";
 		};
 
 		wdt3: watchdog@80082c00 {
 			compatible = "renesas,r9a09g077-wdt";
-			reg = <0 0x80082c00 0 0x400>,
-			      <0 0x8129510c 0 0x04>;
+			reg = <0 0x80082c00 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sys = <&sys1 3>;
 			status = "disabled";
 		};
 
 		wdt4: watchdog@80083000 {
 			compatible = "renesas,r9a09g077-wdt";
-			reg = <0 0x80083000 0 0x400>,
-			      <0 0x81295110 0 0x04>;
+			reg = <0 0x80083000 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sys = <&sys1 4>;
 			status = "disabled";
 		};
 
 		wdt5: watchdog@80083400 {
 			compatible = "renesas,r9a09g077-wdt";
-			reg = <0 0x80083400 0 0x400>,
-			      <0 0x81295114 0 0x04>;
+			reg = <0 0x80083400 0 0x400>;
 			clocks = <&cpg CPG_CORE R9A09G077_CLK_PCLKL>;
 			clock-names = "pclk";
 			power-domains = <&cpg>;
+			renesas,sys = <&sys1 5>;
 			status = "disabled";
 		};
 
-- 
2.54.0

