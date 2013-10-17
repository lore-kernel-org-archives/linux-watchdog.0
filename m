Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:40386 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760887Ab3JQAmT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 16 Oct 2013 20:42:19 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so1800457pde.10
        for <linux-watchdog@vger.kernel.org>; Wed, 16 Oct 2013 17:42:19 -0700 (PDT)
Date: Wed, 16 Oct 2013 17:42:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 3.13
Message-ID: <20131017004211.GA21391@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

Please consider pulling watchdog updates for Linux 3.13 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git =
watchdog-for-wim

The tag has been applied on top of the watchdog-next branch. It includes
a number of patches I collected over the last few months. It does not inclu=
de
all submitted patches; only the ones I reviewed and felt comfortable with a=
re
included.

I reviewed all patches and ran build tests as well as source verification t=
ests
using both smatch and spatch. The branch has been available on my Linux
repository on kernel.org for a while, so presumably Fengguang's robot should
have built the code as well. The w83627hf patches have been running on
multiple servers for more than a month without problems.

You can find the most recent build results at
http://server.roeck-us.net:8010/builders/watchdog-next.

If you don't want to pull the entire series, please consider applying whate=
ver
subset you might feel comfortable with.

Thanks,
Guenter
------

The following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:

  Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git ta=
gs/watchdog-for-wim

for you to fetch changes up to 59e22f7ffeb6b714bc69fd498e280ba6a58d3b61:

  watchdog: ts72xx_wdt: Propagate return value from timeout_to_regval (2013=
-10-14 09:46:49 -0700)

----------------------------------------------------------------
w83627hf:
	Convert to watchdog infrastructure, add support for W83697HF
	and W83697UG, and various other improvements.

Remove explicit drivers for W83697HF and W83697UG

New drivers:
	MOXA ART watchdog driver
	MIPS ralink watchdog driver
	CSR SiRFprimaII and SiRFatlasVI

Various improvements and cleanup in several drivers

----------------------------------------------------------------
Boris BREZILLON (4):
      watchdog: at91sam9_wdt: better watchdog support
      watchdog: at91sam9_wdt: update device tree doc
      ARM: at91/dt: add sam9 watchdog default options to SoCs
      ARM: at91/dt: add watchdog properties to kizbox board

Dan Carpenter (1):
      watchdog: ts72xx_wdt: cleanup return codes in ioctl

Dinh Nguyen (1):
      watchdog: dw: Enable OF support for DW watchdog timer.

Guenter Roeck (10):
      watchdog: w83627hf: Convert to watchdog infrastructure
      watchdog: w83627hf: Enable watchdog only once
      watchdog: w83627hf: Enable watchdog device only if not already enabled
      watchdog: w83627hf: Use helper functions to access superio registers
      watchdog: w83627hf: Auto-detect IO address and supported chips
      watchdog: w83627hf: Add support for W83697HF and W83697UG
      watchdog: Remove drivers for W83697HF and W83697UG
      watchdog: w83627hf_wdt: Reset watchdog trigger during initialization
      watchdog: pcwd_usb: Use allocated buffer for usb_control_msg
      watchdog: ts72xx_wdt: Propagate return value from timeout_to_regval

Heiko St=FCbner (2):
      watchdog: dw_wdt: convert to SIMPLE_DEV_PM_OPS
      watchdog: dw_wdt: use clk_prepare_enable and clk_disable_unprepare

Jingoo Han (3):
      watchdog: kempld_wdt: Add __user annotation
      watchdog: dw_wdt: Add __user annotation
      watchdog: use dev_get_platdata()

John Crispin (2):
      watchdog: MIPS: add ralink watchdog driver
      DT: Add documentation for rt2880-wdt

Jonas Jensen (1):
      watchdog: Add MOXA ART watchdog driver

Michal Simek (1):
      watchdog: sp805_wdt: Remove unnecessary amba_set_drvdata()

Niels de Vos (1):
      watchdog: imx2_wdt: expose module alias for loading from device-tree

Sachin Kamat (3):
      watchdog: at91rm9200: Remove redundant of_match_ptr
      watchdog: orion: Remove redundant of_match_ptr
      watchdog: sunxi: Remove redundant of_match_ptr

Xianglong Du (1):
      watchdog: sirf: add watchdog driver of CSR SiRFprimaII and SiRFatlasVI

