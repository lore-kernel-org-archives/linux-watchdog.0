Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v7 0/5] watchdog: da9063: Fix timeout handling
Date: Thu, 24 May 2018 09:56:04 +0200
Message-Id: <20180524075609.19951-1-m.felsch@pengutronix.de>
List-ID: <linux-watchdog@vger.kernel.org>

The current set_timeout() handling can't change the timeout value if the
watchdog is already running because the watchdog must be
disabled before a new timeout value can be set. This sounds a bit
strange but it is the only way to change the timeout value.

The watchdog also has a second quirk. The timeout value combines the
timeout and the watchdog enable signal. So a value not equal zero
indicates that the watchdog is running. This leads into problems if the
watchdog is disabled and a new timeout value should be set because
during setting the timeout value the watchdog gets enabled. The driver
must check if the watchdog is disabled. In that case the timeout value
must be stored to be available for the later wdt_start() call. If the
watchdog is already running the driver must write the new timeout value
immediately to the watchdog.

There was also a issue during the driver probe sequence. The driver must
set a new timeout reference mark if the watchdog was enabled in a earlier
stage e.g. the bootloader.

Marco Felsch (5):
  watchdog: da9063: Fix setting/changing timeout
  watchdog: da9063: Fix setting HW_RUNNING indication during wdt_start
  watchdog: da9063: Fix updating timeout value
  watchdog: da9063: Fix timeout handling during probe
  watchdog: da9063: rename helper function to avoid misunderstandings

 drivers/watchdog/da9063_wdt.c | 69 ++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 6 deletions(-)

-- 
2.17.0
