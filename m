Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbdBXPRF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 10:17:05 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 5/8] ARM: dts: exynos: Enable watchdog on all Exynos4 boards
Date: Fri, 24 Feb 2017 17:11:19 +0200
Message-Id: <20170224151122.12142-6-krzk@kernel.org>
In-Reply-To: <20170224151122.12142-1-krzk@kernel.org>
References: <20170224151122.12142-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Watchdog module does not have external dependencies so it can be safely
enabled in exynos4.dtsi thus making it available for all Exynos4-based
boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts         | 4 ----
 arch/arm/boot/dts/exynos4210.dtsi               | 1 -
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 4 ----
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ----
 arch/arm/boot/dts/exynos4412-origen.dts         | 4 ----
 arch/arm/boot/dts/exynos4412.dtsi               | 1 -
 6 files changed, 18 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index a2c6a13fe67b..312650e2450f 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -328,7 +328,3 @@
 &tmu {
 	status = "okay";
 };
-
-&watchdog {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index e126357aba9a..e6e62103a71f 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -125,7 +125,6 @@
 		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_WDT>;
 		clock-names = "watchdog";
-		status = "disabled";
 	};
 
 	clock: clock-controller@10030000 {
diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index a36cd36a26b8..4cd62487bb16 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -495,7 +495,3 @@
 	vtmu-supply = <&ldo16_reg>;
 	status = "okay";
 };
-
-&watchdog {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
index 78f118cb73d4..0f1ff792fe44 100644
--- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
+++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
@@ -555,7 +555,3 @@
 	vtmu-supply = <&ldo10_reg>;
 	status = "okay";
 };
-
-&watchdog {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index a1ab6f94bb64..7a83e2df18a6 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -541,7 +541,3 @@
 &serial_3 {
 	status = "okay";
 };
-
-&watchdog {
-	status = "okay";
-};
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 6f47988a1ab5..cc69466f17c0 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -222,7 +222,6 @@
 		clocks = <&clock CLK_WDT>;
 		clock-names = "watchdog";
 		samsung,syscon-phandle = <&pmu_system_controller>;
-		status = "disabled";
 	};
 
 	adc: adc@126C0000 {
-- 
2.9.3

