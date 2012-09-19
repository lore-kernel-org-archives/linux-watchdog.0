Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:43548 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916Ab2ISKWe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 19 Sep 2012 06:22:34 -0400
Received: by eekc1 with SMTP id c1so319946eek.19
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Sep 2012 03:22:32 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH 0/2] watchdog: at91sam9_wdt: add device tree support
Date: Wed, 19 Sep 2012 12:22:28 +0200
Message-Id: <1348050150-5600-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

This set of patches is for adding device tree support to the
at91sam_wdt driver and the at91sam9260 soc.

I've tested it on an at91sam9260 board (evk-pro3).

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

