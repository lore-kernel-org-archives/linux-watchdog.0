Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:27655 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab3IQKW2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Sep 2013 06:22:28 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org
Cc: wim@iguana.be, kgene.kim@samsung.com, devicetree@vger.kernel.org,
	t.figa@samsung.com, dianders@chromium.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: add watchdog device tree node for exynos5420
Date: Tue, 17 Sep 2013 16:13:41 +0530
Message-id: <1379414623-26329-3-git-send-email-l.krishna@samsung.com>
In-reply-to: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
References: <1379414623-26329-1-git-send-email-l.krishna@samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add watchdog device tree node for exynos5420

Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
---
 arch/arm/boot/dts/exynos5420.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index d537cd7..9fadc23 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -186,6 +186,12 @@
 		status = "okay";
 	};
 
+	watchdog@101D0000 {
+		clocks = <&clock 316>;
+		clock-names = "watchdog";
+		status = "okay";
+	};
+
 	serial@12C00000 {
 		clocks = <&clock 257>, <&clock 128>;
 		clock-names = "uart", "clk_uart_baud0";
-- 
1.7.9.5

