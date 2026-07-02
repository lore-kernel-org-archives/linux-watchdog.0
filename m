Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D3481220
	for <linux-watchdog@vger.kernel.org>; Thu,  2 Jul 2026 12:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995505; cv=none; b=p5LhJ913Ah15e5FYaOXWfcZPiXR+qClNiv2LhivKef4UG+bOdBu/R5Tj/LduKZ6RscckNd1f2hQOhzBnZYabU9Et/lJGZlE4Nv2jPVEHPeHeir9sryddUQeXB/fxWCXnrRY4eqfM/e2SShTQ9NR8gnWlVUwjBBIlXBniBZaViq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995505; c=relaxed/simple;
	bh=8SJCiMa3lPfv/rTE+pQQTxr30mOA3gxwQGR0gmNnTo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bwi9A2XYmcNiaUJRL4cAJN4ksWxpHtfPk0RsMXF7+5cuqgPiHNkiwj941tZaxgXpAinJpXaYU60LweLo/CbuJyk2/n/H0xmzmITO9di9/TDe2PtMa5TRBs/1QLLO8LFevxaZe3m284XnsgqQ0TM8xHP5jCbgi7ygSqtddtTgFnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFtZPpZc; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFtZPpZc"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so2014053f8f.1
        for <linux-watchdog@vger.kernel.org>; Thu, 02 Jul 2026 05:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782995493; x=1783600293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eithLOELKkNE1v5JgvDJ80gc2YnZ90Sl+cwRSRw9Ky4=;
        b=fFtZPpZcwflwpwdK16YVWrNmW7n/qa44AsCSQI07AHAuFa37DKYx6L4K9SbAkjzNUF
         7IN4qTxFfj3OCbin1rZ6jD3wggKqO6v3urGiEjXI20ZJgf0wcr0ej2o1myZnGZVgGTPE
         71i6Ia5NjM/Pq/tfKudmICHcT4VxH50VwaAvbpofgJ/BFM4QwSnZuubNjeRkTWpKwAkB
         Wrh79oklEU/PJp3d24kjihwkT287j7EmXhxL2rB+MHJovEquSCTcrsTpQGcOjz9GLW2x
         xtxWWjgcbgaYlKT4J3y638Ki+oKjfRJlG5rpIVyYrWoj3FH3eRl1fFz8KmZV0xSf9J5D
         y+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782995493; x=1783600293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eithLOELKkNE1v5JgvDJ80gc2YnZ90Sl+cwRSRw9Ky4=;
        b=GVhuU/w96md/5n5KSE3gEqV1V0ykA2zzFc0jnCf/bPTrDxnCNw/66VXVsQnU24iUG6
         ID7PnnpoV6zYR3jzSHP/qhySvUW9qO8k2pIOnUpTYSTZ8ZZ9bOaPHMb4YDSac0ATjZaU
         U3RzSUkmUp3LCvRVA0Z65vhOLj8cuH5+U4VUkI1BeTBjj9BP8/i8Qrjd70Cd2N2aptHc
         xon19UXcyo/lnXRbN+LOmkNIVzDDMO4FF9GeRctLHv8Xx6l1SYVQ30oMCGutRHNfZzg2
         tIBg+AtbizhGWsyl6jg/yr6NuQ9S7/4X6bsModagJG5iUmgNY7xQXQg65qpXFTeyR+Cz
         p+2A==
X-Forwarded-Encrypted: i=1; AFNElJ9WZb7p9lu1q0lavQCUlVu1cPKqGF3Ccrpa/3oSeaNn2S7xZ25UXyFy9Zo8PEQjh40BuPFY8jsqOte6Nb1+Mg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mQ1OrNAuelxKHn6RivXlaMbyq3iKUgQUO0eCNsJuQUcxgNUv
	mVkNXb7Ol1R/DqFCIa2l0IdeSRFACtIjrY/OtBIXfU0DRYLeipaN3cta
X-Gm-Gg: AfdE7cklJgCbxqyfUmKTO3P6r6AOy3/sNsoi28vpG9BkQmB+NBTf6ZuN8u5WqWI+yZU
	EOSK6wsJydW36mSXF+PkBoGQn07dHRJjjTrCe9KnKRXXAtEaISUjd2H6621rycbe4+Qpj6eIh/J
	UFSAJoWp5E26d4KO36YXXPew8p1c9qMrMblvvjHQoLGKc5CCVqAHvySaxqHgcYOB9hc1zPkmL4k
	Y89/nCOwgUOJfPvTHqEOaSVpFSBqY+ab0eHQy+OGH76IyIs/O4vYErRkSuLPht/Lg3D/86qzkMx
	two8AVYxm1SprM3azVVSf+drxgjQ9xwBsYs1SjPX640NcKLHN/dXzX/SAMF20hsHd/HqHRM5e22
	Mp7U1cIYVnBgvficmrFi/Ul0vlPVJZuSGNG9XKOm1CvfptGb6W3IF4dS3xVvhvkq/acpiaexpdW
	L7mPqxZEwOlHZeGXXjcbLbHuRMat3XavmEt0A3V6fpLu+AQ2MbICjYOdJf/2+jtj1F8yEu5aVYc
	s6eM7KVr1WRm2oAboMJjcW0pWQ=
X-Received: by 2002:a05:600c:34c8:b0:493:a5f9:d345 with SMTP id 5b1f17b1804b1-493c3cf0a35mr71155705e9.26.1782995492556;
        Thu, 02 Jul 2026 05:31:32 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:7a4b:58b4:175e:8c2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f433sm9772923f8f.32.2026.07.02.05.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:31:32 -0700 (PDT)
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
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH RFC v2 9/9] arm64: dts: renesas: r9a09g087: Use SYS syscon for WDTDCR access
Date: Thu,  2 Jul 2026 13:31:12 +0100
Message-ID: <20260702123112.161160-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260702123112.161160-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The WDTDCR registers for wdt0-wdt5 reside in the second region of the
System Controller (SYSC) block at 0x81290000, which is now managed by
the dedicated SYSC driver and exposed via a unified syscon regmap
interface.

Replace the direct mapping of the individual WDTDCR registers with the
new "renesas,sys" phandle property pointing to the SYS syscon
node.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No change.
---
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g087.dtsi b/arch/arm64/boot/dts/renesas/r9a09g087.dtsi
index 165c404dfd36..90a2fd02ae89 100644
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
+			renesas,sys = <&sys1 0>;
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
+			renesas,sys = <&sys1 1>;
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
+			renesas,sys = <&sys1 2>;
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
+			renesas,sys = <&sys1 3>;
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
+			renesas,sys = <&sys1 4>;
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
+			renesas,sys = <&sys1 5>;
 			status = "disabled";
 		};
 
-- 
2.54.0

