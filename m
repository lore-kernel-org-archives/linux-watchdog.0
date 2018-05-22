Return-Path: <ray.jui@broadcom.com>
Return-path: <ray.jui@broadcom.com>
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 4/5] arm64: dt: set initial SR watchdog timeout to 60 seconds
Date: Tue, 22 May 2018 11:47:19 -0700
Message-Id: <1527014840-21236-5-git-send-email-ray.jui@broadcom.com>
In-Reply-To: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
References: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
List-ID: <linux-watchdog@vger.kernel.org>

Set initial Stingray watchdog timeout to 60 seconds

By the time when the userspace watchdog daemon is ready and taking
control over, the watchdog timeout will then be reset to what's
configured in the daemon

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 99aaff0..1e1cf49 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -420,6 +420,7 @@
 			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&hsls_25m_div2_clk>, <&hsls_div4_clk>;
 			clock-names = "wdogclk", "apb_pclk";
+			timeout-sec = <60>;
 		};
 
 		gpio_hsls: gpio@d0000 {
-- 
2.1.4
