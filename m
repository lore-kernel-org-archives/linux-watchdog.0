Return-path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wim Van Sebroeck <wim@iguana.be>,
	Wolfram Sang <wsa@the-dreams.de>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Support Opensource <support.opensource@diasemi.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/4] ARM: shmobile: koelsch: Add DA9063 watchdog restart support
Date: Tue,  9 Dec 2014 12:22:45 +0100
Message-Id: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-watchdog@vger.kernel.org>

	Hi Wim, Wolfram, Simon, Magnus,

This patch series add restart support for r8a7791/koelsch through the watchdog
in the DA9063 PMIC. Restart can be triggered in two ways:
  1. Timeout of the watchdog timer,
  2. Manual system restart, shutting down the DA9063.

Dependencies:
  - There are no strict merge order dependencies,
  - While manual restart depends on patch 1, patches 3 and 4 can be merged
    now, as restart on watchdog timeout works without patch 1.

Patches:
  - Patch 1 is intended for the watchdog tree (based on watchdog/next),
  - Patch 2 is intended for the i2c tree (based on i2c/next),
  - Patches 3 and 4 are intended for the shmobile tree (based on
    renesas-devel-20141209-v3.18).

This was tested on r8a7791/koelsch.
I expect this restart method to be usable on r8a7791/lager and r8a7794/alt,
too.

Thanks!

Geert Uytterhoeven (4):
  watchdog: da9063: Add restart handler support
  DT: i2c: Add devices handled by the da9063 MFD driver
  ARM: shmobile: koelsch: Add DA9063 PMIC device node for system restart
  ARM: shmobile: Enable DA9063 watchdog in multiplatform defconfig

 .../devicetree/bindings/i2c/trivial-devices.txt    |  1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts              |  7 +++++
 arch/arm/configs/shmobile_defconfig                |  3 ++
 drivers/watchdog/da9063_wdt.c                      | 32 +++++++++++++++++++++-
 4 files changed, 42 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
