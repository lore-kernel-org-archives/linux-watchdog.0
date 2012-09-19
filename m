Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55856 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054Ab2ISL5p (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Sep 2012 07:57:45 -0400
Received: by bkwj10 with SMTP id j10so464087bkw.19
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Sep 2012 04:57:44 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH v2 0/2] watchdog: at91sam9_wdt: add device tree support
Date: Wed, 19 Sep 2012 13:57:39 +0200
Message-Id: <1348055861-7857-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

This set of patches is for adding device tree support to the
at91sam_wdt driver and the at91sam9260 soc.

I've tested it on an at91sam9260 board (evk-pro3).

Changes:
v2:
 - add missing to and cc addresses

Fabio Porcedda (2):
  watchdog: at91sam9_wdt: add device tree support
  ARM: at91: add at91sam9_wdt driver to at91sam9260

 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                       |  6 ++++++
 drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

-- 
1.7.11.3

