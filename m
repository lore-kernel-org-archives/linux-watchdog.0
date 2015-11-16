Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 00/13] watchdog: factorize restart handler registration
Date: Mon, 16 Nov 2015 12:27:58 -0500
Message-Id: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Many drivers implements the exact same piece of code to register a
restart handler. It can be nice to factorize this in the watchdog core.

The first patch adds an optional restart watchdog operation. If a driver
defines this operation, a restart handler is registered. By default, the
restart handler priority is set to 0, but a helper function
watchdog_set_restart_priority is provided to change it.

The following patches bring this change to the current watchdog drivers
that use watchdog_core.

This change has been compile-tested on da9063, imx2, lpc18xx, imgpdc.
It has been tested with (not mainlined yet) ts-4800's watchdog driver.

Changes in v2:
 - bcm47xx_wdt.c: move restart function to fix an undefined function
   error
 - core: documentation and header: fix "capabilites" typo, reword some
   comments to fit 80 columns

Damien Riegel (13):
  watchdog: core: add restart handler support
  watchdog: bcm47xx_wdt: use core restart handler
  watchdog: da9063_wdt: use core restart handler
  watchdog: digicolor_wdt: use core restart handler
  watchdog: imgpdc_wdt: use core restart handler
  watchdog: imx2_wdt: use core restart handler
  watchdog: lpc18xx_wdt: use core restart handler
  watchdog: meson_wdt: use core restart handler
  watchdog: moxart_wdt: use core restart handler
  watchdog: mtk_wdt: use core restart handler
  watchdog: qcom-wdt: use core restart handler
  watchdog: s3c2410_wdt: use core restart handler
  watchdog: sunxi_wdt: use core restart handler

 Documentation/watchdog/watchdog-kernel-api.txt | 19 ++++++++
 drivers/watchdog/bcm47xx_wdt.c                 | 33 ++++++--------
 drivers/watchdog/da9063_wdt.c                  | 23 +++-------
 drivers/watchdog/digicolor_wdt.c               | 18 +++-----
 drivers/watchdog/imgpdc_wdt.c                  | 34 ++++++---------
 drivers/watchdog/imx2_wdt.c                    | 23 +++-------
 drivers/watchdog/lpc18xx_wdt.c                 | 52 +++++++++-------------
 drivers/watchdog/meson_wdt.c                   | 23 +++-------
 drivers/watchdog/moxart_wdt.c                  | 23 +++-------
 drivers/watchdog/mtk_wdt.c                     | 22 +++-------
 drivers/watchdog/qcom-wdt.c                    | 49 ++++++++-------------
 drivers/watchdog/s3c2410_wdt.c                 | 60 +++++++++++---------------
 drivers/watchdog/sunxi_wdt.c                   | 23 +++-------
 drivers/watchdog/watchdog_core.c               | 48 +++++++++++++++++++++
 include/linux/bcm47xx_wdt.h                    |  1 -
 include/linux/watchdog.h                       |  6 +++
 16 files changed, 201 insertions(+), 256 deletions(-)

-- 
2.5.0
