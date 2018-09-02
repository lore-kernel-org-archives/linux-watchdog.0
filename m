Return-Path: <hauke@hauke-m.de>
Return-path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	john@phrozen.org,
	dev@kresin.me,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 0/3] wdt: lantiq: Convert to watchdog_device
Date: Sun,  2 Sep 2018 13:32:30 +0200
Message-Id: <20180902113233.29113-1-hauke@hauke-m.de>
List-ID: <linux-watchdog@vger.kernel.org>

This converts the watchdog driver for the lantiq SoCs to use the
watchdog_device subsystem instead of implementing the ioctls on its own.

Changes since:
v1:
 * Removed includes for file system operations
 * reordered the adding of new defines
 * Added struct ltq_wdt_hw to store the chip specific function pointer
   instead of using a typedef
 * priv->clk_rate now contains the number of clocks the wdt decreases per
   second
 * call watchdog_init_timeout()
 * keep the watchdog running if it was already running before the driver
   was loaded

Hauke Mehrtens (3):
  wdt: lantiq: update register names to better match spec
  wdt: lantiq: Convert to watchdog_device
  wdt: lantiq: add get_timeleft callback

 drivers/watchdog/Kconfig      |   1 +
 drivers/watchdog/lantiq_wdt.c | 309 ++++++++++++++++++++----------------------
 2 files changed, 148 insertions(+), 162 deletions(-)

-- 
2.11.0
