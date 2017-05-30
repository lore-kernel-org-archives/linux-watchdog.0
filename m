Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:35670 "EHLO mail01.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751192AbdE3I4y (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 30 May 2017 04:56:54 -0400
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: <linux-watchdog@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        <esben.haabendal@gmail.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v6 0/3] watchdog: allow setting deadline for opening /dev/watchdogN
Date: Tue, 30 May 2017 10:56:44 +0200
Message-ID: <1496134608-7375-1-git-send-email-rasmus.villemoes@prevas.dk>
In-Reply-To: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1495462000-28979-1-git-send-email-rasmus.villemoes@prevas.dk>
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

The patches have been tested on a Raspberry Pi 2 and a Wandboard.

v6 tweaks the wording in watchdog-parameters.txt to avoid having to
update it if and when the watchdog core grows new parameters. It also
adds a little more rationale to the commit messages for 2/3 and 3/3,
and adds Reviewed-bys to 1/3 which is unchanged from v5.

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

 Documentation/watchdog/watchdog-parameters.txt |  9 +++++++
 drivers/watchdog/Kconfig                       |  9 +++++++
 drivers/watchdog/watchdog_dev.c                | 37 +++++++++++++++++++++++---
 3 files changed, 51 insertions(+), 4 deletions(-)

-- 
2.7.4

