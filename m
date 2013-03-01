Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:50477 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816Ab3CADHV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 28 Feb 2013 22:07:21 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] watchdog: Fix DA9055 dependency on watchdog core
Date: Thu, 28 Feb 2013 19:07:18 -0800
Message-Id: <1362107238-31342-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If DA9055_WATCHDOG is defined but WATCHDOG_CORE isn't, the following
build error is observed.

ERROR: "watchdog_register_device" [drivers/watchdog/da9055_wdt.ko] undefined!
ERROR: "watchdog_unregister_device" [drivers/watchdog/da9055_wdt.ko] undefined!

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 26e1fdb..8371063 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -79,6 +79,7 @@ config DA9052_WATCHDOG
 config DA9055_WATCHDOG
 	tristate "Dialog Semiconductor DA9055 Watchdog"
 	depends on MFD_DA9055
+	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog on the Dialog
 	  Semiconductor DA9055 PMIC.
-- 
1.7.9.7

