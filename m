Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39851 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751268AbdBXPRF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
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
Subject: [PATCH 6/8] ARM: dts: exynos: Fix infinite interrupt in soft mode on Exynos5440
Date: Fri, 24 Feb 2017 17:11:20 +0200
Message-Id: <20170224151122.12142-7-krzk@kernel.org>
In-Reply-To: <20170224151122.12142-1-krzk@kernel.org>
References: <20170224151122.12142-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
of an interrupt.  The interrupt has to be cleared, because otherwise
system enters infinite interrupt handling loop.

Use a samsung,s3c6410-wdt compatible to select appropriate quirk for
clearing the watchdog interrupt.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5440.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 77d35bb92950..abfe054b2187 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -189,7 +189,7 @@
 	};
 
 	watchdog@110000 {
-		compatible = "samsung,s3c2410-wdt";
+		compatible = "samsung,s3c6410-wdt";
 		reg = <0x110000 0x1000>;
 		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&clock CLK_B_125>;
-- 
2.9.3

