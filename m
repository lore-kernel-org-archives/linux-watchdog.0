Return-path: <slemieux.tyco@gmail.com>
From: slemieux.tyco@gmail.com
To: linux-arm-kernel@lists.infradead.org,
	wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	stigge@antcom.de,
	vz@mleia.com
Subject: [PATCH v2 0/5] watchdog: pnx4008: add restart handler
Date: Mon, 22 Feb 2016 11:55:38 -0500
Message-Id: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

The LPC32xx provide the capability to perform a soft or hard reset;
a soft reset will no reset the external peripheral
(i.e. RESOUT_N output not asserted).

This changeset migrate the restart code from the "mach-lpc32xx" to
the "pnx-4008" watchdog driver and add the soft reset capability.

The default behavior (i.e. hard reset) remain unchanged.

The core restart handler support added by this change:
2165bf524da5f5e496d - "watchdog: core: add restart handler support"
is not use in this changeset; it does not support the reboot mode.

---
Changes from v1 to v2:
* Rename patch title;
  was "arm: lpc32xx: restart: add support for soft reset"
* Update the patch as per the feedback received from:
  Joachim: http://permalink.gmane.org/gmane.linux.ports.arm.kernel/479791
  - migrate restart code from "mach-lpc32xx" to "pnx-4008" driver.
* Add soft reset support to "pnx-4008" driver instead of "mach-lpc32xx".
* Use define available in "pnx-4008" when writting to watchdog register.
* Remove restart handler from "mach-lpc32xx".
* Remove restart hook from "phy3250.c".
* Update driver logging during power-on. 

Sylvain Lemieux (5):
  watchdog: pnx4008: update logging during power-on
  watchdog: pnx4008: add restart handler
  watchdog: pnx4008: add support for soft reset
  watchdog: pnx4008: restart: support "cmd" from userspace
  arm: lpc32xx: remove restart handler

 arch/arm/mach-lpc32xx/common.c  | 15 ------------
 arch/arm/mach-lpc32xx/common.h  |  1 -
 arch/arm/mach-lpc32xx/phy3250.c |  1 -
 drivers/watchdog/pnx4008_wdt.c  | 53 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 51 insertions(+), 19 deletions(-)

-- 
1.8.3.1
