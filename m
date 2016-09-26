Return-path: <vz@mleia.com>
From: Vladimir Zapolskiy <vz@mleia.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [RFC PATCH 0/2] watchdog: imx2+: fix hangup during watchdog initialization
Date: Mon, 26 Sep 2016 03:39:19 +0300
Message-Id: <1474850361-20884-1-git-send-email-vz@mleia.com>
List-ID: <linux-watchdog@vger.kernel.org>

It was discovered that the current version of imx2+ watchdog driver
does not work properly on i.MX31 boards and due to the same root
cause the kernel should not work on i.MX21 and i.MX27 powered boards,
if watchdog device driver is probed.

The root cause is that the watchdog controller on all modern SoCs from
i.MX series has two more registers in comparison to the watchdog on
i.MX21, i.MX27 and i.MX31, thus write access to the non-existing
register by the driver probe function causes a core hang.

The commit which caused a regression is 5fe65ce7ccbb ("watchdog:
imx2_wdt: Disable power down counter on boot"), for me it's hard
to say if this change is utterly needed or not (e.g. if it is done
in a bootloader), but it seems to be valid for modern i.MX SoCs.

The solution introduces a runtime difference between i.MX21 and i.MX25
compatible watchdog controllers, also this is reflected in the
updated DTS files.

The change is an RFC, because
* it is based on v4.8-rc1 and it will be rebased after getting review
  comments,
* the selection of compatible watchdog controllers is partially done
  on RMs, but I don't have access to all of them,
* the change fixes legacy boards (prior to DT support), but the fix is
  excessive in sense that WMCR register won't be set on them, to cover
  this case I feel reluctant to add a new header with platform data
  structure declaration for legacy boards, but comments are welcome
* I don't know if a complete list of watchdog compatibles (which is
  expected to be growing with time) is wanted in the driver code,
* if the DT change from the series is added, then only a check for
  fsl,imx25-wdt compatible migth be good enough, but this will
  nullify "disable power down counter" change for boards with
  not updated DTBs.
* note that ls1021a.dtsi does not have its named watchdog compatible,
  I know that Rob insists on adding SoC-named compatibles for
  controllers, this may help in situations like this one, other
  opinions or discussion or fix for LS1021A is welcome.

Vladimir Zapolskiy (2):
  watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27 and i.MX31 SoCs
  ARM: i.MX: dts: add fsl,imx25-wdt compatible to all relevant watchdog nodes

 arch/arm/boot/dts/imx35.dtsi   |  3 ++-
 arch/arm/boot/dts/imx50.dtsi   |  3 ++-
 arch/arm/boot/dts/imx51.dtsi   |  6 ++++--
 arch/arm/boot/dts/imx53.dtsi   |  6 ++++--
 arch/arm/boot/dts/imx6qdl.dtsi |  6 ++++--
 arch/arm/boot/dts/imx6sl.dtsi  |  6 ++++--
 arch/arm/boot/dts/imx6sx.dtsi  |  9 +++++---
 arch/arm/boot/dts/imx6ul.dtsi  |  6 ++++--
 arch/arm/boot/dts/imx7s.dtsi   | 12 +++++++----
 arch/arm/boot/dts/ls1021a.dtsi |  2 +-
 arch/arm/boot/dts/vfxxx.dtsi   |  3 ++-
 drivers/watchdog/imx2_wdt.c    | 47 ++++++++++++++++++++++++++++++++++++++++--
 12 files changed, 86 insertions(+), 23 deletions(-)

-- 
2.8.1
