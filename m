Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794395245;
	b=kV0T3koWwVPsNTsytp+ixerEEk3zkbsAV8G9TG8O+3WWITWienbCO4IS8TTJ+5WxNaC3
	 7dQNpvH/ETwOv5WbEpjGXbyaNgKsxIxgMCpNucdWEO8NaXq449SqMGf1s6fL0Os1W+gv3
	 ej+EkggCINQT9qpiDUa2s5vPuuphwpyu4ZbCmmvmUH1kLfhLAy4FiU0Ha84KSy3UyvViv
	 IFE3Qn76NS9tQF1K+SEebeSMBEI8QxQZwYmSeJ8/aqG1qUQZlDzrod/sqPGB1+0OmSGf+
	 ljhloQAnu945LEWwDFB5D/3oE931wuSgNtM1BYmkk45KoVac1+XHANsJ+yN8qkEcSIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1DKdyJESssw+eqxRBb106Pb/gP3e4B2hJY3u/Tbu8Oo=;
	b=dGMzJpgJLk+T0Ny0jS/Ga1BM18QaY3zrBuF10mMpI3u3L/eM6IYvnSPQ0st5BJu0h4fU
	 ZJgPjBhbbZLn7G133WdAGkXVtgXdom1WOcgu5waS2b/wCn2dR8pl4b0Ic9sKFDJ6xlcD0
	 o+2yXmMEixM6oh0T08VnmZT7OMIVDqmKJ0XSoJ/dyVNZBLS7gvxbbVM++2HKNIq73P1AP
	 5moPLSIbnX9pbJ8HfFQd1l5X3y2DgEXs6z1qy9Keg26Ae/dqVJMp1GGi185/ZUkAxW1Cc
	 B1z8opOl6S7ZzFDHAB2u4jJY2il274DZiKbMZ4vekrjEVoGB+9sC2bwJJoBI2JsqpRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZbazZ2x;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADBB606A89B
	for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 11:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ADBB606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hZbazZ2x
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so32053975e9.2
        for <linux-watchdog@vger.kernel.org>; Wed, 11 Nov 2026 03:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395244; x=1795000044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1DKdyJESssw+eqxRBb106Pb/gP3e4B2hJY3u/Tbu8Oo=;
        b=hZbazZ2xx1xzRrcV2f+dFJ2skZ2Lu5V8v37Yd3xAvwy6+zV3qt9jdA3Y51aNt8JDqm
         GB3STnUMinZtNkXoIyPF8xoVeX97EPsffn4uNE82NmBLDRD4aP5P0ZdqCIqzlJ/po07W
         JI0EJTonArtRGK/2hss6Oy5v4S0jOZfaQG4TF/mDN/CFY0IUR5kvAJU1SzPUgqgyhOSt
         1AlzMu2GjwleFEAw7pmj/Gs27zS2/hbN0O1lLNWiU90tiL2wehYxPCWopVqPLPevXmeX
         pTkEmOetKS3TYYcbXr+IiLbI5czzgttJSokxjR9OeQetqaDWVkpM82qBMB7cbSQi4Rof
         jAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395244; x=1795000044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1DKdyJESssw+eqxRBb106Pb/gP3e4B2hJY3u/Tbu8Oo=;
        b=HbfDUls+26m4K8WRlNW/xSptZNrip5TEhoJpJeG1aJ/lI/0/kUSnMsqFFfxNknoVNG
         8ulVeolvP0/wCpHOa0Mu3zIbd9EwNrcSoAK/dKK5YDhUxdT3YP+bG9d+g5z5nrr0gcHJ
         LrFWRaCe3JSL7CTDZnCWwc64pKYfIjI2hXlaaFkZdYw3xzcxEGbvC1R6Ab6juzBYxDpr
         T9jPbBmyd3LDEu5t04o0eAjOxr0uUR0QWbipVMsfyBEjUCrbcHQJrpGaJ+UARG+ky58D
         g8OBlTMrK24/ZNr5/GOLqUwbIN+z1vtPsSi44hJWc2P8LiiA/xIyfWccFfxSGGcm4bpH
         /TuQ==
X-Forwarded-Encrypted: i=1; AL+hErFzEw01ybVO6GBYm6Qa1X7/ybzpwZEvW7teOxLB94/oGGBd6hbeNsfggPyCScoKlu6DZe7wbrsFTOP2WS/Y9w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+soYqLuPW2lMpzHmkI7EhTPAKmeyqeRZdONJfTDlANJODh5JGC
	loxfpdctk1S/aH+q4ZjjFOBW1Qb+Wwem8Zl2kkpempJVsyTVmdPjk3En
X-Gm-Gg: AYBFou2HH0Y0TRHbsW0lAC+tHBdPmSprjxoS1cjU2+dijHcqn1yEAkPI1gFHhg02D1c
	vbt5Tn1W53DNpvC1GIPYEOYi26AL9aSG0UW6zteCaKips+luiZoCxAV36H7WZLExfg1YTqgvn+n
	oHI/ZE58HPafa7Ov4AA3J3zlMoMQDww1XzzCT0LxXDjY8ASvbi/b49yEvmmulRAzHiTldr6BOcW
	SutJK7STQAnulIXTIlfLw0YhI9ANz6Iiurms/Q1BLnXWnXeXkajU8gYzQOVwtwjnfDWYeh8vbKP
	l4PxwI1OdpsUI0O5OjrEPlzQc7L3E9qLSrtVZi+/HvMm5T6DcBGsAOUgExkHevrWarQ/UcV9rgP
	B5KZL34XapktESv9EDG/y+yvIOWuuw6NBR+3cBVWe0nhghnqlV6ISIDY4Hql5Euma4tk/cuB/Xh
	HP9LfVhAXUnBoc9l9XHf0TjRi/cGlMeIu+jxqLjBBEG7DvQT8khnEFCMum+oocnZeNXCS49Rymu
	Kh0gLhNkX5rDUG8Ey1r0R50EgVB+2jENbpPThS1DR7/WbfEUi2JKbTsKboAZfOtXn9J9pn+ezks
	lm1yCXtsZgquurQ6HwM+O+2mH8sdYTY+lzL6NPrP7CQY0hN19l6m/WiV55lMf8SxeKdb00WxYRS
	rGHJPapKGBAcVSDP+wesfXeSYTwT9JwghRznZT1sH4ldENWAEDQ+LiGozkAEy41irgZqBmgxZDe
	mxDXTkrN9e
X-Received: by 2002:a05:600c:1986:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4ba09377221mr34575625e9.9.1794395243848;
        Wed, 11 Nov 2026 03:07:23 -0800 (PST)
Received: from iku.example.org ([2a00:23c8:254f:fd01:783d:786e:fe55:f40d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0203a6b0sm146727295e9.5.2026.11.11.03.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:07:23 -0800 (PST)
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
Subject: [PATCH v9 3/4] arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
Date: Wed, 11 Nov 2026 11:06:59 +0000
Message-ID: <20261111110700.3331225-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v8->v9
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
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index 258c74c57b75..472cafe7d4b2 100644
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
+			renesas,sysc = <&cpg 0>;
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
+			renesas,sysc = <&cpg 1>;
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
+			renesas,sysc = <&cpg 2>;
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
+			renesas,sysc = <&cpg 3>;
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
+			renesas,sysc = <&cpg 4>;
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
+			renesas,sysc = <&cpg 5>;
 			status = "disabled";
 		};
 
-- 
2.56.1

