Return-path: <prvs=147e00da7=Rasmus.Villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Guenter Roeck
	<linux@roeck-us.net>
Subject: [PATCH v2 0/2] watchdog: allow setting deadline for opening /dev/watchdogN
Date: Mon, 12 Dec 2016 10:17:51 +0100
Message-ID: <1481534273-7600-1-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
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

Changes since the initial RFC (https://lkml.org/lkml/2016/7/14/254):
take the timeout value from the device tree node rather than a
watchdog module parameter.

Rasmus Villemoes (2):
  watchdog: introduce watchdog_worker_should_ping helper
  watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE

 drivers/watchdog/Kconfig         | 19 +++++++++++++++++++
 drivers/watchdog/watchdog_core.c | 17 +++++++++++++++++
 drivers/watchdog/watchdog_dev.c  | 38 +++++++++++++++++++++++++++++++++++++-
 include/linux/watchdog.h         |  9 +++++++++
 4 files changed, 82 insertions(+), 1 deletion(-)

-- 
2.7.4
