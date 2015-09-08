Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:59281 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752071AbbIHRqP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Sep 2015 13:46:15 -0400
From: Justin Chen <justinpopo6@gmail.com>
To: <linux-kernel@vger.kernel.org>
CC: <robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<justinpopo6@gmail.com>, <linux@roeck-us.net>,
	<devicetree@vger.kernel.org>, <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>,
	<bcm-kernel-feedback-list@broadcomc.com>
Subject: [PATCH 0/2 v3 ] watchdog: driver for BCM7038 and newer chips.
Date: Tue, 8 Sep 2015 10:45:46 -0700
Message-ID: <1441734348-11138-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

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

