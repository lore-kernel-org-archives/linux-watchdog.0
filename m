Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:32955 "EHLO
	mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754377Ab3JCTQd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 3 Oct 2013 15:16:33 -0400
Received: from mail172.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with SMTP id 9B2FF1050F8E
	for <linux-watchdog@vger.kernel.org>; Thu,  3 Oct 2013 21:06:25 +0200 (CEST)
From: Boris BREZILLON <b.brezillon@overkiz.com>
To: Rob Herring <rob.herring@calxeda.com>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Rob Landley <rob@landley.net>,
	Russell King <linux@arm.linux.org.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	Fabio Porcedda <fabio.porcedda@gmail.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Guenter Roeck <groeck7@gmail.com>,
	Yang Wenyou <wenyou.yang@atmel.com>
Cc: devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Boris BREZILLON <b.brezillon@overkiz.com>
Subject: [PATCH v4 0/4] watchdog: at91sam9_wdt: handle already configured wdt
Date: Thu,  3 Oct 2013 21:04:39 +0200
Message-Id: <1380827083-6872-1-git-send-email-b.brezillon@overkiz.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hello,

This patch series is a porposal to enhance the sam9 watchdog timer support.

The at91sam9 watchdog timer can only be configured once, and the current
implementation tries to configure it in a static way:
- 2 seconds timeout
- wdt restart every 500ms

If the timer has already been configured with different values, it returns an
error and do not create any watchdog device.

This is not critical if the watchdog is disabled, but if it has been enabled
with different timeout values it will lead to a SoC reset.

This patch series tries to address this issue by adapting the heartbeat value
according the WDT timer config:
- it first tries to configure the timer as requested.
- if it fails it fallbacks to the current config, adapting its heartbeat timer
to the needs

This patch series also move to a dynamically allocated at91wdt device instead
of the static instance. I'm not sure this is the best solution, so please tell
me if you prefer to keep static instance of watchdog.

It adds a new at91 wdt type: software. This new type make use of the at91 wdt
interrupt to trigger a software reboot.

Finally it adds several properties to the device tree bindings.

Best Regards,
Boris

Changes since v3:
 - fix a bug in heartbeat time computation
 - fix a bug in at91_wdt_set_timeout when new timeout is bigger than the old
   one
 - rename at91_wdt_ping into at91_wdt_start
 - remove unneeded ping callback assignment

Changes since v2:
 - fix documentation
 - rework the heartbeat computation to get a more flexible behaviour
 - fix xx_to_yy macros
 - modify warning and error messages
 - remove unneeded parenthesis in arithmetic operations
 - use devm functions to map io memory
 - remove unneeded devm_kfree calls

Change since v1:
 - fix typo in documentaion
 - fix irq dt definition for sama5d3 SoC

Boris BREZILLON (4):
  watchdog: at91sam9_wdt: better watchdog support
  watchdog: at91sam9_wdt: update device tree doc
  ARM: at91/dt: add sam9 watchdog default options to SoCs
  ARM: at91/dt: add watchdog properties to kizbox board

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |   30 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9263.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9g45.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9n12.dtsi                 |    5 +
 arch/arm/boot/dts/at91sam9x5.dtsi                  |    5 +
 arch/arm/boot/dts/kizbox.dts                       |    6 +
 arch/arm/boot/dts/sama5d3.dtsi                     |    5 +
 drivers/watchdog/at91sam9_wdt.c                    |  305 ++++++++++++++------
 9 files changed, 285 insertions(+), 86 deletions(-)

-- 
1.7.9.5

