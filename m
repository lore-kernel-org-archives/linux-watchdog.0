Return-path: <linux@rempel-privat.de>
From: Oleksij Rempel <linux@rempel-privat.de>
To: linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	wim@iguana.be,
	devicetree@vger.kernel.org,
	robh@kernel.org
Cc: Oleksij Rempel <linux@rempel-privat.de>
Subject: [PATCH v3 0/2] add Alphascale asm9260-wdt driver
Date: Tue, 24 Nov 2015 22:40:31 +0100
Message-Id: <1448401233-1064-1-git-send-email-linux@rempel-privat.de>
In-Reply-To: <5652BFA5.9010101@roeck-us.net>
References: <5652BFA5.9010101@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

v2:
- fix DT types
- remove obsolet comments
- add clk error handling
- reduce log noise
- allow to return an error in asm9260_wdt_get_dt_mode

v3:
- split patch to two parts, binding documentation and driver
- spelling fixes
- make reset a required property. It will make the code easier
- reduce timeout for asm9260_wdt_sys_reset
- rework error handling in asm9260_wdt_get_dt_clks
- asm9260_wdt_get_dt_mode - convert return type from int to void
- don't touch watchdog_set_nowayout
- don't do dev_err() if driver is still working, use dev_warn instead.
- asm9260_wdt_remove - use asm9260_wdt_disable() instead of asm9260_wdt_shutdown()

Oleksij Rempel (2):
  watchdog: add Alphascale asm9260-wdt driver
  DT: watchdog: add Alphascale asm9260 watchdog binding documentation.

 .../bindings/watchdog/alphascale-asm9260.txt       |  35 ++
 drivers/watchdog/Kconfig                           |  10 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/asm9260_wdt.c                     | 400 +++++++++++++++++++++
 4 files changed, 446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
 create mode 100644 drivers/watchdog/asm9260_wdt.c

-- 
2.5.0
