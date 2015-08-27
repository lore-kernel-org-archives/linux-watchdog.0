Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:38325 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbbH0XRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Aug 2015 19:17:43 -0400
From: Gregory Fong <gregory@broadcom.com>
To: Gregory Fong <gregory.0xf0@gmail.com>
CC: "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"wim@iguana.be" <wim@iguana.be>,
	"linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
	Justin Chen <justinpopo6@gmail.com>
Subject: [PATCH v2 0/2] watchdog: driver for BCM7038 and newer chips.
Date: Thu, 27 Aug 2015 23:17:43 +0000
Message-ID: <55DF9AB6.9040900@broadcom.com>
Content-Language: en-US
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This driver is for a watchdog block contained in all Broadcom Set-top
Box chips since BCM7038. BCM7038 was made public during the 2004 CES,
and since then, many chips use this watchdog block including some cable
modem chips.

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
 drivers/watchdog/bcm7038_wdt.c                     | 235 +++++++++++++++++++++
 4 files changed, 263 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
 create mode 100644 drivers/watchdog/bcm7038_wdt.c

-- 
2.1.0
