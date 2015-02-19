Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:53326 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752087AbbBSICI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Feb 2015 03:02:08 -0500
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
To: boris.brezillon@free-electrons.com,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCHv4 0/2] watchdog: Introduce "early-timeout-sec" property
Date: Thu, 19 Feb 2015 10:01:44 +0200
Message-Id: <cover.1424332841.git.timo.kokkonen@offcode.fi>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently we have no means to adjust the watchdog behavior on early
start up before user space has opened the device. The generic behavior
among the watchdog drivers is to not start the watchdog at all (or
disable it, if possible, or in case at91sam9_wdt, start a kernel timer
that keeps on pinging the watchdog on behalf of user space until a
watchdog daemon opens it). This unfortunately opens a time window
between starting the driver and starting the user space watchdog
daemon where a crash in the kernel or user space might prevent the
watchdog from ever resetting the device at all. This is obviously bad
on production systems.

Introduce a new device tree property that, when set, changes the
watchdog driver behavior in such way that there no longer is any
window where crash is not caught by the watchdog. In atmel HW we need
to use a kernel timer to ping the watchdog for the duration of the
timeout, but that is trivial as we already have a timer there that
keeps pinging it until the watchdog device is open. The documentation
however only states how the driver should behave, not how it should be
implemented in some other watchdog hardware.

Patch revision history:

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


Timo Kokkonen (2):
  at91sam9_wdt: Allow watchdog to reset device at early boot
  devicetree: Document generic watchdog properties

 .../devicetree/bindings/watchdog/watchdog.txt        | 20 ++++++++++++++++++++
 drivers/watchdog/at91sam9_wdt.c                      |  9 ++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/watchdog.txt

-- 
2.1.0

