Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from asav21.altibox.net ([109.247.116.8]:59692 "EHLO
	asav21.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbbFMLjs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 13 Jun 2015 07:39:48 -0400
From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH v2 3/3] ARM: dts: bcm2835-rpi: Add "brcm,raspberrypi-pm-wdt" to wdt compatible
Date: Sat, 13 Jun 2015 13:39:01 +0200
Message-Id: <1434195541-28368-3-git-send-email-noralf@tronnes.org>
In-Reply-To: <1434195541-28368-1-git-send-email-noralf@tronnes.org>
References: <1434195541-28368-1-git-send-email-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Raspberry Pi uses a new value for halt in the PM_RSTS watchdog
register. Expand the compatible string to cover this.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ++++
 arch/arm/boot/dts/bcm2835.dtsi     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 46780bb..feb1282 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -16,6 +16,10 @@
 	};
 };
 
+&watchdog {
+	compatible = "brcm,raspberrypi-pm-wdt", "brcm,bcm2835-pm-wdt";
+};
+
 &gpio {
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..3445bb3 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -52,7 +52,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		watchdog@7e100000 {
+		watchdog: watchdog@7e100000 {
 			compatible = "brcm,bcm2835-pm-wdt";
 			reg = <0x7e100000 0x28>;
 		};
-- 
2.2.2

