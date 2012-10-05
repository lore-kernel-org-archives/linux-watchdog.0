Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:39673 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab2JEKQO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Oct 2012 06:16:14 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so1148438eek.19
        for <linux-watchdog@vger.kernel.org>; Fri, 05 Oct 2012 03:16:13 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [RFC PATCH v3 0/4] watchdog: core: dt: add support for the timeout-sec dt property
Date: Fri,  5 Oct 2012 12:16:05 +0200
Message-Id: <1349432169-13006-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,
this patchset add the timeout-sec property to the watchdog core,
in the next revision i will add the s3c2410 driver.

changes:
v3:
  - rename watchdog_probe_dt_timeout ->  watchdog_init_timeout
  - move the watchdog_init_timeout function from inline to watchdog_core.c
  - add timeout parameter handling code to watchdog_init_timeout
  - add timeout-sec property to the pnx4008-wdt driver
  - add two small commit for fixup and cleanup
v2:
  - change "timeout" to "timeout-sec" as asked by Jean-Christophe
  - at91sam9_wdt: use the new helper function
  - at91sam9_wdt: add bounds checking
  - watchdog.h: add bounds checking 



Fabio Porcedda (4):
  watchdog: core: dt: add support for the timeout-sec dt property
  watchdog: add timeout-sec property binding to some drivers
  watchdog: orion_wdt: litte cleanup
  watchdog: WatchDog Timer Driver Core: fix comment

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 ++++
 .../devicetree/bindings/watchdog/marvel.txt        |  5 ++++
 .../devicetree/bindings/watchdog/pnx4008-wdt.txt   |  4 ++++
 Documentation/watchdog/watchdog-kernel-api.txt     |  4 ++++
 drivers/watchdog/Kconfig                           |  1 +
 drivers/watchdog/at91sam9_wdt.c                    | 17 ++++++++++----
 drivers/watchdog/orion_wdt.c                       | 13 ++++-------
 drivers/watchdog/pnx4008_wdt.c                     |  7 +++---
 drivers/watchdog/watchdog_core.c                   | 27 ++++++++++++++++++++++
 include/linux/watchdog.h                           |  6 ++++-
 10 files changed, 71 insertions(+), 17 deletions(-)

-- 
1.7.11.3

