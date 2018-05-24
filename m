Return-Path: <mfe@pengutronix.de>
Return-path: <mfe@pengutronix.de>
From: Marco Felsch <m.felsch@pengutronix.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	support.opensource@diasemi.com
Cc: linux-watchdog@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v8 0/4] watchdog: da9063: Fix timeout handling
Date: Thu, 24 May 2018 13:50:57 +0200
Message-Id: <20180524115101.17097-1-m.felsch@pengutronix.de>
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

Changelog:

v8:
 - make use of watchdog_active() helper instead of watchdog_hw_running()
 - fix misspellings
 - drop set HW_RUNNING flag during wdt_start() introduced with v6
 - call _da9063_wdt_set_timeout() during probe() directly if watchdog is
   running.
 - da9063_wdt_is_running() returns now the raw timeout regval instead of
   the maped timeout in seconds.
 - fix da9063_wdt_is_running() return value, use unsigned int instead of
   int.

v7:
 - reorder patch stack "Fixes:" patches first.

v6:
 - fix timeout value buffering (don't buffer it twice, use HW_RUNNING
   flag)
 - set HW_RUNNING flag during wdt_start()
 - add watchdog enable check during probe()
 - rename _da9063_wdt_set_timeout -> da9063_wdt_update_timeout

v5:
 - add buffering the timeout if the watchdog is disabled
 - add more comments

v4:
 - Fix patch description

v3:
 - add delay between disable watchdog and write new timeout value during
   timeout update
 - fix comment to be more common

v2:
 - style changes

v1:
 - initial commit
 
Marco Felsch (4):
  watchdog: da9063: Fix setting/changing timeout
  watchdog: da9063: Fix updating timeout value
  watchdog: da9063: Fix timeout handling during probe
  watchdog: da9063: rename helper function to avoid misunderstandings

 drivers/watchdog/da9063_wdt.c | 67 +++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 6 deletions(-)

-- 
2.17.0
