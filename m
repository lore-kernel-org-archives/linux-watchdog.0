Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:12237 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbbHEJF1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Aug 2015 05:05:27 -0400
From: Wenyou Yang <wenyou.yang@atmel.com>
To: <wim@iguana.be>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>
CC: <sylvain.rochet@finsecur.com>, <nicolas.ferre@atmel.com>,
	<boris.brezillon@free-electrons.com>, <wenyou.yang@atmel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/2] add a new driver to support SAMA5D4 watchdog timer
Date: Wed, 5 Aug 2015 16:57:20 +0800
Message-ID: <1438765043-11030-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

Because the watchdog WDT_MR register can be written more than once,
its work mechanism is different from the at91sam9260 watchdog driver.
Open the device file to enable the watchdog hardware, close to disable it,
and ping it from the user space directly to keep it alive.

Thank for Guenter's review, the version 2.0 changes are listed as below.

Changes from v2.0
 1./ Use a specific driver name, at91_sama5d4_wdt.c.
 2./ Remove '-' at the end of macro name and unnecessary check.
 3./ Use alphabetic order for include files.

Wenyou Yang (2):
  drivers: watchdog: add a driver to support SAMA5D4 watchdog timer
  Documentation: dt: binding: atmel-sama5d4-wdt: for SAMA5D4 watchdog
    driver

 .../bindings/watchdog/atmel-sama5d4-wdt.txt        |   35 +++
 drivers/watchdog/Kconfig                           |    9 +
 drivers/watchdog/Makefile                          |    1 +
 drivers/watchdog/at91_sama5d4_wdt.c                |  279 ++++++++++++++++++++
 drivers/watchdog/at91sam9_wdt.h                    |    2 +
 5 files changed, 326 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-sama5d4-wdt.txt
 create mode 100644 drivers/watchdog/at91_sama5d4_wdt.c

-- 
1.7.9.5

