Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D8041F358
	for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784205294; cv=none; b=GXOGuZckp9CBPr6CLSWxY3orSFDjuc0eLw+LqLRO03TdzydS6wXGTe09DkUMNsld9390EL0qZYkrG5/RV48jaiEMhFM/YSTl045gbz4V2bBfav3gx6ejQjA0C9C/A4AF5ugR1148BfoFk9IffjBwQxmgf/TQALnywNdNzKcKOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784205294; c=relaxed/simple;
	bh=HHq4zZXJ31PucgbPcI9vveGvRcm9kJwMFQOFH7Zu84M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRV2hdgFanucWAy4NmcsIlC0lqVL61cCmw66C/pDvD6ORWbssrmX0ppfIa9tguUspSte9BFYDYrd0FTYz5aVpHJGtxXrV+YYNQHtmTbBk08hww4VGoP3evL3RN3LcDhCk0i91EbkX1eJ7vIKMwDfW0sC95Xa9UPZLDVnYpuv+GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOKhDd7C; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOKhDd7C"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-472326ca506so5352395f8f.2
        for <linux-watchdog@vger.kernel.org>; Thu, 16 Jul 2026 05:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784205289; x=1784810089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WYZoYOU2wxBr2JA/EFs2Nu40Y+X1sCL5bFMYyH0wjd4=;
        b=kOKhDd7Cgp0Fr9q/6GT9L3llrATZl69Xmqrqr3kajA/efu/XlFSUluQOO+6eGFYxoQ
         tbfYTLXQRh3ar6vJYWcEcs8L+VaEoR51YSmaL94YTGicgjgmguBcsYZAR5yNsFS9VeG9
         DMKTPxkSwRyOL0+ReBO5/D4blEi/H+VH8bjiUoUQIlxjE/lN+1SKhXZ3hH4VUFGJ4vzV
         G9dnsV0QIO23G4aJ5x+us68HeBoqaqvByBgbAoVNXExac2Y7IL9JStIHhEuWVUebQSXH
         ef2tE0uRZtFxlVPRVxf50pnMvTqiMC2MQsydMhE2Szt/ardEv1aFl8WrvGgVfmnXQo+N
         u9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784205289; x=1784810089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WYZoYOU2wxBr2JA/EFs2Nu40Y+X1sCL5bFMYyH0wjd4=;
        b=UAbII+ZKpANhB8+yym0hh5kohkhMc/z+GfgWJuDV/aw09cQFT7ZJUoIWWai9Bskz+o
         l1c+oXQG7Q7tZgkxaHgsc7khVxzW88Y3+BvyBiVAOR0qSoeB5mM9mwLJkYG413PH9c63
         IR6iNcgjwjVZjtcFLNMrFTgd1uBAiVVI5rGMy96x64TXTe+Vr+EHhQHh3DNcvNUUvLZ5
         0GBXZTlgS9qIDnW8wW5DyJZLoS3V7HRyKmoKCoeCktEZVEeXqRXWRgpLQU505Wvw3am8
         /DgA5kYfB0fFgUFqWsGXg8RHTEh3HsSFt663ZgsQk7VL4FxxoAq9Qn5TFooQaBFmjq0O
         oMWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqViPaOanf8d0WuB2EVz4XQeoHGVCpzKRrsIHJNKofW154WV3QrQaiumi3g3x1GwmQIuaVbaF73UIZVDZK0GQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSwty1QDvFZ5LESTtPBW66H0SY3FpKgn3VnNFcUBPX0Y19pkz
	7m2tgiJiU2wFQzQ9HIbzbWPt+nc/K0Cc1t0KTX5w1TKBg9GZNm/vBM/I
X-Gm-Gg: AfdE7cn6uBPkLqmiQ8O4aafjS9oaL/By35P9MKLL3fgRjQE27TpgbFwSUTK5xNJH0gs
	lH2/s/ioqhUNRxlSkBIuyiHUfKPma2Aa7gh+K8SLdJ79pb+UyDEqq2TInaNdbkp/f4zQ2ijLNmd
	qf7udsW4lu+miq6BMBFHAcJnMI9skfdAjXPq0K4PMEP9KN7dSFvfbODMEI7lk8ywLXoHsaONyRb
	5kWIAzQOX3MdKDrHXlzmCOIDpim2seOdzSlGaLt+iwC9u+l8wyDQ2uZsEZhlox2v8l1VzF6siXB
	d0oT2YK7ym03Fu1B4aQKpAkNNAZ+qG+iUEyz+EBcDf7ruSKm6ceE0VWvocrc5dZQ1z43EKzBtjo
	MoRYyjrIj7W5QztAKSDqEjnCku90wl26AX4cZa67HcSqe/fp+FCfPWJeJkwVOLJhfCwu6FyD6iO
	T2RCKL2xHQNCNuckg41ZS1QxASRDQouVRfg7R6l4DrJ/tSuonuXykj6SVWdF4Ow9l/ACpYr1+zb
	6P6rIpWgwYHGlUh5On1i3E/ydk=
X-Received: by 2002:a05:600c:4fc4:b0:495:4505:daca with SMTP id 5b1f17b1804b1-4954505dc97mr15870485e9.9.1784205288361;
        Thu, 16 Jul 2026 05:34:48 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:4150:a2d7:2b6b:840e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e83d05sm48582645e9.6.2026.07.16.05.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:34:48 -0700 (PDT)
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
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 8/8] arm64: dts: renesas: r9a09g087: Use CPG/MSSR syscon for WDTDCR access
Date: Thu, 16 Jul 2026 13:34:34 +0100
Message-ID: <20260716123434.2576253-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260716123434.2576253-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2->v3:
- Renamed the "renesas,sys" property to "renesas,sysc"
- Updated commit message

v1->v2:
- No change.
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 718e6c06b9ba..2a87059dd494 100644
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
2.54.0

