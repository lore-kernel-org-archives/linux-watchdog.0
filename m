Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:38086 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754009Ab2IYKZJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 25 Sep 2012 06:25:09 -0400
Received: by eekb15 with SMTP id b15so689335eek.19
        for <linux-watchdog@vger.kernel.org>; Tue, 25 Sep 2012 03:25:08 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v4 0/2] watchdog: at91sam9_wdt: add device tree support
Date: Tue, 25 Sep 2012 12:25:02 +0200
Message-Id: <1348568704-28304-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

This set of patches is for adding device tree support to the
at91sam_wdt driver.

I've tested it on an at91sam9260 board (evk-pro3).

Changes:
v4:
 - use "atmel,at91sam9260-wdt" as compatible
v3:
 - add heartbeat option
 - default disabled for all the soc, enable only for evk-pro3 board
 - add at91sam9263 and at91sam9g45 soc
v2:
 - add missing to and cc addresses

Fabio Porcedda (2):
  watchdog: at91sam9_wdt: add device tree support
  ARM: at91: add at91sam9_wdt driver to at91sam926x, at91sam9g45

 .../devicetree/bindings/watchdog/atmel-wdt.txt      | 19 +++++++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                  |  6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi                  |  6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                  |  6 ++++++
 arch/arm/boot/dts/evk-pro3.dts                      |  4 ++++
 drivers/watchdog/at91sam9_wdt.c                     | 21 +++++++++++++++++++++
 6 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

-- 
1.7.11.3

