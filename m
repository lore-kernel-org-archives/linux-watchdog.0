Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12219 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab3LFFo5 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Dec 2013 00:44:57 -0500
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, wim@iguana.be
Cc: dianders@chromium.org, kgene.kim@samsung.com, t.figa@samsung.com,
	devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	cpgs@samsung.com, linux@roeck-us.net
Subject: [PATCH V12 3/3] ARM: dts: update watchdog device nodes for Exynos5250
 and Exynos5420
Date: Fri, 06 Dec 2013 11:17:48 +0530
Message-id: <1386308868-30264-4-git-send-email-l.krishna@samsung.com>
In-reply-to: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
References: <1386308868-30264-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In Exynos5 series SoCs, PMU has registers to enable/disable mask/unmask
watchdog timer which is not the case with s3c series SoCs so, there is a
need to have different compatible names for watchdog to handle these pmu
registers access.

Hence this patch removes watchdog node from Exynos5.dtsi common file and
make it separate by updating existing node in Exynos5250 and adding new node
to Exynos5420. This patch also makes the watchdog node enabled by default

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5.dtsi    |    7 -------
 arch/arm/boot/dts/exynos5250.dtsi |    6 +++++-
 arch/arm/boot/dts/exynos5420.dtsi |    9 +++++++++
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index e52b038..f1fea28 100644
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
index 62f9e36..d440a9a 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -168,9 +168,13 @@
 		reg = <0x10040000 0x5000>;
 	};
 
-	watchdog {
+	watchdog@101D0000 {
+		compatible = "samsung,exynos5250-wdt";
+		reg = <0x101D0000 0x100>;
+		interrupts = <0 42 0>;
 		clocks = <&clock 336>;
 		clock-names = "watchdog";
+		samsung,syscon-phandle = <&pmu_system_controller>;
 	};
 
 	g2d@10850000 {
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index cd47db0..167480c 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -407,4 +407,13 @@
 		compatible = "samsung,exynos5420-pmu", "syscon";
 		reg = <0x10040000 0x5000>;
 	};
+
+        watchdog@101D0000 {
+		compatible = "samsung,exynos5420-wdt";
+		reg = <0x101D0000 0x100>;
+		interrupts = <0 42 0>;
+		clocks = <&clock 316>;
+		clock-names = "watchdog";
+		samsung,syscon-phandle = <&pmu_system_controller>;
+        };
 };
-- 
1.7.10.4

