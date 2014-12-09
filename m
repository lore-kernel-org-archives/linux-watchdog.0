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
Subject: [PATCH 2/4] DT: i2c: Add devices handled by the da9063 MFD driver
Date: Tue,  9 Dec 2014 12:22:47 +0100
Message-Id: <1418124169-7123-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

This allows checkpatch to validate more DTSes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree@vger.kernel.org
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index e0beef4f8cff5cdf..3bc4ea3c5c4842ff 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -47,6 +47,7 @@ dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
 dallas,ds4510		CPU Supervisor with Nonvolatile Memory and Programmable I/O
 dallas,ds75		Digital Thermometer and Thermostat
 dlg,da9053		DA9053: flexible system level PMIC with multicore support
+dlg,da9063		DA9063: system PMIC for quad-core application processors
 epson,rx8025		High-Stability. I2C-Bus INTERFACE REAL TIME CLOCK MODULE
 epson,rx8581		I2C-BUS INTERFACE REAL TIME CLOCK MODULE
 fsl,mag3110		MAG3110: Xtrinsic High Accuracy, 3D Magnetometer
-- 
1.9.1
