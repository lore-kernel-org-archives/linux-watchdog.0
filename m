Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:58300 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab3LSReZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Dec 2013 12:34:25 -0500
Received: by mail-pd0-f170.google.com with SMTP id g10so1405349pdj.1
        for <linux-watchdog@vger.kernel.org>; Thu, 19 Dec 2013 09:34:24 -0800 (PST)
Date: Thu, 19 Dec 2013 09:34:21 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 3.14
Message-ID: <20131219173421.GA5683@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Wim,

This is the first version of my pull request for 3.14. The branch is currently
based on v3.13-rc3.

Please consider pulling watchdog updates for Linux 3.14 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git watchdog-for-wim-3.14-v1

The tag has been applied on top of the watchdog-next branch. The branch includes
a number of patches I collected over the last few months. It does not include
all submitted patches; only the ones I reviewed and felt comfortable with are
included.

I reviewed all patches and ran build tests as well as source verification tests
with both smatch and spatch. The branch has been on my Linux repo for a while,
so presumably Fenguang's robot will have built the code as well.
The w83627hf patches have been running on several servers for more than a month
without problems.

You can find the most recent build results at
http://server.roeck-us.net:8010/builders/watchdog-next.

If you don't want to apply the entire series, please consider applying whatever
subset you might feel comfortable with.

Thanks,
Guenter

------

