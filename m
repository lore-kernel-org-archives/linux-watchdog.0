Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:58602 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755806AbbDVLMA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Apr 2015 07:12:00 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv7 0/8] watchdog: Extend kernel API and add early_timeout_sec feature
Date: Wed, 22 Apr 2015 14:11:34 +0300
Message-Id: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi>
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
this problem, this patch set extends the kernel watchdog API with a few
parameters that let the core know more about the watchdog HW and take
care about the timeout extending.

The patch set also implements "early_timeout_sec" feature that is very
common on many production systems where early kernel or user space
crashes must lead to a device reset. Traditional watchdog handling
does not allow this as the watchdog is stopped (fully or emulating
stopped state with kernel timers) before user space opens it for the
first time.

As a consequence of the core being able to extend the HW timeout, the
maximum timeout parameter is no longer used with the drivers that use
the new API extension. Instead, arbitrary timeout parameters are
supported, as long as they are longer than the minimum supported by
the driver.

The changes in this series are designed to be taken in use one driver
at time. Old drivers continue to work exactly the same as before.

This patch set converts at91sam9_wdt, imx2_wdt and omap_wdt to use the
new API. The patches have been tested on three ARM boards: ADG42 (at91
sama5d3), beaglebone and wandboard dual.

Please review and give feedback.

Patch revision history:

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


Timo Kokkonen (8):
  watchdog: Extend kernel API to know about HW limitations
  watchdog: Allow watchdog to reset device at early boot
  devicetree: Document generic watchdog properties
  Documentation/watchdog: watchdog-test.c: Add support for changing
    timeout
  watchdog: at91sam9_wdt: Convert to use new watchdog core extensions
  watchdog: imx2_wdt: Convert to use new core extensions
  watchdog: omap_wdt: Fix memory leak on probe fail
  watchdog: omap_wdt: Convert to use new core extensions

 .../devicetree/bindings/watchdog/watchdog.txt      |  20 ++++
 Documentation/watchdog/src/watchdog-test.c         |   6 +
 drivers/watchdog/at91sam9_wdt.c                    |  62 +++-------
 drivers/watchdog/imx2_wdt.c                        |  43 ++-----
 drivers/watchdog/omap_wdt.c                        |  48 ++++++--
 drivers/watchdog/watchdog_core.c                   | 127 ++++++++++++++++++++-
 drivers/watchdog/watchdog_dev.c                    |  79 +++++++++++--
 include/linux/watchdog.h                           |  24 ++++
 8 files changed, 313 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.txt

-- 
2.1.0

