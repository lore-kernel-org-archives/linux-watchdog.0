Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64178 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479Ab3IQKWb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Sep 2013 06:22:31 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org
Cc: wim@iguana.be, kgene.kim@samsung.com, devicetree@vger.kernel.org,
	t.figa@samsung.com, dianders@chromium.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 4/4] ARM: dts: exynos: add PMU registers addresses and mask bit
 to watchdog node
Date: Tue, 17 Sep 2013 16:13:43 +0530
Message-id: <1379414623-26329-5-git-send-email-l.krishna@samsung.com>
In-reply-to: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds support for specifying the pmu registers and masking bit
for watchdog to enable/disable and mask/unmask the watchdog reset request.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/boot/dts/exynos5.dtsi    |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi |    1 +
 arch/arm/boot/dts/exynos5420.dtsi |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index a8bf0c2..e1cc6ef 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -104,7 +104,7 @@
 
 	watchdog@101D0000 {
 		compatible = "samsung,s3c2410-wdt";
-		reg = <0x101D0000 0x100>;
+		reg = <0x101D0000 0x100>, <0x10040408 0x4>, <0x1004040c 0x4>;
 		interrupts = <0 42 0>;
 		status = "disabled";
 	};
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 6bb42cf..8bf28a7a 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -161,6 +161,7 @@
 	watchdog@101D0000 {
 		clocks = <&clock 336>;
 		clock-names = "watchdog";
+		reset-mask-bit = <20>;
 		status = "okay";
 	};
 
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 9fadc23..29235ea 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -189,6 +189,7 @@
 	watchdog@101D0000 {
 		clocks = <&clock 316>;
 		clock-names = "watchdog";
+		reset-mask-bit = <0>;
 		status = "okay";
 	};
 
-- 
1.7.9.5

