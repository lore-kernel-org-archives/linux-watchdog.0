Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:47351 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167AbbIKN2P (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 11 Sep 2015 09:28:15 -0400
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Matt Fleming <matt.fleming@intel.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] watchdog: iTCO: Fix dependencies on I2C
Date: Fri, 11 Sep 2015 06:28:08 -0700
Message-Id: <1441978088-27288-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If I2C is built as module, the iTCO watchdog driver must be built as module
as well. I2C_I801 must only be selected if I2C is configured.

This fixes the following build errors, seen if I2C=m and ITCO_WDT=y.

i2c-i801.c:(.text+0x2bf055): undefined reference to `i2c_del_adapter'
i2c-i801.c:(.text+0x2c13e0): undefined reference to `i2c_add_adapter'
i2c-i801.c:(.text+0x2c17bd): undefined reference to `i2c_new_device'

Fixes: 2a7a0e9bf7b3 ("watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint")
Cc: Matt Fleming <matt.fleming@intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 55c4b5b0a317..75c358ce71a7 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -797,8 +797,9 @@ config ITCO_WDT
 	tristate "Intel TCO Timer/Watchdog"
 	depends on (X86 || IA64) && PCI
 	select WATCHDOG_CORE
+	depends on I2C || I2C=n
 	select LPC_ICH if !EXPERT
-	select I2C_I801 if !EXPERT
+	select I2C_I801 if !EXPERT && I2C
 	---help---
 	  Hardware driver for the intel TCO timer based watchdog devices.
 	  These drivers are included in the Intel 82801 I/O Controller
-- 
2.1.4

