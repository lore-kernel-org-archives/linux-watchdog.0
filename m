Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51213 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754048AbbESI0o (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 19 May 2015 04:26:44 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv8 00/10]  watchdog: Extend kernel API and add early_timeout_sec feature
Date: Tue, 19 May 2015 11:25:59 +0300
Message-Id: <1432023969-20736-1-git-send-email-timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog kernel API is quite limited. It has support for providing
generic device handling, but it doesn't really know anything about the
watchdog hardware or its constraints. The watchdog drivers come with a
lot of diversity and their own set of quirks and constraints. Some of
their limitations are not nice for the user space, so the drivers work
around them with all sorts of ad hoc implementations.

One common pattern is to use kernel timers or work queues to allow
longer timeout parameters than the actual hardware supports. To solve
this problem, this patch set extends the kernel watchdog API with a
few parameters that let the core know more about the watchdog HW and
take care about the timeout extending. This also lets core emulate
unstoppable hardware by pinging the watchdog from the worker while the
watchdog is expected to be stopped.

A generic watchdog policy is also introduced in order to choose what
to do with the watchdog on boot up. It can be stopped, like before, or
it can be started or left untouched. Starting a watchdog on the boot
up may require that kernel keeps the watchdog alive for some time
until the user space takes over it. For this "early timeout" value is
introduced. It can be given a default value from Kconfig or
"early_timeout_sec" device tree property can be used to override the
built in default.

The changes in this series are designed to be taken in use one driver
at time. Old drivers continue to work exactly the same as before.

This patch set converts at91sam9_wdt, imx2_wdt and omap_wdt to use the
new API extensions. The patches have been tested on three ARM boards:
ADG42 (at91 sama5d3), beaglebone and wandboard dual. These three
different hardware tests fully configurable watchdog (omap_wdt),
configurable but unstoppable watcdog (imx2_wdt) and fully unstoppable
and runtime unconfigurable watchdog (at91sama5d3_wdt). The combination
of these three watchdogs gives fairly good coverage of possible use
cases.

Please review and give feedback.

Patch revision history:

-v8: hw_heartbeat and hw_max_timeout values are converted in msec
  resolution instead of jiffies. watchdog_active() function is renamed
  to watchdog_hw_active() in order to state more explicitly what it is
  testing. This series now talks more about how it implements new
  watchdog policy instead of talking about early-timeout-sec property,
  which not the whole story of it. The default policy can also be
  selected with Kconfig option. Watchdog documentation is also updated
  in Documentation directory and in watchdog.h header file.

-v7: Convert also omap_wdt and imx2_wdt drivers in addition to
  at91sam9_wdt to use the new core API. This allowed me to test a lot
  more use cases and find many bugs I had left in previous
  version. The max_timeout parameter is no longer needed for new
  drivers as watchdog core can extend the timeout and support
  unlimited timeout values on behalf of the HW.

-v6: Fixed some issued based on feedback from Wenyou Yang. The logic
  in watchdog_worker() function is now significantly easier to
  read. Several errors with stopping and starting the worker are also
  now fixed.

-v5: Re-think the approach to be fully generic. The early_timeout_sec
  handling is no longer in the driver but in the watchdog core. As a
  result the core needed to gain knowledge about the watchdog
  hardware. Appropriate handling is added in the core. The side effect
  for this is that drivers using the new extensions can be simplified
  a lot and different kinds of watchdog hardware can be made to
  behave the same for the user space.

-v4: Binding documentation is now separated completely from the driver
  patch. The documentation no longer makes any assumptions about how
  the actual implementation is made, it just describes the actual
  behavior the driver should implement in order to satisfy the
  requirement.

- v3: Rename the property to "early-timeout-sec" and use it as a
  timeout value that stops the timer in the atmel driver after the
  timeout expires. A watchdog.txt is also introduced for documenting
  the common watchdog properties, including now this one and
  "timeout-sec" property.

- v2: Rename the property to "enable-early-reset" as the behavior
  itself is not atmel specific. This way other drivers are free to
  implement same behavior with the same property name.

- v1: Propose property name "atmle,no-early-timer" for disabling the
  timer that keeps the atmel watchdog running until user space opens
  the device.

Timo Kokkonen (10):
  watchdog: Rename watchdog_active to watchdog_hw_active
  watchdog: core: Ping watchdog on behalf of user space when needed
  watchdog: core: Introduce default watchdog policy
  watchdog: core: Allow extending early timeout
  Documentation/watchdog: Document watchdog core API changes
  devicetree: Document generic watchdog properties
  Documentation/watchdog: watchdog-test.c: Add support for changing
    timeout
  watchdog: at91sam9_wdt: Convert to use new watchdog core extensions
  watchdog: imx2_wdt: Convert to use new core extensions
  watchdog: omap_wdt: Convert to use new core extensions

 .../devicetree/bindings/watchdog/watchdog.txt      |  20 +++
 .../watchdog/convert_drivers_to_kernel_api.txt     |  26 ++++
 Documentation/watchdog/src/watchdog-test.c         |   6 +
 Documentation/watchdog/watchdog-kernel-api.txt     |  71 +++++----
 drivers/watchdog/Kconfig                           |  72 +++++++++
 drivers/watchdog/at91sam9_wdt.c                    |  73 ++-------
 drivers/watchdog/iTCO_wdt.c                        |   2 +-
 drivers/watchdog/imx2_wdt.c                        |  51 ++-----
 drivers/watchdog/omap_wdt.c                        |  26 +++-
 drivers/watchdog/sp805_wdt.c                       |   4 +-
 drivers/watchdog/stmp3xxx_rtc_wdt.c                |   4 +-
 drivers/watchdog/tegra_wdt.c                       |   6 +-
 drivers/watchdog/twl4030_wdt.c                     |   4 +-
 drivers/watchdog/ux500_wdt.c                       |   4 +-
 drivers/watchdog/via_wdt.c                         |   2 +-
 drivers/watchdog/watchdog_core.c                   | 170 ++++++++++++++++++++-
 drivers/watchdog/watchdog_dev.c                    | 116 +++++++++++---
 include/linux/watchdog.h                           |  69 ++++++++-
 18 files changed, 554 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.txt

-- 
2.1.0

