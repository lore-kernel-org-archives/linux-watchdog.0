Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:49030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdB1TLN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Feb 2017 14:11:13 -0500
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] watchdog/wm831x: fix build when COMPILE_TEST is enabled
To: linux-watchdog@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        patches@opensource.wolfsonmicro.com
Message-ID: <8bb4874f-7d0e-225f-3a97-842c2d171c78@infradead.org>
Date: Tue, 28 Feb 2017 10:31:15 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig dependencies when COMPILE_TEST is enabled so that
interdependent module dependencies are configured as needed.

Fixes build when WM831X_WATCHDOG=m and COMPILE_TEST=y.
No other WM831X drivers are enabled.
The problem is in mixing tristate and boolean dependencies.

ERROR: "wm831x_reg_write" [drivers/watchdog/wm831x_wdt.ko] undefined!
ERROR: "wm831x_reg_read" [drivers/watchdog/wm831x_wdt.ko] undefined!
ERROR: "wm831x_reg_unlock" [drivers/watchdog/wm831x_wdt.ko] undefined!
ERROR: "wm831x_reg_lock" [drivers/watchdog/wm831x_wdt.ko] undefined!
ERROR: "wm831x_set_bits" [drivers/watchdog/wm831x_wdt.ko] undefined!

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	patches@opensource.wolfsonmicro.com
Cc:	Mark Brown <broonie@kernel.org>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20170228.orig/drivers/watchdog/Kconfig
+++ linux-next-20170228/drivers/watchdog/Kconfig
@@ -176,7 +176,7 @@ config WDAT_WDT
 
 config WM831X_WATCHDOG
 	tristate "WM831x watchdog"
-	depends on MFD_WM831X || COMPILE_TEST
+	depends on MFD_WM831X || (MFD_WM831X=y && COMPILE_TEST)
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog in the WM831x AudioPlus PMICs.  When
