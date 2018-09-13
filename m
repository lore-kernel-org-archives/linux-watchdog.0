Return-Path: <hauke@hauke-m.de>
Return-path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	john@phrozen.org,
	dev@kresin.me,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 0/3] wdt: lantiq: Convert to watchdog_device
Date: Thu, 13 Sep 2018 23:32:08 +0200
Message-Id: <20180913213211.16781-1-hauke@hauke-m.de>
List-ID: <linux-watchdog@vger.kernel.org>

This converts the watchdog driver for the lantiq SoCs to use the
watchdog_device subsystem instead of implementing the ioctls on its own.

Changes since:
v2:
 * fix some 80 lines checkpatch warnings
 * rename LTQ_WDT_CR_RELOAD_MASK to LTQ_WDT_CR_MAX_TIMEOUT
 * remove return in ltq_wdt_w32()
 * remove error check for clk_get_io()
 * remove clk_put()
 * improve error check for priv->clk_rate
 * check LTQ_WDT_SR if watchdog is still running
 * improve commit messages

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
 drivers/watchdog/lantiq_wdt.c | 311 ++++++++++++++++++++----------------------
 2 files changed, 148 insertions(+), 164 deletions(-)

-- 
2.11.0
