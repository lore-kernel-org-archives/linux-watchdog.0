Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from www.linux-watchdog.org ([185.87.125.42]:54874 "EHLO
        www.linux-watchdog.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752690AbeBSQVP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Feb 2018 11:21:15 -0500
Date: Mon, 19 Feb 2018 17:04:33 +0100
From: Wim Van Sebroeck <wim@linux-watchdog.org>
To: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: sp5100_tco.c: fix potential build failure
Message-ID: <20180219160433.GA25309@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

isp5100_tco.c  uses watchdog core functions (from watchdog_core.c) and, when
compiled without CONFIG_WATCHDOG_CORE being set, it produces the
following build error:

ERROR: "devm_watchdog_register_device" [drivers/watchdog/sp5100_tco.ko] undefined!
ERROR: "watchdog_init_timeout" [drivers/watchdog/sp5100_tco.ko] undefined!

Fix this by selecting CONFIG_WATCHDOG_CORE.

Fixes: 7cd9d5fff792 ("watchdog: sp5100_tco: Convert to use watchdog subsystem")
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 3d984cd..37460cd 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -904,6 +904,7 @@ config F71808E_WDT
 config SP5100_TCO
        tristate "AMD/ATI SP5100 TCO Timer/Watchdog"
        depends on X86 && PCI
+       select WATCHDOG_CORE
        ---help---
          Hardware watchdog driver for the AMD/ATI SP5100 chipset. The TCO
          (Total Cost of Ownership) timer is a watchdog timer that will reboot
