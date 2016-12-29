Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57612 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752895AbcL2Rjm (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 29 Dec 2016 12:39:42 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] watchdog: pnx833x_wdt: Mark as broken
Date: Thu, 29 Dec 2016 09:39:35 -0800
Message-Id: <1483033175-19563-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1483033175-19563-1-git-send-email-linux@roeck-us.net>
References: <1483033175-19563-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

pnx833x_wdt does not compile if enabled. Bit operations expect an unsigned
long as argument. If that is fixed, the build still fails because put_user,
get_user, and copy_to_user are undefined.

Mark it as broken.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index d49ac4c509dc..fcea8a3e1267 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1401,6 +1401,7 @@ config WDT_MTX1
 config PNX833X_WDT
 	tristate "PNX833x Hardware Watchdog"
 	depends on SOC_PNX8335
+	depends on BROKEN
 	help
 	  Hardware driver for the PNX833x's watchdog. This is a
 	  watchdog timer that will reboot the machine after a programmable
-- 
2.7.4

