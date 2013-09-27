Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:14737 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3I0Jz0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 05:55:26 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	kgene.kim@samsung.com
Cc: devicetree@vger.kernel.org, t.figa@samsung.com,
	dianders@chromium.org, linux-watchdog@vger.kernel.org
Subject: [PATCH V2 1/4] ARM: dts: Fix the watchdog DT node name for Exynos5
Date: Fri, 27 Sep 2013 15:46:23 +0530
Message-id: <1380276986-24131-2-git-send-email-l.krishna@samsung.com>
In-reply-to: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
References: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
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

