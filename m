Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46524 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479AbcBVLLf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 06:11:35 -0500
Date: Mon, 22 Feb 2016 12:11:32 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Justin Chen <justinpopo6@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: Add hardware dependency to BCM7038 driver
Message-ID: <20160222121132.665b1f77@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The BCM7038 is a MIPS chip so do not present its driver on other
architectures, unless build-testing.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Justin Chen <justinpopo6@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-4.5-rc5.orig/drivers/watchdog/Kconfig	2016-02-21 13:44:07.845576963 +0100
+++ linux-4.5-rc5/drivers/watchdog/Kconfig	2016-02-22 12:07:20.865871451 +0100
@@ -1377,6 +1377,7 @@ config BCM7038_WDT
 	tristate "BCM7038 Watchdog"
 	select WATCHDOG_CORE
 	depends on HAS_IOMEM
+	depends on MIPS || COMPILE_TEST
 	help
 	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
 


-- 
Jean Delvare
SUSE L3 Support
