Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbdBXPVN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 10:21:13 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 3/8] ARM: dts: exynos: Fix watchdog reset on Exynos4412
Date: Fri, 24 Feb 2017 17:11:17 +0200
Message-Id: <20170224151122.12142-4-krzk@kernel.org>
In-Reply-To: <20170224151122.12142-1-krzk@kernel.org>
References: <20170224151122.12142-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Exynos4412 has the same watchdog as newer SoCs (e.g. Exynos5250).
Just like the others, for working it requires additional steps in Power
Management Unit: unmasking the reset request and enabling the system
reset.  Without these additional steps in PMU, the watchdog will not be
able to reset the system on expiration event.

Change the compatible of Exynos4412 watchdog device node to
samsung,exynos5250-wdt which includes the additional PMU steps.

This will also fix infinite watchdog interrupt in soft mode (lack of
interrupt clear) because it is also included in samsung,exynos5250-wdt.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4.dtsi    |  9 ---------
 arch/arm/boot/dts/exynos4210.dtsi |  9 +++++++++
 arch/arm/boot/dts/exynos4412.dtsi | 10 ++++++++++
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 18def1c774d5..71e2cdae6068 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -283,15 +283,6 @@
 		};
 	};
 
-	watchdog: watchdog@10060000 {
-		compatible = "samsung,s3c2410-wdt";
-		reg = <0x10060000 0x100>;
-		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&clock CLK_WDT>;
-		clock-names = "watchdog";
-		status = "disabled";
-	};
-
 	rtc: rtc@10070000 {
 		compatible = "samsung,s3c6410-rtc";
 		reg = <0x10070000 0x100>;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index f9408188f97f..e126357aba9a 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -119,6 +119,15 @@
 		};
 	};
 
+	watchdog: watchdog@10060000 {
+		compatible = "samsung,s3c6410-wdt";
+		reg = <0x10060000 0x100>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clock CLK_WDT>;
+		clock-names = "watchdog";
+		status = "disabled";
+	};
+
 	clock: clock-controller@10030000 {
 		compatible = "samsung,exynos4210-clock";
 		reg = <0x10030000 0x20000>;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 235bbb69ad7c..6f47988a1ab5 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -215,6 +215,16 @@
 		};
 	};
 
+	watchdog: watchdog@10060000 {
+		compatible = "samsung,exynos5250-wdt";
+		reg = <0x10060000 0x100>;
+		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clock CLK_WDT>;
+		clock-names = "watchdog";
+		samsung,syscon-phandle = <&pmu_system_controller>;
+		status = "disabled";
+	};
+
 	adc: adc@126C0000 {
 		compatible = "samsung,exynos-adc-v1";
 		reg = <0x126C0000 0x100>;
-- 
2.9.3

