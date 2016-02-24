Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50051 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756923AbcBXPR3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Feb 2016 10:17:29 -0500
Date: Wed, 24 Feb 2016 16:17:26 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Justin Chen <justinpopo6@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH v2] watchdog: Add hardware dependency to BCM7038 driver
Message-ID: <20160224161726.4888edd4@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The BCM7038 watchdog driver is specific to Broadcom ARM and MIPS
SoCs so do not present it on other architectures, unless
build-testing.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Justin Chen <justinpopo6@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
Changes since v1:
 * Better dependencies, suggested by Justin, and updated the
   description accordingly.
 * Better option description, provided by Justin.

 drivers/watchdog/Kconfig |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-4.5-rc5.orig/drivers/watchdog/Kconfig	2016-02-24 14:43:18.943460233 +0100
+++ linux-4.5-rc5/drivers/watchdog/Kconfig	2016-02-24 15:42:49.756057691 +0100
@@ -1377,10 +1377,12 @@ config BCM7038_WDT
 	tristate "BCM7038 Watchdog"
 	select WATCHDOG_CORE
 	depends on HAS_IOMEM
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	help
-	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
-
-	 Say 'Y or 'M' here to enable the driver.
+	 Watchdog driver for the built-in hardware in Broadcom 7038 and
+	 later SoCs used in set-top boxes.  BCM7038 was made public
+	 during the 2004 CES, and since then, many Broadcom chips use this
+	 watchdog block, including some cable modem chips.
 
 config IMGPDC_WDT
 	tristate "Imagination Technologies PDC Watchdog Timer"

-- 
Jean Delvare
SUSE L3 Support
