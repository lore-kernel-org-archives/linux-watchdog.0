Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:14695 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbG1HH6 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 03:07:58 -0400
From: Wenyou Yang <wenyou.yang@atmel.com>
To: <wim@iguana.be>, <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	<mark.rutland@arm.com>, <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>
CC: <sylvain.rochet@finsecur.com>, <nicolas.ferre@atmel.com>,
	<boris.brezillon@free-electrons.com>, <wenyou.yang@atmel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] watchdog: at91sam9_wdt: add new feature support
Date: Tue, 28 Jul 2015 15:00:23 +0800
Message-ID: <1438066825-21923-1-git-send-email-wenyou.yang@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

Atmel Watchdog Timer has a new feature from SAMA5D4, the Watchdog Timer Mode
Register can be written more than once, so the driver can enable/disable
the watchdog timer hardware and set the watchdog timer hardware timeout.

The patch set is to add new feature.

Wenyou Yang (2):
  drivers: watchdog: at91sam9_wdt: add new feature support
  Documentation: dt: binding: atmel-wdt: add a new compitable

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |    4 +-
 drivers/watchdog/at91sam9_wdt.c                    |  255 ++++++++++++++------
 drivers/watchdog/at91sam9_wdt.h                    |    4 +
 3 files changed, 193 insertions(+), 70 deletions(-)

-- 
1.7.9.5

