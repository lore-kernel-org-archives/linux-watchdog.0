Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:64164 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab3JWAfu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 22 Oct 2013 20:35:50 -0400
Received: by mail-pb0-f48.google.com with SMTP id ma3so103378pbc.35
        for <linux-watchdog@vger.kernel.org>; Tue, 22 Oct 2013 17:35:49 -0700 (PDT)
Date: Tue, 22 Oct 2013 17:35:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL v2] watchdog updates for Linux 3.13
Message-ID: <20131023003541.GA2435@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

This is v2 of my pull request. Please ignore the previous request.
There are a couple of changes as outlined below, and I rebased the
branch to 3.12-rc6.

Please consider pulling watchdog updates for Linux 3.13 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git =
watchdog-for-wim

The tag has been applied on top of the watchdog-next branch. The branch inc=
ludes
a number of patches I collected over the last few months. It does not inclu=
de
all submitted patches; only the ones I reviewed and felt comfortable with a=
re
included.

I reviewed all patches and ran build tests as well as source verification t=
ests
with both smatch and spatch. The branch has been on my Linux repo for a whi=
le,
so presumably Fenguang's robot will have built the code as well.
The w83627hf patches have been running on several servers for more than a m=
onth
without problems.

You can find the most recent build results at
http://server.roeck-us.net:8010/builders/watchdog-next.

If you don't want to apply the entire series, please consider applying what=
ever
subset you might feel comfortable with.

Thanks,
Guenter

------

