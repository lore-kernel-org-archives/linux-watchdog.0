Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39093081BE;
	Thu, 29 Jan 2026 14:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695671; cv=none; b=ZvsOJmTTF3+Q8dwKAlyqvSPoWyX4PzevqHS2L1SnmuDqlw3dW/isEVDK+OQox6CGo/+gFxkvtK/QsbdwakRG/Xr4srfFfR5mW+cuU9pzbybSVXgMNI5VJuGlWGLCRnC+nDGYlIYzSVMPAzjAfdjhgoVyW+rfbXEG8N/GqHfeFuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695671; c=relaxed/simple;
	bh=qJxQSTXyoCQ6dxnm2BQjqhmbYlbuCQnTC+P42pq/w/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+bbppA8+uXKSSmOa59vJlcT/aitpIaRbx/B7s3l0vVqlKEm8INMCVKQktSMANbS64WyS1VbPd8S07/PXro1kf1dho1ZX+QKhpGhHDTS0oI4qU9vW+viGxrr6Ypm2ayAMDaKGWUGbbhVc1g5Oclhey6Bsno70ssH9MSBKZbbJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: SqvVhvKfTeqyWocyiX3AVw==
X-CSE-MsgGUID: NbwVAR0TTvGMuwq1NZ5yVQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 29 Jan 2026 23:07:48 +0900
Received: from mind-2s.example.org (unknown [10.226.36.118])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id CF82341AE669;
	Thu, 29 Jan 2026 23:07:43 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Rob Herring <robh@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-clk@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH mainline-linux 2/3] arm64: dts: renesas: r9a09g057: Remove wdt{0,2,3} nodes
Date: Thu, 29 Jan 2026 14:07:30 +0000
Message-ID: <20260129140731.12633-3-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129140731.12633-1-fabrizio.castro.jz@renesas.com>
References: <20260129140731.12633-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW user manual for the Renesas RZ/V2H(P) SoC (a.k.a r9a09g057)
states that only WDT1 is supposed to be accessed by the CA55 cores.
WDT0 is supposed to be used by the CM33 core, WDT2 is supposed
to be used by the CR8 core 0, and WDT3 is supposed to be used
by the CR8 core 1.

Remove wdt{0,2,3} from the SoC specific device tree to make it
compliant with the specification from the HW manual.

This change is harmless as there are currently no users of the
wdt{0,2,3} device tree nodes, only the wdt1 node is actually used.

Fixes: 095105496e7d ("arm64: dts: renesas: r9a09g057: Add WDT0-WDT3 nodes")
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 30 ----------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
index 80cba9fcfe7b..504c28386622 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a09g057.dtsi
@@ -581,16 +581,6 @@ ostm7: timer@12c03000 {
 			status = "disabled";
 		};
 
-		wdt0: watchdog@11c00400 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x11c00400 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x4b>, <&cpg CPG_MOD 0x4c>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x75>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		wdt1: watchdog@14400000 {
 			compatible = "renesas,r9a09g057-wdt";
 			reg = <0 0x14400000 0 0x400>;
@@ -601,26 +591,6 @@ wdt1: watchdog@14400000 {
 			status = "disabled";
 		};
 
-		wdt2: watchdog@13000000 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x13000000 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x4f>, <&cpg CPG_MOD 0x50>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x77>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
-		wdt3: watchdog@13000400 {
-			compatible = "renesas,r9a09g057-wdt";
-			reg = <0 0x13000400 0 0x400>;
-			clocks = <&cpg CPG_MOD 0x51>, <&cpg CPG_MOD 0x52>;
-			clock-names = "pclk", "oscclk";
-			resets = <&cpg 0x78>;
-			power-domains = <&cpg>;
-			status = "disabled";
-		};
-
 		rtc: rtc@11c00800 {
 			compatible = "renesas,r9a09g057-rtca3", "renesas,rz-rtca3";
 			reg = <0 0x11c00800 0 0x400>;
-- 
2.34.1

