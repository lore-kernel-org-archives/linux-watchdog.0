Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v2 0/6] watchdog: factorize reboot notifier registration
Date: Fri, 20 Nov 2015 16:54:50 -0500
Message-Id: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

Many drivers implements the exact same piece of code to register a
reboot notifier. It can be nice to factorize this in the watchdog core.

The first patch adds a new helper function, watchdog_stop_on_reboot,
which registers a reboot notifier block for this device. If used, the
watchdog core will care about stopping the watchdog when receiving a
reboot notification.

The following patches bring this change to the current watchdog drivers
that use watchdog_core.

This action is done only when the reboot code is SYS_HALT or SYS_DOWN,
since that is what most of the drivers are doing.

Only 3 drivers, including gpio_wdt, do not stop the watchdog on
SYS_DOWN. So for this watchdog, it will now stop on reboot if
"always-running" is not set, whereas it did not prior to this patchset.

This change has been compile-tested with allyesconfig on arm.
It has been tested with (not mainlined yet) ts-4800's watchdog driver.


Changes in v2:
 - call ops->stop only if watchdog is active
 - squashed gpio_wdt-related commits to keep a consistent behaviour.

Damien Riegel (6):
  watchdog: core: add reboot notifier support
  watchdog: bcm47xx_wdt: use core reboot notifier
  watchdog: cadence_wdt: use core reboot notifier
  watchdog: gpio_wdt: use core reboot notifier
  watchdog: softdog: use core reboot notifier
  watchdog: w83627hf_wdt: use core reboot notifier

 Documentation/watchdog/watchdog-kernel-api.txt |  8 ++++++
 drivers/watchdog/bcm47xx_wdt.c                 | 24 ++---------------
 drivers/watchdog/cadence_wdt.c                 | 36 +------------------------
 drivers/watchdog/gpio_wdt.c                    | 35 ++----------------------
 drivers/watchdog/softdog.c                     | 30 ++-------------------
 drivers/watchdog/w83627hf_wdt.c                | 32 ++--------------------
 drivers/watchdog/watchdog_core.c               | 37 ++++++++++++++++++++++++++
 include/linux/bcm47xx_wdt.h                    |  2 --
 include/linux/watchdog.h                       |  9 +++++++
 9 files changed, 63 insertions(+), 150 deletions(-)

-- 
2.5.0