The following changes since commit 319e2e3f63c348a9b66db4667efa73178e18b17d:

  Linux 3.13-rc4 (2013-12-15 12:31:33 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/watchdog-for-wim-3.14-v1

for you to fetch changes up to c784be04655365e70932ef80166e35453dd1d1d3:

  watchdog: s3c2410_wdt: Report when the watchdog reset the system (2013-12-16 11:14:17 -0800)

----------------------------------------------------------------
Improvements:
	davinci converted to watchdog core and improved by Ivan Khoronzhuk
	mpc8xxx_wdt converted to watchdog core by Christophe Leroy
	Various improvements to at91sam9_wdt by Boris Brezillion
	Various improvements to s3c2410_wdt by Doug Anderson
	Various s3c2410_wdt improvements by Leela Krishna Amudala
	Some more improvements to w83627hf by Guenter Roeck
	Removal of DEFINE_PCI_DEVICE_TABLE by Jingoo Han

Explicit drivers for W83697HF and W83697UG removed by Guenter Roeck

New drivers:
	GPIO based watchdog from Alexander Shiyan
	bcm281xx watchdog driver by Markus Mayer

----------------------------------------------------------------
Alexander Shiyan (1):
      watchdog: GPIO-controlled watchdog

Boris BREZILLON (6):
      watchdog: at91sam9_wdt: better watchdog support
      watchdog: at91sam9_wdt: update device tree doc
      ARM: at91/dt: add sam9 watchdog default options to SoCs
      ARM: at91/dt: add watchdog properties to kizbox board
      watchdog: at91sam9_wdt: fix secs_to_ticks
      watchdog: at91sam9_wdt: avoid spurious watchdog reset during init

Christophe Leroy (2):
      watchdog: mpc8xxx_wdt: MPC8xx is HW enabled
      watchdog: mpc8xxx_wdt convert to watchdog core

Doug Anderson (4):
      watchdog: s3c2410_wdt: Only register for cpufreq on ARM_S3C24XX_CPUFREQ
      watchdog: s3c2410_wdt: Handle rounding a little better for timeout
      watchdog: core: Make dt "timeout-sec" property work on drivers w/out min/max
      watchdog: s3c2410_wdt: Report when the watchdog reset the system

Guenter Roeck (4):
      watchdog: w83627hf: Auto-detect IO address and supported chips
      watchdog: w83627hf: Add support for W83697HF and W83697UG
      watchdog: Remove drivers for W83697HF and W83697UG
      watchdog: w83627hf_wdt: Reset watchdog trigger during initialization

Ivan Khoronzhuk (5):
      watchdog: davinci: change driver to use WDT core
      watchdog: davinci: use davinci_wdt_device structure to hold device data
      watchdog: davinci: add GET_TIMELEFT option support
      watchdog: davinci: add "timeout-sec" property
      watchdog: davinci: reuse driver for keystone arch

Jingoo Han (1):
      watchdog: remove DEFINE_PCI_DEVICE_TABLE macro

Leela Krishna Amudala (1):
      watchdog: s3c2410_wdt: use syscon regmap interface to configure pmu register

Markus Mayer (2):
      watchdog: bcm281xx: Watchdog Driver
      ARM: bcm281xx: watchdog configuration

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 +-
 .../devicetree/bindings/watchdog/davinci-wdt.txt   |   16 +-
 .../devicetree/bindings/watchdog/gpio-wdt.txt      |   23 +
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |   21 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +
 arch/arm/boot/dts/kizbox.dts                       |    6 +
 arch/arm/boot/dts/sama5d3.dtsi                     |    5 +
 arch/arm/configs/bcm_defconfig                     |    3 +
 drivers/watchdog/Kconfig                           |   84 ++--
 drivers/watchdog/Makefile                          |    4 +-
 drivers/watchdog/alim1535_wdt.c                    |    2 +-
 drivers/watchdog/alim7101_wdt.c                    |    2 +-
 drivers/watchdog/at91sam9_wdt.c                    |  313 +++++++++----
 drivers/watchdog/bcm_kona_wdt.c                    |  365 ++++++++++++++++
 drivers/watchdog/davinci_wdt.c                     |  221 ++++------
 drivers/watchdog/gpio_wdt.c                        |  254 +++++++++++
 drivers/watchdog/hpwdt.c                           |    2 +-
 drivers/watchdog/i6300esb.c                        |    2 +-
 drivers/watchdog/mpc8xxx_wdt.c                     |  111 ++---
 drivers/watchdog/nv_tco.c                          |    2 +-
 drivers/watchdog/pcwd_pci.c                        |    2 +-
 drivers/watchdog/s3c2410_wdt.c                     |  203 ++++++++-
 drivers/watchdog/sp5100_tco.c                      |    2 +-
 drivers/watchdog/via_wdt.c                         |    2 +-
 drivers/watchdog/w83627hf_wdt.c                    |  235 ++++++++--
 drivers/watchdog/w83697hf_wdt.c                    |  460 --------------------
 drivers/watchdog/w83697ug_wdt.c                    |  397 -----------------
 drivers/watchdog/watchdog_core.c                   |    4 +-
 drivers/watchdog/wdt_pci.c                         |    2 +-
 33 files changed, 1559 insertions(+), 1239 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
 create mode 100644 drivers/watchdog/bcm_kona_wdt.c
 create mode 100644 drivers/watchdog/gpio_wdt.c
 delete mode 100644 drivers/watchdog/w83697hf_wdt.c
 delete mode 100644 drivers/watchdog/w83697ug_wdt.c

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSsy4dAAoJEMsfJm/On5mBwfwP/1B3aHBwoPPmP+g0l5A85jdw
PpblIMQRc17PTV55GhK2fFbad27CJbcTb7D9MnVy3/eoTYPUflqeIDrenDagWQ3s
RpEAl0VVJDc+wZ2vLf2Rwio9u+eMA0GYhc9dx6Ezk9Y6Zq+gSaGm2kqaYnhVf6QU
kRp4jNmbEIC4R/T2ma0qgBKEjP0is8dF8StOryv4QRAboII0wuz1jWnP7QjMMOo2
6q8jsEF8nWhSlMOC8IPAO6u5N2R2xfqld8K6ULesYLn3ivFPwdau0wRPCLy10rRg
HmHbU8lDMTP7a46ObZzLWGRGj3cQhhWDUyN5kuUNMmHm4toPFYfz+lFBYC+5EmyN
hJ5+SR7jsYmWunE1EI1Y6OH5ScUGuSBO5YM3UuVZAcmPCQp7W9J/XYCBAjj2d8NM
tqTM0jCCd8hxj7MUxsjQPG3Pz+DFHlZWjfSflOWW/yGIhT4JiGEYlYtbJvAep/rB
fokS83Bn0/x3QP2GaC4NGvIF2P/KULQObpOgYZnQfQ3NUuIW2PEZRraetE60Bkzo
783N/HSl0SkWZBHuC2ND/qabS4M+oEcZbhFez68yL5cep3ODB7V8rhU9dnyHQS81
M0dHXLkmouurdgFbA3f5+CS5fr77eNM3Rv299mMvhr7/NB/RK+lRKc+QWK/+UwqF
PC6kfnQJ2/FimkY5AtKX
=CAHB
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
