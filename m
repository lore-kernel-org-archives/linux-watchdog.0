Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:47467 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751998Ab2KLIhc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Nov 2012 03:37:32 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2210724bkc.19
        for <linux-watchdog@vger.kernel.org>; Mon, 12 Nov 2012 00:37:31 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v9 RESEND 0/3] watchdog: at91sam9_wdt: add device tree support
Date: Mon, 12 Nov 2012 09:37:24 +0100
Message-Id: <1352709447-8306-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,

This patchset is for adding device tree support to the
at91sam9_wdt driver.

The "timeout-sec" binding is added by another patchset already sent:
[PATCH v4 0/8] watchdog: dt: add support for the timeout-sec dt property

Changes:
v9:
 - rebased over v3.7-rc1
v8:
 - add __initconst to at91_wdt_dt_ids
v7:
 - split the patchset
 - remove timeout binding
v6:
 - add watchdog core proprty timeout binding
 - add as example to the orion_wdt driver the new timeout binding
v5:
 - split dts commit in two, one for socs and one for boards.
v4:
 - use "atmel,at91sam9260-wdt" as compatible
v3:
 - add heartbeat option
 - default disabled for all the soc, enable only for evk-pro3 board
 - add at91sam9263 and at91sam9g45 soc
v2:
 - add missing to and cc addresses

Based on v3.7-rc5

Fabio Porcedda (3):
  watchdog: at91sam9_wdt: add device tree support
  ARM: at91/dts: add at91sam9_wdt driver to at91sam926x, at91sam9g45
  ARM: at91/dts: evk-pro3: enable watchdog

 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt | 15 +++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi                       |  6 ++++++
 arch/arm/boot/dts/at91sam9263.dtsi                       |  6 ++++++
 arch/arm/boot/dts/at91sam9g45.dtsi                       |  6 ++++++
 arch/arm/boot/dts/evk-pro3.dts                           |  4 ++++
 drivers/watchdog/at91sam9_wdt.c                          | 11 +++++++++++
 6 files changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt

-- 
1.8.0

