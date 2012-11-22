Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60670 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960Ab2KVSbN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 22 Nov 2012 13:31:13 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so3582476bkw.19
        for <linux-watchdog@vger.kernel.org>; Thu, 22 Nov 2012 10:31:12 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v6 0/7] watchdog: dt: add support for the timeout-sec dt property
Date: Thu, 22 Nov 2012 13:51:49 +0100
Message-Id: <1353588716-28917-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi all,
this patchset add the timeout-sec property to the watchdog core,
to the at91sam9_wdt driver and on all framework enabled watchdog driver
with dt support.
The at91sam9_wdt is tested on evk-pr3,
the other drivers are compile tested only.

This patchset depends on the patchset already sent:
"[PATCH v9 0/3 RESEND] watchdog: at91sam9_wdt: add device tree support"
that is already pulled in arm-soc/for-next branch.

Best regards
Fabio Porcedda

changes:
v6:
  - remove patch for function of_get_timeout_sec as aked by Rob Herring
  - add Acked-by: Jason Cooper <jason@lakedaemon.net>
  - add Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
v5:
  - fix codestyle for compilance ti checkpatch.pl about
    "ERROR: do not initialise statics to 0 or NULL"
    for s3c2410_wdt.c:56 and at91sam9_wdt.c:63
v4:
  - add of_get_timeout_sec
  - add s3c2410_wdt driver
  - split driver patch
  - fixed watchdog_init_timeout handling of min_timeout and max_timeout
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

Fabio Porcedda (7):
  watchdog: core: dt: add support for the timeout-sec dt property
  watchdog: orion_wdt: add timeout-sec property binding
  watchdog: pnx4008: add timeout-sec property binding
  watchdog: s3c2410_wdt: add timeout-sec property binding
  watchdog: at91sam9_wdt: add timeout-sec property binding
  watchdog: orion_wdt: move the min_timeout initialization
  watchdog: WatchDog Timer Driver Core - fix comment

 .../devicetree/bindings/watchdog/atmel-wdt.txt     |  4 +++
 .../devicetree/bindings/watchdog/marvel.txt        |  5 +++
 .../devicetree/bindings/watchdog/pnx4008-wdt.txt   |  4 +++
 .../devicetree/bindings/watchdog/samsung-wdt.txt   |  3 ++
 Documentation/watchdog/watchdog-kernel-api.txt     | 10 ++++++
 drivers/watchdog/Kconfig                           |  1 +
 drivers/watchdog/at91sam9_wdt.c                    | 16 ++++++++--
 drivers/watchdog/orion_wdt.c                       | 10 +++---
 drivers/watchdog/pnx4008_wdt.c                     |  7 ++--
 drivers/watchdog/s3c2410_wdt.c                     |  6 ++--
 drivers/watchdog/watchdog_core.c                   | 37 ++++++++++++++++++++++
 include/linux/watchdog.h                           |  5 ++-
 12 files changed, 92 insertions(+), 16 deletions(-)

-- 
1.8.0