johannes.thumshirn@men.de (1):
      documentation/devicetree: Move DT bindigns from gpio to watchdog

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 +-
 .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 +
 .../bindings/{gpio =3D> watchdog}/men-a021-wdt.txt   |   12 +-
 .../bindings/watchdog/moxa,moxart-watchdog.txt     |   15 +
 .../devicetree/bindings/watchdog/rt2880-wdt.txt    |   19 +
 .../devicetree/bindings/watchdog/sirfsoc_wdt.txt   |   14 +
 arch/arm/boot/dts/at91sam9260.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +
 arch/arm/boot/dts/kizbox.dts                       |    6 +
 arch/arm/boot/dts/sama5d3.dtsi                     |    5 +
 arch/arm/configs/prima2_defconfig                  |    1 +
 drivers/watchdog/Kconfig                           |   74 +--
 drivers/watchdog/Makefile                          |    5 +-
 drivers/watchdog/at91rm9200_wdt.c                  |    2 +-
 drivers/watchdog/at91sam9_wdt.c                    |  309 +++++++----
 drivers/watchdog/dw_wdt.c                          |   33 +-
 drivers/watchdog/iTCO_wdt.c                        |    2 +-
 drivers/watchdog/imx2_wdt.c                        |    1 +
 drivers/watchdog/kempld_wdt.c                      |    4 +-
 drivers/watchdog/moxart_wdt.c                      |  165 ++++++
 drivers/watchdog/mv64x60_wdt.c                     |    2 +-
 drivers/watchdog/omap_wdt.c                        |    2 +-
 drivers/watchdog/orion_wdt.c                       |    2 +-
 drivers/watchdog/pcwd_usb.c                        |    8 +-
 drivers/watchdog/rdc321x_wdt.c                     |    2 +-
 drivers/watchdog/rt2880_wdt.c                      |  208 ++++++++
 drivers/watchdog/sirfsoc_wdt.c                     |  224 ++++++++
 drivers/watchdog/sp805_wdt.c                       |    1 -
 drivers/watchdog/stmp3xxx_rtc_wdt.c                |    4 +-
 drivers/watchdog/sunxi_wdt.c                       |    2 +-
 drivers/watchdog/ts72xx_wdt.c                      |   38 +-
 drivers/watchdog/ux500_wdt.c                       |    2 +-
 drivers/watchdog/w83627hf_wdt.c                    |  540 +++++++++++-----=
----
 drivers/watchdog/w83697hf_wdt.c                    |  461 -----------------
 drivers/watchdog/w83697ug_wdt.c                    |  398 ---------------
 drivers/watchdog/wm831x_wdt.c                      |    8 +-
 39 files changed, 1363 insertions(+), 1277 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
 rename Documentation/devicetree/bindings/{gpio =3D> watchdog}/men-a021-wdt=
=2Etxt (61%)
 create mode 100644 Documentation/devicetree/bindings/watchdog/moxa,moxart-=
watchdog.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/rt2880-wdt.t=
xt
 create mode 100644 Documentation/devicetree/bindings/watchdog/sirfsoc_wdt.=
txt
 create mode 100644 drivers/watchdog/moxart_wdt.c
 create mode 100644 drivers/watchdog/rt2880_wdt.c
 create mode 100644 drivers/watchdog/sirfsoc_wdt.c
 delete mode 100644 drivers/watchdog/w83697hf_wdt.c
 delete mode 100644 drivers/watchdog/w83697ug_wdt.c

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSXzJjAAoJEMsfJm/On5mB+T8P/jNkLmhN62yjrI6PmxTQsZIE
jvBTlABRRRs3bZT1IbTM2euCHf4+xuFt/YYGwkxE0IlmksHDO/UYx1f5PlmCn0zA
N73H9jLkNjc9U01VtP4PGfGljL9Mb25RDBphuioXgv5v0NNLURFYdtbiukOXYC6K
0lzzmKyVXOBig9Fz6OEmeUomvBDCA1YURcSZkirKanUA43ZgV+RI28CmPArZAP6X
gweYC0UM9n+TCJ7Cx8jxKBKbUgb04cTSGKeBA7K9ULBnAjTna8UtMoVj7jy/WPBl
E6k1pgJJ1qvilISVjWBbIr1CMxBb1uMwmJuXAzqxPlIz1AoyrDTQCghcPBn4lKb5
4+++n1+V1hiSCNCqNiKlndQHlmNRx7c0Rk6+PCNJiz1L9vrLS0WAFRl0OyxZLZnb
xtEeQryz/pexe5TfuOL1S963ogEC69n9Ye2+u6U6Ddx1C5DIwx29OjBgYPTh0NEe
1Zsq+1ApAw669U7X62BMBg9F7HZrWZyX3dDwH1PdGNwxZbepmoDn8zH5K1A4yAlA
sFabJQHZP/ZU3OK/+MtEVCkCZCnmf175AuQP3jguh1OARpurforqngs/m09mY2Lu
EoCc5ncI5PjYS0FSHXzGsY+QQF2ule2kwSTA7WuVzSuYf9icjAb33v7xgoDWCd1m
LXUj3zpIwws8DHNLgQdl
=r3Y3
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
