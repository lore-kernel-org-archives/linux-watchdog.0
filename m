Return-Path: <anholt@anholt.net>
Return-path: <anholt@anholt.net>
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	devicetree@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH v3 5/5] ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware.
Date: Fri, 30 Nov 2018 12:27:43 -0800
Message-Id: <20181130202743.20585-6-eric@anholt.net>
In-Reply-To: <20181130202743.20585-1-eric@anholt.net>
References: <20181130202743.20585-1-eric@anholt.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

The GRAFX domain only contains V3D, and this driver should be the only
accessor of V3D (firmware usage gets disabled when V3D is in the DT),
so we can safely make Linux control the GRAFX and GRAFX_V3D power
domains.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ----
 arch/arm/boot/dts/bcm283x.dtsi     | 4 +++-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index cb2d6d78a7fb..21a930148709 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -87,10 +87,6 @@
 	power-domains = <&power RPI_POWER_DOMAIN_USB>;
 };
 
-&v3d {
-	power-domains = <&power RPI_POWER_DOMAIN_V3D>;
-};
-
 &hdmi {
 	power-domains = <&power RPI_POWER_DOMAIN_HDMI>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index bd5be68b4561..ce7bc9cc43ae 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/clock/bcm2835-aux.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/soc/bcm2835-pm.h>
 
 /* firmware-provided startup stubs live here, where the secondary CPUs are
  * spinning.
@@ -120,7 +121,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		watchdog@7e100000 {
+		pm: watchdog@7e100000 {
 			compatible = "brcm,bcm2835-pm", "brcm,bcm2835-pm-wdt";
 			#power-domain-cells = <1>;
 			#reset-cells = <1>;
@@ -637,6 +638,7 @@
 			compatible = "brcm,bcm2835-v3d";
 			reg = <0x7ec00000 0x1000>;
 			interrupts = <1 10>;
+			power-domains = <&pm BCM2835_POWER_DOMAIN_GRAFX_V3D>;
 		};
 
 		vc4: gpu {
-- 
2.20.0.rc1
