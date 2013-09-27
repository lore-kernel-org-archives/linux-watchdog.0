Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:63267 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab3I0Jzb (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 27 Sep 2013 05:55:31 -0400
From: Leela Krishna Amudala <l.krishna@samsung.com>
To: linux-samsung-soc@vger.kernel.org, wim@iguana.be,
	kgene.kim@samsung.com
Cc: devicetree@vger.kernel.org, t.figa@samsung.com,
	dianders@chromium.org, linux-watchdog@vger.kernel.org
Subject: [PATCH V2 2/4] ARM: dts: add watchdog device tree node for exynos5420
Date: Fri, 27 Sep 2013 15:46:24 +0530
Message-id: <1380276986-24131-3-git-send-email-l.krishna@samsung.com>
In-reply-to: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
References: <1380276986-24131-1-git-send-email-l.krishna@samsung.com>
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

