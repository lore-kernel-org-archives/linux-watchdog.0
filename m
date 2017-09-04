Return-Path: <afaerber@suse.de>
Return-path: <afaerber@suse.de>
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Roc He <hepeng@zidoo.tv>,
	=?UTF-8?q?=E8=92=8B=E4=B8=BD=E7=90=B4?= <jiang.liqin@geniatech.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] arm64: dts: realtek: Add watchdog node for RTD1295
Date: Tue,  5 Sep 2017 01:16:02 +0200
Message-Id: <20170904231602.29787-4-afaerber@suse.de>
In-Reply-To: <20170904231602.29787-1-afaerber@suse.de>
References: <20170904231602.29787-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Add the watchdog node to the RTD1295 Device Tree.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 Depends on the pending clock nodes patch.
 
 v1 -> v2: Unchanged
 
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index fbbd6456079e..f39ab63f879d 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -123,6 +123,12 @@
 			#interrupt-cells = <1>;
 		};
 
+		watchdog@98007680 {
+			compatible = "realtek,rtd1295-watchdog";
+			reg = <0x98007680 0x100>;
+			clocks = <&osc27M>;
+		};
+
 		uart0: serial@98007800 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x98007800 0x400>;
-- 
2.13.5
