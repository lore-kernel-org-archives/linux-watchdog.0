Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37768 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755904AbaCNTZb (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 15:25:31 -0400
Date: Fri, 14 Mar 2014 20:25:29 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: Fix Elan SC520 dependencies
Message-ID: <20140314202529.573208f5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Anyone using a system based on an AMD Elan SC520 processor would be
building a dedicated kernel for it, so we can make the sc520_wdt
driver depend on MELAN. SC520_CPUFREQ already depends on MELAN so it
makes things more consistent. It also makes kernel configuration for
every other x86 user easier.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc6.orig/drivers/watchdog/Kconfig	2014-03-14 15:52:03.391930463 +0100
+++ linux-3.14-rc6/drivers/watchdog/Kconfig	2014-03-14 19:15:16.797860536 +0100
@@ -533,7 +533,7 @@ config GEODE_WDT
 
 config SC520_WDT
 	tristate "AMD Elan SC520 processor Watchdog"
-	depends on X86
+	depends on MELAN
 	help
 	  This is the driver for the hardware watchdog built in to the
 	  AMD "Elan" SC520 microcomputer commonly used in embedded systems.


-- 
Jean Delvare
SUSE L3 Support
