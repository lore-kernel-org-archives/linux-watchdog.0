Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41973 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964998Ab2JDI1F (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Oct 2012 04:27:05 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so160767eek.19
        for <linux-watchdog@vger.kernel.org>; Thu, 04 Oct 2012 01:27:03 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [RFC PATCH v2 0/2]   watchdog: core: dt: add support for the timeout-sec dt property
Date: Thu,  4 Oct 2012 10:26:57 +0200
Message-Id: <1349339219-1467-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,
this patchset add the timeout-sec property to the watchdog core,
in the next revision i will add the pnx4008 and s3c2410 driver.

changes:
v2:
  - change "timeout" to "timeout-sec" as asked by Jean-Christophe
  - at91sam9_wdt: use the new helper function
  - at91sam9_wdt: add bounds checking
  - watchdog.h: add bounds checking 

Fabio Porcedda (2):
  watchdog: core: dt: add support for the timeout-sec dt property
  watchdog: add timeout-sec property binding to some drivers

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 ++++
 .../devicetree/bindings/watchdog/marvel.txt        |  5 +++++
 Documentation/watchdog/watchdog-kernel-api.txt     |  3 +++
 drivers/watchdog/at91sam9_wdt.c                    | 23 ++++++++++++++++------
 drivers/watchdog/orion_wdt.c                       | 13 ++++++------
 include/linux/watchdog.h                           | 15 ++++++++++++++
 6 files changed, 51 insertions(+), 12 deletions(-)

-- 
1.7.11.3

