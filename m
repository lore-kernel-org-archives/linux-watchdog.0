Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:59257 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaEWT4k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 23 May 2014 15:56:40 -0400
Received: by mail-pb0-f43.google.com with SMTP id up15so4601103pbc.2
        for <linux-watchdog@vger.kernel.org>; Fri, 23 May 2014 12:56:40 -0700 (PDT)
Date: Fri, 23 May 2014 12:56:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [GIT PULL] watchdog updates for Linux 3.16
Message-ID: <20140523195625.GA14713@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Wim,

This is my pull request for 3.16. The branch is based on v3.15-rc5.

Please consider pulling watchdog updates for Linux 3.16 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git =
watchdog-for-wim-3.16

The tag has been applied on top of the watchdog-next branch. The branch inc=
ludes
a number of patches I collected over the last few months. It does not inclu=
de
all submitted patches; only the ones I reviewed and felt comfortable with a=
re
included. Some may already be in your -next branch.

I reviewed all patches and ran build tests as well as source verification t=
ests
with both smatch and spatch. The branch has been on my Linux repo for a whi=
le,
so Fenguang's robot will have built the code as well.

We'll need maintainer Acks for the arm and arm64 patches (part of the reboo=
t API),
so this code is unfortunately not ready for integration. It is part of the =
pull
request anyway.

You can find the most recent build results at
http://server.roeck-us.net:8010/builders/watchdog-next.

If you don't want to apply the entire series, please consider applying what=
ever
subset you might feel comfortable with.

Thanks,
Guenter

------

