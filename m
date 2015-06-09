Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from asav22.altibox.net ([109.247.116.9]:42584 "EHLO
	asav22.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752696AbbFIK27 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Jun 2015 06:28:59 -0400
From: =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>
Subject: [PATCH 3/3] ARM: dts: bcm2835-rpi: Add "brcm,raspberrypi-pm-wdt" to wdt compatible
Date: Tue,  9 Jun 2015 12:21:45 +0200
Message-Id: <1433845305-17329-3-git-send-email-noralf@tronnes.org>
In-Reply-To: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
References: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
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

