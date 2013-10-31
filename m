Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:49911 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570Ab3JaFkk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 01:40:40 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be
Cc: t.figa@samsung.com, devicetree@vger.kernel.org,
	dianders@chromium.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, sachin.kamat@linaro.org
Subject: [PATCH V5 2/3] ARM: dts: add watchdog device nodes for Exynos5250 and
 Exynos5420
Date: Thu, 31 Oct 2013 11:30:49 +0530
Message-id: <1383199250-15405-3-git-send-email-l.krishna@samsung.com>
In-reply-to: <1383199250-15405-1-git-send-email-l.krishna@samsung.com>
References: <1383199250-15405-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Adds watchdog device nodes to the DT device list for Exynos5250 and Exynos5420

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi    |    7 -------
 arch/arm/boot/dts/exynos5250.dtsi |    7 ++++++-
 arch/arm/boot/dts/exynos5420.dtsi |   10 ++++++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index ad6e47c9..e6ab5d9 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -81,13 +81,6 @@
 		status = "disabled";
 	};
 
-	watchdog {
-		compatible = "samsung,s3c2410-wdt";
-		reg = <0x101D0000 0x100>;
-		interrupts = <0 42 0>;
-		status = "disabled";
-	};
-
 	fimd@14400000 {
 		compatible = "samsung,exynos5250-fimd";
 		interrupt-parent = <&combiner>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index c4a8662..7e4867f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -158,9 +158,14 @@
 		interrupts = <0 47 0>;
 	};
 
-	watchdog {
+	watchdog@101D0000 {
+		compatible = "samsung,exynos5250-wdt";
+		reg = <0x101D0000 0x100>;
+		interrupts = <0 42 0>;
 		clocks = <&clock 336>;
 		clock-names = "watchdog";
+		samsung,syscon-phandle = <&pmu_syscon>;
+		status = "okay";
 	};
 
 	g2d@10850000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 6ffefd1..8585fe7 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -369,4 +369,14 @@
 		clock-names = "gscl";
 		samsung,power-domain = <&gsc_pd>;
 	};
+
+        watchdog@101D0000 {
+		compatible = "samsung,exynos5420-wdt";
+		reg = <0x101D0000 0x100>;
+		interrupts = <0 42 0>;
+		clocks = <&clock 316>;
+		clock-names = "watchdog";
+		samsung,syscon-phandle = <&pmu_syscon>;
+		status = "okay";
+        };
 };
-- 
1.7.10.4

