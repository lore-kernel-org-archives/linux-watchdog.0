Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:65501 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbdCAJep (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 1 Mar 2017 04:34:45 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/3] watchdog: db8500: add back prmcu dependency
Date: Wed,  1 Mar 2017 10:15:30 +0100
Message-Id: <20170301091531.522161-3-arnd@arndb.de>
In-Reply-To: <20170301091531.522161-1-arnd@arndb.de>
References: <20170301091531.522161-1-arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When the db8500 watchdog is enabled without the PRCMU, we get a lot of
warnings about duplicate or missing helper functions:

In file included from drivers/watchdog/ux500_wdt.c:21:0:
include/linux/mfd/dbx500-prcmu.h:422:19: error: redefinition of 'prcmu_abb_read'
 static inline int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size)

This restores the dependency as it was.

Fixes: da2a68b3eb47 ("watchdog: Enable COMPILE_TEST where possible")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 47dbacf3bfb4..a199e8536ce4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -574,7 +574,7 @@ config IMX2_WDT
 
 config UX500_WATCHDOG
 	tristate "ST-Ericsson Ux500 watchdog"
-	depends on MFD_DB8500_PRCMU || (ARM && COMPILE_TEST)
+	depends on MFD_DB8500_PRCMU
 	select WATCHDOG_CORE
 	default y
 	help
-- 
2.9.0

