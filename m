Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC1432BCD
	for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994797; cv=none; b=pbHvXjm+Av7GIXIGcGGVZjQ4YGi56WuG5XXPYo1KxgXDO9j6gyjEDg/ieDh6sIlt8pm0ZVXDtImEtnMHtO4hIIUO+bsezsfKqtDmblkOmo1Wj3ZrJnyc6wwkm9dNFlqbJafWm82e5yqTgxqLhMV/S6R4qEmOAYxF6V2iD/JFbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994797; c=relaxed/simple;
	bh=sIvlwinupomxM3a2hWMmImtBO5VxdZ7EwFqpLwq+WFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iENCTAFKZ60Ux+etzVq3CPKj5yWgbiHNkam3omnGj3NpxsUr5ahSHCwTZL+L8gMAs36FN6d+Jq5IsOLOCmAcsAoVaChtwsXefOP2tqI11ESM6Hu1MSQzyvcAbIef1bACJ6AvtYDqH/GnpGi95sgy5ozXns8Um7x9gAJhyVodZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tve+i3WF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tve+i3WF"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2caed617615so50677255ad.3
        for <linux-watchdog@vger.kernel.org>; Mon, 17 Aug 2026 12:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786994795; x=1787599595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7ami9imt6GO00xjWzOm9H3fAjKzP3fMTgY6VhTdgPoQ=;
        b=Tve+i3WFWTnxLlhj2GPm3LSBnbGoO3pF0i3oRyRtM+T48AmZfrBaY+JbMZd9pAYLec
         xczMVuFJQHE0XsJ8JV66nV9+MV7y4m5gtR2USrLFDnK0Ommh3+flW6e8/dLYuU/f7H75
         PVZTSfdh6Un+QEaLI7uOvT6yGRqKFbOA4rppDnokPS8NMHuICkOXM/ZvI2GUTbhuijAy
         8Iq8eS/V9xnXQXB7wkxu5IoSivcyvxxbcRqNrrtAn7SVxo+GMuFu0xw4R8pr6wtVdM1E
         Hz7RECjZpUG7/VvlWONX3inJCEv2Y/f/PTiNgqM0NlX7eWuoM+VFk2XOcEeaxe9j6DuS
         KTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786994795; x=1787599595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7ami9imt6GO00xjWzOm9H3fAjKzP3fMTgY6VhTdgPoQ=;
        b=RTe5/SKB3b9ia39yUbePYJvPSRwPfhgpmOYbmO83ec5GoHAyrNBO49d3Y3e5XNRD4z
         6KT/D/y5t/+ZekyTDeIk991dsvCmx4vqpvnkFrx8qz4XmD/sPefYuzUQvIIVA0g3FY7V
         EwKik1nkQpCfoYuhVMSkMVJcvm7bCZbPqeiU5clEZcC8cDf01sr6XHaJ2HoQOIX0fV5A
         WFaVX4/o4XAI+UeKPnV1qZgPhJI0Kq0uY0pS3HQFB3m7oNaWqr0r7QqdcBD5n9wcwzwG
         ju8UilMsiQhZtr+hQDN3GU8kEKsWxhoC+mKZxi1ahIUP0oUt/iqJP8zxjj08Djsp21eW
         2Wjg==
X-Gm-Message-State: AOJu0YygCNbnIWRlpvYPd9McFYwxEyzOJ2V8ZxWke+jcbdhrz/uRW/H+
	dARncMI+6uu8/6BV2HIKjy8Vx4USGpqvZty7kTwt+aCkiImzJWlOMBaF
X-Gm-Gg: AR+sD11KfMyGjIRrAejdZiMEnQhVopRNX8DW9FdfMP52fpcpBxaFgfGd8sOt6b2FzGB
	r+tn2+dSjdFetBr120hHXIKCUGW74DOe0UVxCiPobLR0vB6PWNiTSL/3sjeO1L1YBZajwAM2Lo6
	AyO+d1vILONI8vebepEDfvFZN5QsVzHRZzYfbIDbZdyJxW4/mx3fB/JyXYg4clgCZfSJxZVMRZ5
	ps8xorx/53W0085Tysse50hq6mkxarEMLyeCrf/3LM8/A/Dc6ZuvIHUXMWYp0EC0+0EDnfcuPNU
	x/bgAcSylWNG5G9mfVdl06hog3SQ4h6VTM4OKImd4BfItUhYmvCNjwz+9yYR7IBSx+fmfWgeT27
	Y/FFN/LBADOXymbMnG9HDW7bEKkslUwt6qTX9dPvIW8ppCw+UBGdfPWlFOW91KFZrrCa/AUgG/2
	3rLbxDS1DHLLkWQKlKXa5EGQCKaewB6H4bPZFwXpqwGydBMXpbanVydM1hOCx/Wmjf5eJbR1yvu
	OK2uUB//CNeEM1tFbxA436DZhlnODKOsLrqnvQhSsawXaxTTUVU2rCEO6Yfjovlm0FoqVkvctC9
	xs2IBdCeFJI=
X-Received: by 2002:a17:903:3885:b0:2ca:e62c:9e96 with SMTP id d9443c01a7336-2d3b0d78794mr281621245ad.5.1786994795153;
        Mon, 17 Aug 2026 12:26:35 -0700 (PDT)
Received: from iku.example.org ([2401:4900:1c06:2735:f886:32ae:1e17:ec13])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326798cb9f5sm10218757eec.13.2026.08.17.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 12:26:34 -0700 (PDT)
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
Subject: [PATCH v4 6/7] arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
Date: Mon, 17 Aug 2026 20:25:39 +0100
Message-ID: <20260817192540.423994-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g077.dtsi b/arch/arm64/boot/dts/renesas/r9a09g077.dtsi
index de20bed2797b..80910e0bd977 100644
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
2.43.0

