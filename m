Return-path: <tharvey@gateworks.com>
From: Tim Harvey <tharvey@gateworks.com>
To: linux-watchdog@vger.kernel.org,
	Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Akshay Bhat <akshay.bhat@timesys.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Stefan Roese <sr@denx.de>,
	Iain Paton <ipaton0@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 0/2] imx6: Implement external watchdog reset
Date: Fri,  1 Apr 2016 08:16:42 -0700
Message-Id: <1459523804-11390-1-git-send-email-tharvey@gateworks.com>
List-ID: <linux-watchdog@vger.kernel.org>

The IMX6 watchdog supports assertion of a signal (WDOG_B) which
can be pinmux'd to an external pin. This is typically used for boards that
have PMIC's in control of the IMX6 power rails. In fact, failure to use
such an external reset on boards with external PMIC's can result in various
hangs due to the IMX6 not being fully reset [1] as well as the board failing
to reset because its PMIC has not been reset to provide adequate voltage for
the CPU when coming out of reset at 800Mhz.

This uses a new device-tree property 'fsl,ext-reset-output' to indicate the
board has such a reset and to cause the watchdog to be configured to assert
WDOG_B instead of an internal reset both on a watchdog timeout and in
system_restart.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/333689.html

Cc: Fabio Estevam <festevam@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Stefan Roese <sr@denx.de>
Cc: Iain Paton <ipaton0@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Akshay Bhat <akshay.bhat@timesys.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Tim Harvey (2):
  watchdog: imx2_wdt: add external reset support via 'ext-reset-output'
    dt prop
  ARM: dts: imx: ventana: Add wdt ext-reset support

 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt      |  4 +++-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi                 | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi                 | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi                 | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi                 | 17 +++++++++++++++++
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi                 | 12 ++++++++++++
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi                 | 12 ++++++++++++
 drivers/watchdog/imx2_wdt.c                           | 19 +++++++++++++++++--
 8 files changed, 97 insertions(+), 3 deletions(-)

-- 
1.9.1
