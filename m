Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751326AbdBXPVN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
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
Subject: [PATCH 4/8] ARM: dts: s3c64xx: Enable watchdog on all S3C64xx boards
Date: Fri, 24 Feb 2017 17:11:18 +0200
Message-Id: <20170224151122.12142-5-krzk@kernel.org>
In-Reply-To: <20170224151122.12142-1-krzk@kernel.org>
References: <20170224151122.12142-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Watchdog module does not have external dependencies so it can be safely
enabled in s3c64xx.dtsi thus making it available for all S3C64xx-based
boards.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s3c64xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/s3c64xx.dtsi b/arch/arm/boot/dts/s3c64xx.dtsi
index 0ccb414cd268..6caec5f27d38 100644
--- a/arch/arm/boot/dts/s3c64xx.dtsi
+++ b/arch/arm/boot/dts/s3c64xx.dtsi
@@ -100,7 +100,6 @@
 			interrupts = <26>;
 			clock-names = "watchdog";
 			clocks = <&clocks PCLK_WDT>;
-			status = "disabled";
 		};
 
 		i2c0: i2c@7f004000 {
-- 
2.9.3