The following changes since commit 31d141e3a666269a3b6fcccddb0351caf7454240:

  Linux 3.12-rc6 (2013-10-19 12:28:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git ta=
gs/watchdog-for-wim

for you to fetch changes up to 1f445d7f50f7609ac1f3c6ccd2552a58c7493e54:

  watchdog: dw: Enable OF support for DW watchdog timer (2013-10-22 10:09:3=
7 -0700)

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

v2:
- Fixed spelling error in one of the drivers
- Added 'watchdog: Get rid of MODULE_ALIAS_MISCDEV statements' patch
- Updated version of ' watchdog: dw: Enable OF support for DW watchdog time=
r'

----------------------------------------------------------------
Boris BREZILLON (4):
      watchdog: at91sam9_wdt: better watchdog support
      watchdog: at91sam9_wdt: update device tree doc
      ARM: at91/dt: add sam9 watchdog default options to SoCs
      ARM: at91/dt: add watchdog properties to kizbox board

Dan Carpenter (1):
      watchdog: ts72xx_wdt: cleanup return codes in ioctl

Dinh Nguyen (1):
      watchdog: dw: Enable OF support for DW watchdog timer

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

Jean Delvare (1):
      watchdog: Get rid of MODULE_ALIAS_MISCDEV statements

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
      documentation/devicetree: Move DT bindings from gpio to watchdog

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 +-
 .../devicetree/bindings/watchdog/dw_wdt.txt        |   21 +
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
 drivers/watchdog/acquirewdt.c                      |    4 +-
 drivers/watchdog/advantechwdt.c                    |    1 -
 drivers/watchdog/alim1535_wdt.c                    |    1 -
 drivers/watchdog/alim7101_wdt.c                    |    1 -
 drivers/watchdog/ar7_wdt.c                         |    1 -
 drivers/watchdog/at32ap700x_wdt.c                  |    1 -
 drivers/watchdog/at91rm9200_wdt.c                  |    3 +-
 drivers/watchdog/at91sam9_wdt.c                    |  309 +++++++----
 drivers/watchdog/ath79_wdt.c                       |    1 -
 drivers/watchdog/bcm2835_wdt.c                     |    1 -
 drivers/watchdog/bcm63xx_wdt.c                     |    1 -
 drivers/watchdog/bfin_wdt.c                        |    1 -
 drivers/watchdog/cpu5wdt.c                         |    1 -
 drivers/watchdog/davinci_wdt.c                     |    1 -
 drivers/watchdog/dw_wdt.c                          |   34 +-
 drivers/watchdog/ep93xx_wdt.c                      |    1 -
 drivers/watchdog/eurotechwdt.c                     |    1 -
 drivers/watchdog/gef_wdt.c                         |    1 -
 drivers/watchdog/geodewdt.c                        |    1 -
 drivers/watchdog/hpwdt.c                           |    1 -
 drivers/watchdog/i6300esb.c                        |    1 -
 drivers/watchdog/iTCO_wdt.c                        |    5 +-
 drivers/watchdog/ib700wdt.c                        |    1 -
 drivers/watchdog/ibmasr.c                          |    1 -
 drivers/watchdog/ie6xx_wdt.c                       |    1 -
 drivers/watchdog/imx2_wdt.c                        |    2 +-
 drivers/watchdog/indydog.c                         |    1 -
 drivers/watchdog/intel_scu_watchdog.c              |    1 -
 drivers/watchdog/iop_wdt.c                         |    1 -
 drivers/watchdog/it8712f_wdt.c                     |    1 -
 drivers/watchdog/it87_wdt.c                        |    1 -
 drivers/watchdog/ixp4xx_wdt.c                      |    2 -
 drivers/watchdog/jz4740_wdt.c                      |    1 -
 drivers/watchdog/kempld_wdt.c                      |    5 +-
 drivers/watchdog/ks8695_wdt.c                      |    1 -
 drivers/watchdog/lantiq_wdt.c                      |    1 -
 drivers/watchdog/m54xx_wdt.c                       |    1 -
 drivers/watchdog/machzwd.c                         |    1 -
 drivers/watchdog/max63xx_wdt.c                     |    1 -
 drivers/watchdog/mixcomwd.c                        |    1 -
 drivers/watchdog/moxart_wdt.c                      |  165 ++++++
 drivers/watchdog/mpc8xxx_wdt.c                     |    1 -
 drivers/watchdog/mtx-1_wdt.c                       |    1 -
 drivers/watchdog/mv64x60_wdt.c                     |    3 +-
 drivers/watchdog/nuc900_wdt.c                      |    1 -
 drivers/watchdog/nv_tco.c                          |    1 -
 drivers/watchdog/of_xilinx_wdt.c                   |    1 -
 drivers/watchdog/omap_wdt.c                        |    2 +-
 drivers/watchdog/orion_wdt.c                       |    3 +-
 drivers/watchdog/pc87413_wdt.c                     |    2 -
 drivers/watchdog/pcwd.c                            |    4 +-
 drivers/watchdog/pcwd_pci.c                        |    4 +-
 drivers/watchdog/pcwd_usb.c                        |   12 +-
 drivers/watchdog/pika_wdt.c                        |    2 -
 drivers/watchdog/pnx4008_wdt.c                     |    1 -
 drivers/watchdog/pnx833x_wdt.c                     |    1 -
 drivers/watchdog/rc32434_wdt.c                     |    4 +-
 drivers/watchdog/rdc321x_wdt.c                     |    3 +-
 drivers/watchdog/rt2880_wdt.c                      |  206 ++++++++
 drivers/watchdog/s3c2410_wdt.c                     |    2 -
 drivers/watchdog/sa1100_wdt.c                      |    1 -
 drivers/watchdog/sb_wdog.c                         |    1 -
 drivers/watchdog/sbc60xxwdt.c                      |    1 -
 drivers/watchdog/sbc7240_wdt.c                     |    2 -
 drivers/watchdog/sbc8360.c                         |    1 -
 drivers/watchdog/sbc_epx_c3.c                      |    1 -
 drivers/watchdog/sbc_fitpc2_wdt.c                  |    2 -
 drivers/watchdog/sc1200wdt.c                       |    1 -
 drivers/watchdog/sc520_wdt.c                       |    1 -
 drivers/watchdog/sch311x_wdt.c                     |    5 +-
 drivers/watchdog/scx200_wdt.c                      |    1 -
 drivers/watchdog/shwdt.c                           |    1 -
 drivers/watchdog/sirfsoc_wdt.c                     |  224 ++++++++
 drivers/watchdog/smsc37b787_wdt.c                  |    2 -
 drivers/watchdog/softdog.c                         |    1 -
 drivers/watchdog/sp5100_tco.c                      |    1 -
 drivers/watchdog/sp805_wdt.c                       |    1 -
 drivers/watchdog/stmp3xxx_rtc_wdt.c                |    5 +-
 drivers/watchdog/sunxi_wdt.c                       |    2 +-
 drivers/watchdog/ts72xx_wdt.c                      |   38 +-
 drivers/watchdog/txx9wdt.c                         |    1 -
 drivers/watchdog/ux500_wdt.c                       |    3 +-
 drivers/watchdog/w83627hf_wdt.c                    |  540 +++++++++++-----=
----
 drivers/watchdog/w83697hf_wdt.c                    |  461 -----------------
 drivers/watchdog/w83697ug_wdt.c                    |  398 ---------------
 drivers/watchdog/w83877f_wdt.c                     |    1 -
 drivers/watchdog/w83977f_wdt.c                     |    1 -
 drivers/watchdog/wafer5823wdt.c                    |    1 -
 drivers/watchdog/wdrtas.c                          |    2 -
 drivers/watchdog/wdt.c                             |    2 -
 drivers/watchdog/wdt285.c                          |    1 -
 drivers/watchdog/wdt977.c                          |    1 -
 drivers/watchdog/wdt_pci.c                         |    2 -
 drivers/watchdog/wm831x_wdt.c                      |    8 +-
 drivers/watchdog/xen_wdt.c                         |    1 -
 111 files changed, 1372 insertions(+), 1385 deletions(-)
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

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSZxndAAoJEMsfJm/On5mBGTAP/RhThvuVrFBDHfPjh5maILXE
dKrTwNBFqJeZZRVVIOfZYpWnKoUP3ORjelwB85GtC78hPn38AoPsLAeVBDvQLcXy
/KVFvhMcVJZHSyGFihrCdJn4bYiu8tyaF+5VTG+1Rjl7BIZKm7zMe30KsHsTDOPM
4CQY56UZcklJ2JiVRK9umz18zVUXwfc4NtT5Q5rUTvUham+idy3/Je8BjvP0sKjs
1hwQBKAh30tjncJ36HQjtCc1ENL6up8pWCvcqQwtVJEFk3/YCFSnPcbG+QssQ5TU
53xbnil/+hSN7j9V7GnUk3pFheoieeUV1iFMMTYY3RQR1mwcAZO+9DWnNtT4U3t0
qHx7v02/bbUzarHTmbWlZWrj3U3FblQDD6cd2x/kh0Pd4FG+i7JljOG/fAbpRVgg
TwsonItAv9Q3PF8+/ptCdiIZC84U2iA+IpCZO8IRv4PssWBf8jFHjfsIfJfUJ3v2
f3Q09QtgADTJo90+ocCazPThdfJANGTQqYuEs/T7l4mgwHRreSWNBax1XqnnJnb9
u8ZkNuUnoYrYZa3XQl87WNP5BEUPKf4kyG0Nm7UlkpuGDRIUpPAwgNBQvpIGqSVy
4DlUYsiCVCOYhom6+/EhIz2Fh9ZcN0EaItMBiuM4wyZBDi0zgITdb7NJ7uMP14Sa
CupOcCIpq7e5bKbFDVka
=bWge
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
