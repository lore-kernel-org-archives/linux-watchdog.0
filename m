Return-path: <krzk@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/8] watchdog: s3c2410: Fixes and improvements
Date: Fri, 24 Feb 2017 17:11:14 +0200
Message-Id: <20170224151122.12142-1-krzk@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

Minor cleanup and some fixes for the watchdog used on all
Samsung SoCs.

The patches are independent of each other - DTS will go through
separate (my) tree.


Best regards,
Krzysztof

Krzysztof Kozlowski (8):
  watchdog: s3c2410: Remove confusing CONFIG prefix from local defines
  watchdog: s3c2410: Fix infinite interrupt in soft mode
  ARM: dts: exynos: Fix watchdog reset on Exynos4412
  ARM: dts: s3c64xx: Enable watchdog on all S3C64xx boards
  ARM: dts: exynos: Enable watchdog on all Exynos4 boards
  ARM: dts: exynos: Fix infinite interrupt in soft mode on Exynos5440
  ARM: dts: s3c64xx: Fix infinite interrupt in soft mode
  ARM: dts: s5pv210: Fix infinite interrupt in soft mode

 .../devicetree/bindings/watchdog/samsung-wdt.txt   |  9 +++---
 arch/arm/boot/dts/exynos4.dtsi                     |  9 ------
 arch/arm/boot/dts/exynos4210-origen.dts            |  4 ---
 arch/arm/boot/dts/exynos4210.dtsi                  |  8 +++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    |  4 ---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  4 ---
 arch/arm/boot/dts/exynos4412-origen.dts            |  4 ---
 arch/arm/boot/dts/exynos4412.dtsi                  |  9 ++++++
 arch/arm/boot/dts/exynos5440.dtsi                  |  2 +-
 arch/arm/boot/dts/s3c64xx.dtsi                     |  3 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |  2 +-
 drivers/watchdog/s3c2410_wdt.c                     | 37 +++++++++++++++-------
 12 files changed, 51 insertions(+), 44 deletions(-)

-- 
2.9.3
