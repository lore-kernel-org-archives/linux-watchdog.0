Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B87344DA7;
	Tue,  3 Feb 2026 12:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770122586; cv=none; b=IxDLlD627jAzxb0KmphjFBtwd2COFjfibgB/pQwu0VjtkoZ4z/eeXfncSIeOjjORWipQmEVvbCXcwl+L1U528evvGRzOP6ayUrVkZRgyLmeUKtQMm1TuHu+WOPhisGNYSvZcrhjiAOhEex0dFDiVX1hFXza0q/Pe/QzB6GYgSKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770122586; c=relaxed/simple;
	bh=mBgkmTID+NEO7eE7rcOhcirl/O4tZXLLRlW7B7E+Fio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8HH1B8iivyAt7wkZCZ2oX069tagiQSeGXSYnkE7BcQTLzKtI088EBm39KfuIdsaXrA+j6d9djfbic4Up+QhkokrriWq9bojpugMRsRkv3V4riBJtANIk2+1BIToXFoseE4ddgl+bRMWXYxwF43UiL07Zv/Hucx2pxLAndnN0Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: Swbxv3F3T4mxp1xentWd0w==
X-CSE-MsgGUID: x2FV4cDnSA+TBUqCCEySHw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Feb 2026 21:42:58 +0900
Received: from mind-2s.example.org (unknown [10.226.36.118])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id CF2CA40134EE;
	Tue,  3 Feb 2026 21:42:53 +0900 (JST)
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
	linux-clk@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH v2 1/3] dt-bindings: watchdog: renesas,r9a09g057-wdt: Rework example
Date: Tue,  3 Feb 2026 12:42:45 +0000
Message-ID: <20260203124247.7320-2-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203124247.7320-1-fabrizio.castro.jz@renesas.com>
References: <20260203124247.7320-1-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the bindings for the Renesas RZ/V2H(P) SoC were factored
out IP WDT0 was selected for the example, however the HW user
manual states that only IP WDT1 can be used by Linux.

This commit is part of a series that removes WDT{0,2,3} support
from the kernel, therefore the example from the bindings has
lost its meaning.

Update the example accordingly.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>

---
v1->v2:
* Removed Fixes tag
* Added Conor's Acked-by tag

 .../bindings/watchdog/renesas,r9a09g057-wdt.yaml          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
index 099200c4f136..975c5aa4d747 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,r9a09g057-wdt.yaml
@@ -89,11 +89,11 @@ examples:
   - |
     #include <dt-bindings/clock/renesas,r9a09g057-cpg.h>
 
-    watchdog@11c00400 {
+    watchdog@14400000 {
             compatible = "renesas,r9a09g057-wdt";
-            reg = <0x11c00400 0x400>;
-            clocks = <&cpg CPG_MOD 0x4b>, <&cpg CPG_MOD 0x4c>;
+            reg = <0x14400000 0x400>;
+            clocks = <&cpg CPG_MOD 0x4d>, <&cpg CPG_MOD 0x4e>;
             clock-names = "pclk", "oscclk";
-            resets = <&cpg 0x75>;
+            resets = <&cpg 0x76>;
             power-domains = <&cpg>;
     };
-- 
2.34.1

