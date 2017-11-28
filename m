Return-Path: <prvs=4985278a0=Rasmus.Villemoes@prevas.dk>
Return-path: <prvs=4985278a0=Rasmus.Villemoes@prevas.dk>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: <linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Wim Van Sebroeck <wim@iguana.be>, Esben Haabendal <esben@haabendal.dk>,
	<mnhu@prevas.dk>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Guenter
 Roeck <linux@roeck-us.net>
Subject: [PATCH v7 0/2] watchdog: allow setting deadline for opening /dev/watchdogN
Date: Tue, 28 Nov 2017 11:35:48 +0100
Message-ID: <1511865350-20665-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

If a watchdog driver tells the framework that the device is running,
the framework takes care of feeding the watchdog until userspace opens
the device. If the userspace application which is supposed to do that
never comes up properly, the watchdog is fed indefinitely by the
kernel. This can be especially problematic for embedded devices.

The existing handle_boot_enabled cmdline parameter/config option
partially solves that, but that is only usable for the subset of
hardware watchdogs that have (or can be configured by the bootloader
to have) a timeout that is sufficient to make it realistic for
userspace to come up. Many devices have timeouts of a second, or even
less, making handle_boot_enabled insufficient.

These patches allow one to set a maximum time for which the kernel
will feed the watchdog, thus ensuring that either userspace has come
up, or the board gets reset. This allows fallback logic in the
bootloader to attempt some recovery (for example, if an automatic
update is in progress, it could roll back to the previous version).

The patches have been tested on a Raspberry Pi 2 and a Wandboard.

A preparatory patch of this series has already been merged
(c013b65ad8a1e "watchdog: introduce watchdog_worker_should_ping
helper"). On 2017-07-08, Guenter wrote [1]

  It is sufficiently different to handle_boot_enabled to keep it
  separate. I am mostly ok with the patch.  One comment below.

That one comment (regarding the placement of the module_param) has
been addressed in this version.

There has been some opposition to making the default value of
watchdog.open_timeout configurable in Kconfig, but in [2] Guenter said

  I used to be opposed to it, but it does seem to make some sense to
  me now after thinking about it.

I do hope that these patches can now find their way into the kernel,
but if 2/2 is somehow still controversial, please consider just taking
1/2. (I can't help but noting that handle_boot_enabled does get its
default value from Kconfig, and nobody complained about that when that
option was added).

[1] https://patchwork.kernel.org/patch/9754095/
[2] https://patchwork.kernel.org/patch/9754093/

Rasmus Villemoes (2):
  watchdog: introduce watchdog.open_timeout commandline parameter
  watchdog: introduce CONFIG_WATCHDOG_OPEN_TIMEOUT

 Documentation/watchdog/watchdog-parameters.txt |  9 +++++++++
 drivers/watchdog/Kconfig                       |  9 +++++++++
 drivers/watchdog/watchdog_dev.c                | 27 +++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 1 deletion(-)

-- 
2.7.4
