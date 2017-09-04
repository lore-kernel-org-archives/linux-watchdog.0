Return-Path: <afaerber@suse.de>
Return-path: <afaerber@suse.de>
From: =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Roc He <hepeng@zidoo.tv>,
	=?UTF-8?q?=E8=92=8B=E4=B8=BD=E7=90=B4?= <jiang.liqin@geniatech.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	devicetree@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: Realtek RTD1295 watchdog
Date: Tue,  5 Sep 2017 01:15:59 +0200
Message-Id: <20170904231602.29787-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

This series adds the watchdog for the Realtek RTD1295 SoC.

v2 does minor cleanups.

The implementation is based on register offsets seen in the vendor DT,
as well as older mach-rtk119x code published by QNAP.

The DT node depends on my RTD1295 clk series.

More experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Prepared remove (Guenther)
* Set timeout field (Guenther)
* Cleanups (Guenther, Andreas)

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Cc: Roc He <hepeng@zidoo.tv>
Cc: 蒋丽琴 <jiang.liqin@geniatech.com>
Cc: devicetree@vger.kernel.org

Andreas Färber (3):
  dt-bindings: watchdog: Add Realtek RTD1295
  watchdog: Add Realtek RTD1295
  arm64: dts: realtek: Add watchdog node for RTD1295

 .../bindings/watchdog/realtek,rtd119x.txt          |  17 +++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |   6 +
 drivers/watchdog/Kconfig                           |  10 ++
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/rtd119x_wdt.c                     | 168 +++++++++++++++++++++
 5 files changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/realtek,rtd119x.txt
 create mode 100644 drivers/watchdog/rtd119x_wdt.c

-- 
2.13.5
