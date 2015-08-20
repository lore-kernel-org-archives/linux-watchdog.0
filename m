Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:8263 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbbHTRmQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Aug 2015 13:42:16 -0400
From: Justin Chen <justinpopo6@gmail.com>
To: <linux-kernel@vger.kernel.org>
CC: <feedback-list@broadcom.com>, <devicetree@vger.kernel.org>,
	<robh+dt@kernel.org>, <pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<wim@iguana.be>, <linux-watchdog@vger.kernel.org>,
	Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH 0/2] watchdog: driver for BCM7038 and newer chips.
Date: Thu, 20 Aug 2015 10:41:24 -0700
Message-ID: <1440092486-16905-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver is for a watchdog block contained in all Broadcom Set-top
Box chips since BCM7038. BCM7038 was made public during the 2004 CES,
and since then, many chips use this watchdog block including some cable
modem chips.

Patch 1: watchdog device tree binding documentation

Patch 2: watchdog driver

Justin Chen (2):
  watchdog: bcm7038: add device tree binding documentation
  watchdog: Watchdog driver for Broadcom Set-Top Box

 .../bindings/watchdog/brcm,bcm7038-wdt.txt         |  19 ++
 drivers/watchdog/Kconfig                           |   8 +
 drivers/watchdog/Makefile                          |   1 +
 drivers/watchdog/bcm7038_wdt.c                     | 253 +++++++++++++++++++++
 4 files changed, 281 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
 create mode 100644 drivers/watchdog/bcm7038_wdt.c

-- 
2.1.0

