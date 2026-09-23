Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56039497B7E
	for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 10:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790160081; cv=none; b=HVuYGmlEZqIUODgnIpEPaoASHefrqjbUSf2lrRH7HP2KyYj94HkcEbN0+CEdynrcz4WZTmFyN/+soVSuv158QRsYM8QTkFoDe7g4qBQHMZUb0vPH8nioxHOjjO7xhHrUD76RY1u9ASvHfGUR7rPuDGSe3pqc5vbS19AyhwWliDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790160081; c=relaxed/simple;
	bh=1lFgLtLwiG9ZlazEhqgrw6NCUNeBFzcT8X96+NwLVuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sjXjhKj1FwNpky6P5IUmZ/vkzP66UXbzLnZC6dEVR+SjWuMFwF8MmHSXfOb0ASMB08pQx8UhIVtYqe2cIsUCVp4lMpKQqyBFpNuM8twhXaznpgC71+Ndhci95zvLRd4i3kSFJIweAamUtKLM1RSOvw7Ra3sf0Q6VJR8bdnF3Unk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9woJsjF; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9woJsjF"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so3939495e9.1
        for <linux-watchdog@vger.kernel.org>; Wed, 23 Sep 2026 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790160065; x=1790764865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RLPiGOv8BG6J6N1wsKC4oaWQ6OSRmNQqyKq1m7eGBCg=;
        b=f9woJsjFIC+/W69h3fOGepQxMKPqkIl/oy9U8WCqFxQ3EVNem36QDllPRbko/dc6du
         U2WzfG2L9cfRpSQkxHgjjmlAmCdNowP9eG4ufKNyG0DaIkkUgqgQNHwLjM/QTZVY8gig
         qpyqFwEhi1jlJFOZDCHzFULs2NGZqOiJjalaWMJUDpNlhMIfq4/btRB+JdRStZDTRc5D
         0UCey/LAoqdO+enMUCOe28Ueb9G1dm0l9KZ85bgP8xqaSAKDNcObqcbpQ1zbsR8VojjX
         Rw8nqV9wUXGk0hY71AdMnPz9Yn7bHUrFCMTvoudegag6BgSTfiMZZXr7KVv53KSm+Ujw
         ulPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790160065; x=1790764865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RLPiGOv8BG6J6N1wsKC4oaWQ6OSRmNQqyKq1m7eGBCg=;
        b=2rKVYsQ2CwMKWvh4S2p+K8gN+ZzxjxY+ZXSGL6Zi0Q+PL6+muoBAECoV7EeLu7qD5x
         P8b63F77S2Onm1HQ+jibMWbwbe69g3vLa8DKZy8bVCtR8i56rB80U5a+Psg6TxVZUXvP
         XoWbJKxOCQ1R7VsJfVbXlx/sACHIWV3EYvkjzc8qCSGjSk9iOxODUrY5sQHXpmbsSq8t
         CgAaddzHO/6vfH+tj1gKgbawiKGaMS27MBCA+gHOms9mriGnHEQqYkObXedzaRQxnP7Y
         JmRifZzCODHc0MjPuMjbnRM/JNp1ArWNt+J6yXI4V04rs9fAjjZIb9CejblRYYQMTb+s
         44mA==
X-Forwarded-Encrypted: i=1; AKwUvBw7axL/1Sw3ue/sYqdwVWykosQqCtxYG88D/ojwnITlbg8VuZwMM274UR/tGjWWi+MclVXagdUT/nkwkAjBWA==@vger.kernel.org
X-Gm-Message-State: AFuF++lEI6vlmQAhfaQ8wl82dhpV2/e+KAx1/yZqGA9pkTcThdC7Dv6Z
	n6+5/mmSePhDb0cbLo8vbEMx53/6JAmZrHzupMq5fNV3vsowIh/cRcNG
X-Gm-Gg: AYBFou3GWAVjJnY453zDjb8EQ7PWVmHmKzrLCtamgXRFD40O8qisd8RMc6N/mkCAr3/
	BWrP7OhKecmqknNlWSLwZyv5Tnk2vP8UR61IkH+oBlhwSr1Ss1dcSQ3T3I5EvwUCv7I0nNO8/pv
	K0u4TYW1cM9UxAcKFml1nr+GSeGl/LySJlCZQoNJzcR/hRCSnM39ILkc5GROj8i2g7iKFJmDdcS
	zWtGSNTqNO71AfOk/tDNGmmAzB9uK07M4cI9yUVDlyhuuOjsVmDn/uMRQfNG6D79h2HGZ76Aoyy
	w9eGihbA05wY2s4T9dMdYrtPJ+m8H4KeWnByp2TQx2nou39F+hCxIew/B5+zM5NkaqXCKbgTM6w
	dWmbktW2tO4Du7iVrSCeHaipl5RqaJJpLgrVoXfGuiqmSeiAgRZEX3OASMTgjD0Q63NjdL+QcN0
	NRzB99Rb9pGdF6WHJzwN5mX/VbCuuaTW2UX+Hc90UpWbbkPQDYsR2peLyGc2pHlJSZEIhkxtT9k
	/Rttk/XKjSa8nw7VY6xeG2IRycmUHI1UsI2Iajpbns2niGlIMf3dOQwoNpioGK9xxpnfbLtDj9v
	p+pO0RVn
X-Received: by 2002:a05:600c:4704:b0:49e:799e:c1c3 with SMTP id 5b1f17b1804b1-49fdf12d3dbmr24470955e9.17.1790160064510;
        Wed, 23 Sep 2026 03:41:04 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:885e:6ade:cc5e:a35e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1acb91sm65170415e9.15.2026.09.23.03.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:41:04 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v6 7/8] arm64: dts: renesas: r9a09g077: Use CPG/MSSR syscon for WDTDCR access
Date: Wed, 23 Sep 2026 11:40:53 +0100
Message-ID: <20260923104054.3324830-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260923104054.3324830-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
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
index 674e35e4f242..18d748661a60 100644
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
2.55.0

