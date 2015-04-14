Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:51551 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751976AbbDNH1d (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 14 Apr 2015 03:27:33 -0400
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com
Cc: Wenyou.Yang@atmel.com, Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv6 0/4] watchdog: Extend kernel API and add early_timeout_sec feature
Date: Tue, 14 Apr 2015 10:26:48 +0300
Message-Id: <1428996412-30448-1-git-send-email-timo.kokkonen@offcode.fi>
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

The changes are designed to be taken in use one driver at time. If the
driver does not set the new parameters and call
watchdog_init_params(), the watchdog behavior is exactly the same as
before.

In principle this new API makes it possible for the user space to see
every watchdog hardware to behave the same, at least in terms of
watchdog timeouts. Once the API is in, it should be easier to move
even more common behavior out of the driver code to the watchdog core
and make the drivers simpler. This patch set converts at91sam9_wdt to
use the new API.

Please review and give feedback.

Patch revision history:

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

Timo Kokkonen (4):
  watchdog: Extend kernel API to know about HW limitations
  watchdog: Allow watchdog to reset device at early boot
  devicetree: Document generic watchdog properties
  watchdog: at91sam9_wdt: Convert to use new watchdog core extensions

 .../devicetree/bindings/watchdog/watchdog.txt      |  20 ++++
 drivers/watchdog/at91sam9_wdt.c                    |  58 ++--------
 drivers/watchdog/watchdog_core.c                   | 124 ++++++++++++++++++++-
 drivers/watchdog/watchdog_dev.c                    |  26 ++++-
 include/linux/watchdog.h                           |  24 ++++
 5 files changed, 201 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.txt

-- 
2.1.0

