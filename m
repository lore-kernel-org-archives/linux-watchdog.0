Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE543CEC1
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994804; cv=none; b=OOAE81oQCcOyCQnsSR8+Lzagqz9OuqMeMwykLOsvX0VxbA7T/sR7r/LvqhBXl1yNurT7/a6kvW4wlUhGWuYLc9+rNro8GBZFTLGYUui9/2b29R7z3q2fDxR+ufXJ3UOI5p3/N/grjBOFWDxY2WRkSUrk1Xpr2ah6mVjWi59snbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994804; c=relaxed/simple;
	bh=NdEBnCUmI8vcYieObvf0+R8QSjffR1RfAbs59Qz31Tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsCVt++aXWyhEEE6zmWNJdMAMcTub3gW4x90OAf8Inl5BuK//NXVINPXwxQYTKd6RHpHmmf+bqZYgOY3dZ6Gd/qzYiJeJyV5f3bJpePJIZ2pANuykqWvM7isON+OYjaC87g24Qi90XsMnRVzJQ6/WDn3Zz9L+av2OhdN1astHZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jl2dhQhe; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jl2dhQhe"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca88130e09aso2299070a12.3
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 12:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994802; x=1787599602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8JDfCvRVlnDBvbOdUSOi/Q4nr+3vb687RKt9hvjxArk=;
        b=Jl2dhQheuNrwubvdWus4MPnDpjK1XeduDhXOesEw2fqw9i5gr17+OjVam1Rg3UvMkP
         aeZcoLX/avqt8ScGTubj/gQkXVs82LSanCje1Smi+kaN8zc/JvfPMyxH7G47TpSEDexy
         JAYG640Cb0fBtrSdCss9Lhk+QeIYBqn0lbFMGnrk5rbVFAWSHrBLQgZgZyUO2SX0gs2H
         nZbjrQu9we6s4+GmL00DKT8HbKKVLDNbIQEhwvFKUyndK5YqsbMyO0nRqsy8WbJmA6w9
         PCfmCWkQsNMHKvF4VKdcKHARtvgKRfvVCzWCTqDmTDVLfHcrJoKyV6vFSqJdpAk7F/1m
         xRDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994802; x=1787599602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8JDfCvRVlnDBvbOdUSOi/Q4nr+3vb687RKt9hvjxArk=;
        b=WZF/ihE+ru6sn9RCxwjVC1ybh+6LAhOQ++zhq7eGQfay81O6tDaK7jOQLxrpHl6q2s
         fVArYTy5VYG6UOZdt+ctOSX7GTgGota10KuXEq9TDY8DkjN3uTFIl/88gXz03vXPrTR+
         8twzKebBMnqxmO0mhlGkjcetrsq6yffwl/c9QtXLJridm+Eg+bEAfXsG1TzGcFEjYS+3
         M+yS1GWLilG5ekt+C69yLn3Mu6hVeTb06/W2ktpSihGsuGkSKDBsceXb3cLLhPq3x8G4
         WGNgOg7mSlwkcLDcjR4HonkpKL0cn8w10Iz1us98/g4lPRYIaPAIEGfNHISFxu1Pats5
         Hvuw==
X-Gm-Message-State: AOJu0Yz/UO6PZqER0lRN4Pgt2xnz65O0bPh7+dnYXuwlP1eSVS8Afnr+
	PLjICB2G6lV7hKODX12RbiaBzleAE6sScv8GyeQOm00dRK9QnSj3mRwz
X-Gm-Gg: AR+sD121akMmdGoF/8n7eZIYqNEzDXp8EaUvgAb380lq7pCU7ikZYKb8L3D6Hl7zLZQ
	OLiZzc3Svtlz6rMVj4Ih1KAO8jXMPiAeNGLAFDLWsXmyLxueM/7uGOp2Z9KK1Awklbq3dn6OsBz
	hzr00fpx7od/QDLe4EgaL4azM41Q1Vc7hQr9/ihHrqNEP2TN3+dWomOWMAQd+aXPu6aJaFfp4D6
	qED7pTZxH1KxaFrIktpfTWoZV3ocFmWioDExUcVo6UHVNwKvkr0vdA7J4SvMS5mXNvg5uYiGXw2
	1R63pBpaf3y4uS/XnZkYPZTIHva3ssNbpi4jggkChEI3fHIAS2pccdsciLPPKds7cmcVnneMHxz
	EzjJxfhdFyzMPfRXua5e9obk/9NczfiTL4m/rkTGUmhr2XmGWrVGjUuFyaenM5887gTyINCLA4X
	wviUrNHsvVg1CzoMQ8H2tsts0jVTkX8i1pQfiZfGD1YY8KfMv5tgEPLUC1FoAg7LTcSubBBxkZL
	iKyRTEctkWCRMmb/YfZ15ZhXcIYLP13ut3cl5pkB+fiDThd8c34P123ZxDCabUvbZZHFNElLYPC
	wpz3V/059w==
X-Received: by 2002:a05:6a21:134b:b0:3c3:875d:7053 with SMTP id adf61e73a8af0-3ccda403574mr3047275637.8.1786994802009;
        Mon, 17 Aug 2026 12:26:42 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:f886:32ae:1e17:ec13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326798cb9f5sm10218757eec.13.2026.08.17.12.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:26:41 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v4 7/7] arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
Date: Mon, 17 Aug 2026 20:25:40 +0100
Message-ID: <20260817192540.423994-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260817192540.423994-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
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
---
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
index 813bb0cb021c..3ede2e89cf67 100644
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
2.43.0

