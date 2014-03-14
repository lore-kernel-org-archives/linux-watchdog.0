Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33849 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481AbaCNPHb (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 11:07:31 -0400
Date: Fri, 14 Mar 2014 16:07:28 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Zwane Mwaikambo <zwanem@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: Fix SC1200 dependencies
Message-ID: <20140314160728.5abc3f4b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The SC1200 is a SoC based on the Geode GX1 32-bit x86 processor, so
its drivers are only needed on this architecture.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Zwane Mwaikambo <zwanem@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc6.orig/drivers/watchdog/Kconfig	2014-02-13 11:25:23.232295332 +0100
+++ linux-3.14-rc6/drivers/watchdog/Kconfig	2014-03-14 15:52:03.391930463 +0100
@@ -736,7 +736,7 @@ config HPWDT_NMI_DECODING
 
 config SC1200_WDT
 	tristate "National Semiconductor PC87307/PC97307 (ala SC1200) Watchdog"
-	depends on X86
+	depends on X86_32
 	help
 	  This is a driver for National Semiconductor PC87307/PC97307 hardware
 	  watchdog cards as found on the SC1200. This watchdog is mainly used


-- 
Jean Delvare
SUSE L3 Support
