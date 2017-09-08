Return-Path: <mathieu@macbookpro.malat.net>
Return-path: <mathieu@macbookpro.malat.net>
From: Mathieu Malaterre <malat@debian.org>
To: 
Cc: Mathieu Malaterre <malat@debian.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Paul Cercueil <paul@crapouillou.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	devicetree@vger.kernel.org,
	linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/3] MIPS: Ci20: Enable watchdog driver
Date: Fri,  8 Sep 2017 20:35:53 +0200
Message-Id: <20170908183558.1537-1-malat@debian.org>
List-ID: <linux-watchdog@vger.kernel.org>

Update the Ci20's defconfig to enable the JZ4740's watchdog driver.

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/mips/configs/ci20_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/configs/ci20_defconfig b/arch/mips/configs/ci20_defconfig
index b42cfa7865f9..459b21e6278d 100644
--- a/arch/mips/configs/ci20_defconfig
+++ b/arch/mips/configs/ci20_defconfig
@@ -92,6 +92,8 @@ CONFIG_I2C=y
 CONFIG_I2C_JZ4780=y
 CONFIG_GPIO_SYSFS=y
 # CONFIG_HWMON is not set
+CONFIG_WATCHDOG=y
+CONFIG_JZ4740_WDT=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DEBUG=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.11.0