The following changes since commit d6d211db37e75de2ddc3a4f979038c40df7cc79c:

  Linux 3.15-rc5 (2014-05-09 13:10:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git ta=
gs/watchdog-for-wim-3.16

for you to fetch changes up to c7582047791de3ed31c0e036f93701ed45c550bc:

  watchdog: sunxi: Register reboot handler with watchdog subsystem (2014-05=
-15 18:48:09 -0700)

----------------------------------------------------------------
c758204 watchdog: sunxi: Register reboot handler with watchdog subsystem
a5f0ab3 watchdog: moxart: Register reboot handler with watchdog subsystem
d015216 arm: Support reboot through watchdog subsystem
140c13d arm64: Support reboot through watchdog subsystem
17414a6 watchdog: Document reboot API
043f82f watchdog: Add API to trigger reboots
a221642 watchdog: sp805: Set watchdog_device->timeout from ->set_timeout()
63e07f5 watchdog: Remove drivers for W83697HF and W83697UG
8a44d7f watchdog: w83627hf_wdt: Add early_disable module parameter
2d69897 booke/watchdog: refine and clean up the codes
f98cf6e watchdog: iop_wdt only builds for mach-iop13xx
4476511 wdt: sunxi: Move restart code to the watchdog driver
9711fe8 watchdog: xilinx: Make of_device_id array const
cc7490d watchdog: ath79_wdt: switch to clk_prepare/clk_disable
c8a0e79 watchdog: ath79_wdt: avoid spurious restarts on AR934x
3f38308 watchdog: kempld-wdt: Use the correct value when configuring the pr=
escaler with the watchdog
11ee459 x86: intel-mid: add watchdog platform code for Merrifield
f443441 watchdog: add Intel MID watchdog driver support
64a0f44 ARM: mvebu: Add A375/A380 watchdog binding documentation
a4439e5 ARM: mvebu: Enable Armada 380/385 watchdog in the devicetree
5f22050 ARM: mvebu: Enable Armada 375 watchdog in the devicetree
3523555 watchdog: orion: Add Armada 375/380 SoC support
b272e72 watchdog: orion: Introduce per-SoC enabled() function
dd64291 watchdog: orion: Introduce per-SoC stop() function
14c0026 watchdog: orion: Remove unneeded atomic access
1d2ea72 watchdog: orion: Introduce a SoC-specific RSTOUT mapping
48beaca watchdog: orion: Move the register ioremap'ing to its own function
c47586f watchdog: imx2_wdt: convert to watchdog core api
695ba43 watchdog: sunxi: Fix compilation with C=3D2
7eed94c watchdog: imx2_wdt: convert to use regmap API.
1fa3b1a watchdog: imx2_wdt: Sort the header files alphabetically
dcbbc9d watchdog: via_wdt: replace del_timer by del_timer_sync
25ecdce watchdog: shwdt: Remove unused platform_set_drvdata()
5ce2288 watchdog: Fix SBC8360 dependencies

----------------------------------------------------------------
Alexander Shiyan (1):
      watchdog: shwdt: Remove unused platform_set_drvdata()

Anatolij Gustschin (1):
      watchdog: imx2_wdt: convert to watchdog core api

Arnd Bergmann (1):
      watchdog: iop_wdt only builds for mach-iop13xx

David Cohen (2):
      watchdog: add Intel MID watchdog driver support
      x86: intel-mid: add watchdog platform code for Merrifield

Emilio L=F3pez (1):
      watchdog: sunxi: Fix compilation with C=3D2

Ezequiel Garcia (9):
      watchdog: orion: Move the register ioremap'ing to its own function
      watchdog: orion: Introduce a SoC-specific RSTOUT mapping
      watchdog: orion: Remove unneeded atomic access
      watchdog: orion: Introduce per-SoC stop() function
      watchdog: orion: Introduce per-SoC enabled() function
      watchdog: orion: Add Armada 375/380 SoC support
      ARM: mvebu: Enable Armada 375 watchdog in the devicetree
      ARM: mvebu: Enable Armada 380/385 watchdog in the devicetree
      ARM: mvebu: Add A375/A380 watchdog binding documentation

Gabor Juhos (2):
      watchdog: ath79_wdt: avoid spurious restarts on AR934x
      watchdog: ath79_wdt: switch to clk_prepare/clk_disable

Guenter Roeck (8):
      watchdog: w83627hf_wdt: Add early_disable module parameter
      watchdog: Remove drivers for W83697HF and W83697UG
      watchdog: Add API to trigger reboots
      watchdog: Document reboot API
      arm64: Support reboot through watchdog subsystem
      arm: Support reboot through watchdog subsystem
      watchdog: moxart: Register reboot handler with watchdog subsystem
      watchdog: sunxi: Register reboot handler with watchdog subsystem

Jean Delvare (1):
      watchdog: Fix SBC8360 dependencies

Jingoo Han (1):
      watchdog: xilinx: Make of_device_id array const

Julia Lawall (1):
      watchdog: via_wdt: replace del_timer by del_timer_sync

Maxime Ripard (1):
      wdt: sunxi: Move restart code to the watchdog driver

Tang Yuantian (1):
      booke/watchdog: refine and clean up the codes

Viresh Kumar (1):
      watchdog: sp805: Set watchdog_device->timeout from ->set_timeout()

Xiubo Li (2):
      watchdog: imx2_wdt: Sort the header files alphabetically
      watchdog: imx2_wdt: convert to use regmap API.

gundberg (1):
      watchdog: kempld-wdt: Use the correct value when configuring the pres=
caler with the watchdog

 .../devicetree/bindings/watchdog/marvel.txt        |   7 +
 Documentation/watchdog/watchdog-kernel-api.txt     |  11 +
 arch/arm/boot/dts/armada-375.dtsi                  |   6 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   7 +
 arch/arm/kernel/process.c                          |   6 +-
 arch/arm64/kernel/process.c                        |   3 +
 arch/powerpc/kernel/setup-common.c                 |  27 --
 arch/x86/platform/intel-mid/device_libs/Makefile   |   1 +
 .../platform/intel-mid/device_libs/platform_wdt.c  |  71 ++++
 drivers/watchdog/Kconfig                           |  49 +--
 drivers/watchdog/Makefile                          |   3 +-
 drivers/watchdog/ath79_wdt.c                       |  16 +-
 drivers/watchdog/booke_wdt.c                       |  51 ++-
 drivers/watchdog/imx2_wdt.c                        | 320 +++++++-------
 drivers/watchdog/intel-mid_wdt.c                   | 184 +++++++++
 drivers/watchdog/kempld_wdt.c                      |   2 +-
 drivers/watchdog/moxart_wdt.c                      |  19 +-
 drivers/watchdog/of_xilinx_wdt.c                   |   2 +-
 drivers/watchdog/orion_wdt.c                       | 213 ++++++++--
 drivers/watchdog/shwdt.c                           |   2 -
 drivers/watchdog/sp805_wdt.c                       |   4 +-
 drivers/watchdog/sunxi_wdt.c                       |  45 +-
 drivers/watchdog/via_wdt.c                         |   2 +-
 drivers/watchdog/w83627hf_wdt.c                    |  15 +-
 drivers/watchdog/w83697hf_wdt.c                    | 460 -----------------=
----
 drivers/watchdog/w83697ug_wdt.c                    | 397 ------------------
 drivers/watchdog/watchdog_core.c                   |  27 ++
 include/linux/platform_data/intel-mid_wdt.h        |  22 +
 include/linux/watchdog.h                           |   8 +
 29 files changed, 806 insertions(+), 1174 deletions(-)
 create mode 100644 arch/x86/platform/intel-mid/device_libs/platform_wdt.c
 create mode 100644 drivers/watchdog/intel-mid_wdt.c
 delete mode 100644 drivers/watchdog/w83697hf_wdt.c
 delete mode 100644 drivers/watchdog/w83697ug_wdt.c
 create mode 100644 include/linux/platform_data/intel-mid_wdt.h

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTf6fpAAoJEMsfJm/On5mB+bIP/RcvIoIcmPd/6eepyPxP94Pf
dhwhyf5/A5BVQD5Uh6Nx6x4AzzU8hMj7mt0hvyr2xlnrmUPUTUwJ6dHG8IRF/Ibi
qteqlWHPWVXbYob48AYhT3T7Vc4hThhS/XC61eceCbjmIg68KexaNM4XNSQJ/tEH
nXXLaxJTGneMVr9uz70f2zM+WznS6yNDjKEhK1v4/u8IXUwQDtJYeRrXcerMbu9k
CFTtYELW6FeApovWVV6dWtq7UToox4OQXys0rmXimD4PYYHYUF9Hfr5q9ovkimCf
nHKtNqbRTCydUYnXW41vZK5KwpEJ35X+QS05VKl0Z0NU17H+T92Jjc0FtMFs8l/g
li0D8FgAJPd9bKBMptppFVPymWqHoiC4hbSTV4BmGT78f7feg0yZpbO+1LppQHF3
a65kq94aUYUtGIjPXEZVdGZgZati/1u3biXCOBWljQf3AzZACA6CW6KCh7I5AD42
RIP4Chgbf6h4qjYPJmG8GU801uTB4H7vmfbGsODnXWK/xFr69GXfa+IJJPYUHEUf
uq9t/QZr0jFzbMDxOg0lzLDGMc5Pr6bBmlIztoGYrVvsIwu83Lc7RGpMKlBJuEib
TPfqG8ghzvXTszoGZm7sAyu+ZtagQWnJvTRAh8eYjoEsL4ZrMU3ClplFxf6NWs1Y
+nYFSlT+vzRB6ScDPoi+
=ZVnT
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
