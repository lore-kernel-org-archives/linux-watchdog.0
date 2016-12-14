Return-path: <prvs=149622c30=Rasmus.Villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Guenter Roeck
	<linux@roeck-us.net>
Subject: [PATCH v3 0/2] watchdog: allow setting deadline for opening /dev/watchdogN
Date: Wed, 14 Dec 2016 14:37:32 +0100
Message-ID: <1481722654-6266-1-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

If a watchdog driver tells the framework that the device is running,
the framework takes care of feeding the watchdog until userspace opens
the device. If the userspace application which is supposed to do that
never comes up properly, the watchdog is fed indefinitely by the
kernel. This can be especially problematic for embedded devices.

These patches allow one to set a maximum time for which the kernel
will feed the watchdog, thus ensuring that either userspace has come
up, or the board gets reset. This allows fallback logic in the
bootloader to attempt some recovery (for example, if an automatic
update is in progress, it could roll back to the previous version).

The patches have been tested on a Raspberry Pi 2 (with a suitably
modified driver for setting WDOG_HW_RUNNING) and a Wandboard.

Changes since v2:

 - Use device_property_read_u32 rather than of_property_read_u32

  - Remove config option to ifdef this completely out, instead set the
    default timeout to "infinite" to preserve existing behaviour.

Changes since v1:

 - Take the timeout value from the device tree node rather than a
   watchdog module parameter.


Rasmus Villemoes (2):
  watchdog: introduce watchdog_worker_should_ping helper
  watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT

 drivers/watchdog/Kconfig         | 14 ++++++++++++++
 drivers/watchdog/watchdog_core.c | 16 ++++++++++++++++
 drivers/watchdog/watchdog_dev.c  | 27 ++++++++++++++++++++++++++-
 include/linux/watchdog.h         |  7 +++++++
 4 files changed, 63 insertions(+), 1 deletion(-)

-- 
2.7.4
