Return-path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <wsa@the-dreams.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	devicetree@vger.kernel.org
Subject: [PATCH 3/4] ARM: shmobile: koelsch: Add DA9063 PMIC device node for system restart
Date: Tue,  9 Dec 2014 12:22:48 +0100
Message-Id: <1418124169-7123-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

Add a minimal device node for the DA9063 PMIC, which is connected to i2c6.
This allows the system to be restarted when the watchdog timer times
out, or when a system restart is requested.

Regulator support is not yet included, as no DT support code nor DT
binding documentation exists for the regulator functionality.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
Restart by watchdog timeout is working now.
Manual system restart depends on "[PATCH 1/4] watchdog: da9063: Add restart
handler support".
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 6938377d3798644b..a400c27a813f1a8b 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -524,6 +524,13 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	pmic@58 {
+		compatible = "dlg,da9063";
+		reg = <0x58>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+	};
 };
 
 &pci0 {
-- 
1.9.1
