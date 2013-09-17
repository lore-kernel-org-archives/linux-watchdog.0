Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64161 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab3IQKW1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Sep 2013 06:22:27 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org
Cc: wim@iguana.be, kgene.kim@samsung.com, devicetree@vger.kernel.org,
	t.figa@samsung.com, dianders@chromium.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: Fix the watchdog DT node name for Exynos5
Date: Tue, 17 Sep 2013 16:13:40 +0530
Message-id: <1379414623-26329-2-git-send-email-l.krishna@samsung.com>
In-reply-to: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fixes the watchdog DT node name for Exynos5 as per the DT node naming
convention also update "status" property for Exynos5250 SoC.

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi    |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 074739d..a8bf0c2 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -102,7 +102,7 @@
 		status = "disabled";
 	};
 
-	watchdog {
+	watchdog@101D0000 {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x101D0000 0x100>;
 		interrupts = <0 42 0>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 7d7cc77..6bb42cf 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -158,9 +158,10 @@
 		interrupts = <0 47 0>;
 	};
 
-	watchdog {
+	watchdog@101D0000 {
 		clocks = <&clock 336>;
 		clock-names = "watchdog";
+		status = "okay";
 	};
 
 	g2d@10850000 {
-- 
1.7.9.5

