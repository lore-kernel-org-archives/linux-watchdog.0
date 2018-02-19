Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52841 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751884AbeBSBBL (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 18 Feb 2018 20:01:11 -0500
Received: by mail-wm0-f67.google.com with SMTP id t3so12196758wmc.2
        for <linux-watchdog@vger.kernel.org>; Sun, 18 Feb 2018 17:01:10 -0800 (PST)
From: Matteo Croce <mcroce@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Radu Rendec <rrendec@arista.com>
Subject: [PATCH] i6300esb: fix build failure
Date: Mon, 19 Feb 2018 02:01:05 +0100
Message-Id: <20180219010105.25037-1-mcroce@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

i6300esb uses fuctions defined in watchdog_core.c, and when
CONFIG_WATCHDOG_CORE is not set we have this build error:

drivers/watchdog/i6300esb.o: In function `esb_remove':
i6300esb.c:(.text+0xcc): undefined reference to `watchdog_unregister_device'
drivers/watchdog/i6300esb.o: In function `esb_probe':
i6300esb.c:(.text+0x2a1): undefined reference to `watchdog_init_timeout'
i6300esb.c:(.text+0x388): undefined reference to `watchdog_register_device'
make: *** [Makefile:1029: vmlinux] Error 1

Fix this by selecting CONFIG_WATCHDOG_CORE when I6300ESB_WDT is set.

Fixes: 7af4ac8772a8f ("watchdog: i6300esb: use the watchdog subsystem")
Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index aff773bcebdb..5e2fa5abe5ff 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1008,6 +1008,7 @@ config WAFER_WDT
 config I6300ESB_WDT
 	tristate "Intel 6300ESB Timer/Watchdog"
 	depends on PCI
+	select WATCHDOG_CORE
 	---help---
 	  Hardware driver for the watchdog timer built into the Intel
 	  6300ESB controller hub.
-- 
2.14.3

