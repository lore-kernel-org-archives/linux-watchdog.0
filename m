Return-path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Fabio Estevam <fabio.estevam@nxp.com>
Cc: kernel@pengutronix.de,
	Magnus Lilja <lilja.magnus@gmail.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] watchdog: imx2: handle WMCR only being available on i.MX35 and later
Date: Mon,  9 Jan 2017 10:50:36 +0100
Message-Id: <20170109095039.11979-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello,

this is my approach to fix the issue reported by Vladimir Zapolskiy.

IMHO we don't need the third commit because I'm convinced most machines
just don't do anything when the WDOG signal becomes active. An affected
machine powers off 16 seconds after startup. This would be noticed
during development of the bootloader and so I assume all affected
machines having bootloaders that make the compat code unimportant.

If you want to know if your machine is affected, do:

	mw -w $(watchdog_base_addr) 0x10

The machines I tested this on (among a few customer boards a
Phycore i.MX35 and a Freescale i.MX53 Quick Start Board) don't power off.

I don't have manuals handy for ls1021a, ls1043a and ls1046a but assume
they use the i.MX35 type, too. This needs to be fixed before this series
is applied.

Compared to Vladimir's patch machines still using board files are fixed,
too.

On Thu, Dec 29, 2016 at 09:40:00PM -0200, Fabio Estevam wrote:
> On Thu, Dec 29, 2016 at 8:04 PM, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> 
> > Ack. If you teach the driver now about i.MX35 and only make use of the WMCR
> > register on this one, the possible breakage is that this register isn't
> > written to on the i.MX35 type until the dtb is updated.
> 
> So basically you are saying that you don't care about old dtb compatibility.

No, I weight old dtb compatibility which IMHO doesn't buy us anything in
this case against maintenance overhead.

> As far as I can see this is the reason we have not made any progress
> with this patch since September.

I want to disagree with this. I replied the first time with my concerns
about the compat code on December 11, so I'm not responsible for the
time before that date. Also on December 23 I said that if Vladimir
really wants that compat code he should add it. The delay between
December 11 and December 23 isn't mine either. In this thread I am a
reviewer and so it's unfair to point at me when wailing about delays. I
mentioned my doubts and if you don't agree or understand the patch
submitter is free to discuss or ask the maintainer to overrule my
opinion.

Best regards
Uwe

Uwe Kleine-König (3):
  watchdog: imx2: Only i.MX35 and later have a WMCR register
  dts: teach newer i.MX machines to have the i.MX35 type watchdog
  watchdog: imx2: add compatibility for new i.MX35 type watchdog

 .../devicetree/bindings/watchdog/fsl-imx-wdt.txt   |  2 +-
 arch/arm/boot/dts/imx25.dtsi                       |  2 +-
 arch/arm/boot/dts/imx35.dtsi                       |  2 +-
 arch/arm/boot/dts/imx50.dtsi                       |  2 +-
 arch/arm/boot/dts/imx51.dtsi                       |  2 +-
 arch/arm/boot/dts/imx53.dtsi                       |  2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  2 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |  4 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |  6 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |  4 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  8 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |  2 +-
 arch/arm/mach-imx/devices/devices-common.h         |  1 +
 arch/arm/mach-imx/devices/platform-imx2-wdt.c      | 13 +--
 drivers/watchdog/imx2_wdt.c                        | 97 ++++++++++++++++++++--
 15 files changed, 116 insertions(+), 33 deletions(-)

-- 
2.11.0
