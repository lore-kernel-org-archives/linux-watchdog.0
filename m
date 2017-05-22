Return-path: <prvs=308efd9ee=Rasmus.Villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: <linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
	<esben.haabendal@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 0/3] watchdog: allow setting deadline for opening /dev/watchdogN
Date: Mon, 22 May 2017 16:06:36 +0200
Message-ID: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
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

The patches have been tested on a Raspberry Pi 2 and a Wandboard.

v5 is identical to v4 posted in January, just rebased to current
master (v4.12-rc2).

v4 is mostly identical to v1. The differences are that the ability to
compile out this feature is removed, and the ability to set the
default value for the watchdog.open_timeout command line parameter via
Kconfig is split into a separate patch.

Compared to v2/v3, this drops the ability to set the open_timeout via
a device property; I'll leave implementing that to those who actually
need it.

Rasmus Villemoes (3):
  watchdog: introduce watchdog_worker_should_ping helper
  watchdog: introduce watchdog.open_timeout commandline parameter
  watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT

 Documentation/watchdog/watchdog-parameters.txt | 10 +++++++
 drivers/watchdog/Kconfig                       |  9 +++++++
 drivers/watchdog/watchdog_dev.c                | 37 +++++++++++++++++++++++---
 3 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.7.4
