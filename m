Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41461 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483AbbIYIKu (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 25 Sep 2015 04:10:50 -0400
Date: Fri, 25 Sep 2015 10:10:45 +0200
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Linux I2C <linux-i2c@vger.kernel.org>,
	Jim Davis <jim.epost@gmail.com>,
	Matt Fleming <matt.fleming@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lee Jones <lee.jones@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: iTCO_wdt: Fix unmet dependency in select
Message-ID: <20150925101045.06062b59@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

ITCO_WDT selects I2C_I801 but does not select its dependencies (I2C.)
This can result in link-time failures:

drivers/built-in.o: In function `i801_remove':
i2c-i801.c:(.text+0x1a6126): undefined reference to `i2c_del_adapter'
drivers/built-in.o: In function `dmi_check_onboard_devices':
i2c-i801.c:(.text+0x1a7531): undefined reference to `i2c_new_device'
drivers/built-in.o: In function `i801_probe':
i2c-i801.c:(.text+0x1a7aa8): undefined reference to `i2c_add_adapter'
i2c-i801.c:(.text+0x1a7e14): undefined reference to `i2c_new_device'

So we must select I2C as well.

Reported-by: Jim Davis <jim.epost@gmail.com>
Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: 2a7a0e9bf7 ("watchdog: iTCO_wdt: Add support for TCO on Intel Sunrisepoint")
Cc: Matt Fleming <matt.fleming@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.3-rc2.orig/drivers/watchdog/Kconfig	2015-09-24 11:43:29.959432358 +0200
+++ linux-4.3-rc2/drivers/watchdog/Kconfig	2015-09-25 09:56:20.518840112 +0200
@@ -818,6 +818,7 @@ config ITCO_WDT
 	depends on (X86 || IA64) && PCI
 	select WATCHDOG_CORE
 	select LPC_ICH if !EXPERT
+	select I2C if !EXPERT
 	select I2C_I801 if !EXPERT
 	---help---
 	  Hardware driver for the intel TCO timer based watchdog devices.


-- 
Jean Delvare
SUSE L3 Support
