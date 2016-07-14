Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:24597 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbcGNJ03 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 14 Jul 2016 05:26:29 -0400
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFC 0/3] watchdog: introduce open deadline
Date: Thu, 14 Jul 2016 11:16:25 +0200
Message-ID: <1468487788-22457-1-git-send-email-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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
modified driver for setting WDOG_HW_RUNNING - patches will be
submitted seperately) and a Wandboard.

Rasmus Villemoes (3):
  watchdog: change watchdog_need_worker logic
  watchdog: introduce watchdog_worker_should_ping helper
  watchdog: introduce CONFIG_WATCHDOG_OPEN_DEADLINE

 drivers/watchdog/Kconfig        | 21 +++++++++++++++
 drivers/watchdog/watchdog_dev.c | 60 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 74 insertions(+), 7 deletions(-)

-- 
2.5.0

