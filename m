Return-path: <slemieux.tyco@gmail.com>
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	arnd@arndb.de,
	linux@roeck-us.net,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org,
	wim@iguana.be,
	stigge@antcom.de,
	vz@mleia.com
Subject: [PATCH v7 0/6] watchdog: pnx4008: add restart handler
Date: Fri,  4 Mar 2016 13:44:04 -0500
Message-Id: <1457117050-13543-1-git-send-email-slemieux.tyco@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Sylvain Lemieux <slemieux@tycoint.com>

The LPC32xx provide the capability to perform a soft or hard reset;
a soft reset will no reset the external peripheral
(i.e. RESOUT_N output not asserted).

This changeset migrate the restart code from the "mach-lpc32xx" to
the "pnx-4008" watchdog driver and add the soft reset capability.

The default behavior (i.e. hard reset) remain unchanged.

This patchset have a dependency on the following patch:
watchdog: Add 'action' and 'data' parameters to restart handler callback
http://permalink.gmane.org/gmane.linux.watchdog/3364/

Note:
Patch #5 was generated with the option "--unified=2" to ensure
it can be apply before or after the changes for the new 
LPC32xx irqchip driver:
- http://permalink.gmane.org/gmane.linux.drivers.devicetree/144683
---
Changes from v6 to v7:
* Update the patch as per the feedback received from:
  Guenter: http://permalink.gmane.org/gmane.linux.watchdog/3488
  - remove typecast.

Changes from v5 to v6:
* Update the patch as per the feedback received from:
  Guenter: http://permalink.gmane.org/gmane.linux.watchdog/3420
  - remove typecast.

Changes from v4 to v5:
* Rebased on the following patch:
  http://permalink.gmane.org/gmane.linux.watchdog/3364/

Changes from v3 to v4:
* Update the patch as per the feedback received from:
  Arnd: http://permalink.gmane.org/gmane.linux.watchdog/3329
  - Switch patch #5 and #6 order.

Changes from v2 to v3:
* Update the patch as per the feedback received from:
  Joachim: http://permalink.gmane.org/gmane.linux.watchdog/3303
  - remove explicit clock enable from restart handler.
  - verify "register_restart_handler" return value.
  - add call to unregister_restart_handler".
  - do the restart handling directly in "pnx4008_restart_handler".
* Move the change to "phy3250.c" into a separate patch and generate
  the new patch with the "--unified=2" option.

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

Sylvain Lemieux (6):
  watchdog: pnx4008: update logging during power-on
  watchdog: pnx4008: add restart handler
  watchdog: pnx4008: add support for soft reset
  watchdog: pnx4008: restart: support "cmd" from userspace
  arm: lpc32xx: phy3250 remove restart hook
  arm: lpc32xx: remove restart handler

 arch/arm/mach-lpc32xx/common.c  | 15 ---------------
 arch/arm/mach-lpc32xx/common.h  |  1 -
 arch/arm/mach-lpc32xx/phy3250.c |  1 -
 drivers/watchdog/pnx4008_wdt.c  | 42 +++++++++++++++++++++++++++++++++++++++--
 4 files changed, 40 insertions(+), 19 deletions(-)

-- 
1.8.3.1
