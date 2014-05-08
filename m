Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:62200 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754148AbaEHO5H (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 8 May 2014 10:57:07 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: iop_wdt only builds for mach-iop13xx
Date: Thu,  8 May 2014 16:56:19 +0200
Message-Id: <1399560990-1402858-8-git-send-email-arnd@arndb.de>
In-Reply-To: <1399560990-1402858-1-git-send-email-arnd@arndb.de>
References: <1399560433-1402630-1-git-send-email-arnd@arndb.de>
 <1399560990-1402858-1-git-send-email-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

All three iop variants we support in Linux (iop32x, iop33x and
iop13xx) seem to have support for the watchdog hardware, but this
driver fails to build for the first two of these because it
uses the IOP13XX_WDTCR_IB_RESET macro that is only defined for
iop13xx.

This clarifies the dependency in Kconfig to avoid randconfig
build errors. It is unlikely that anyone will ever miss support
for this driver on the ancient iop3xx platforms, so we don't
need to bother trying to fix it properly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2b4c1fc..e244548 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -272,7 +272,7 @@ config PNX4008_WATCHDOG
 
 config IOP_WATCHDOG
 	tristate "IOP Watchdog"
-	depends on PLAT_IOP
+	depends on ARCH_IOP13XX
 	select WATCHDOG_NOWAYOUT if (ARCH_IOP32X || ARCH_IOP33X)
 	help
 	  Say Y here if to include support for the watchdog timer
-- 
1.8.3.2

