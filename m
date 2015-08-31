Return-path: <justinpopo6@gmail.com>
From: Justin Chen <justinpopo6@gmail.com>
To: <linux-kernel@vger.kernel.org>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<linux@roeck-us.net>, <wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <bcm-kernel-feedback-list@broadcom.com>, Justin
 Chen <justinpopo6@gmail.com>
Subject: [PATCH v3 0/2] watchdog: driver for BCM7038 and newer chips.
Date: Mon, 31 Aug 2015 11:02:41 -0700
Message-ID: <1441044163-16563-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

This driver is for a watchdog block contained in all Broadcom Set-top
Box chips since BCM7038. BCM7038 was made public during the 2004 CES,
and since then, many chips use this watchdog block including some cable
modem chips.

Changes since v2:
Added clk_disable_unprepare if watchdog fails to register.

Changes since v1:
Removed clock-frequency because it brought unnecessary complexity to the
driver.
Renamed a few variables.

Patch 1: watchdog device tree binding documentation

Patch 2: watchdog driver

Justin Chen (2):
  watchdog: bcm7038: add device tree binding documentation
  watchdog: Watchdog driver for Broadcom Set-Top Box

 .../bindings/watchdog/brcm,bcm7038-wdt.txt         |  19 ++
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bcm7038_wdt.c                     | 237 +++++++++++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
 create mode 100644 drivers/watchdog/bcm7038_wdt.c

-- 
2.1.0
