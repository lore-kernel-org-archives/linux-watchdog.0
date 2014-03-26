Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:46685 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751580AbaCZPAE (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 26 Mar 2014 11:00:04 -0400
Date: Wed, 26 Mar 2014 16:00:01 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: Fix SBC8360 dependencies
Message-ID: <20140326160001.44271284@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

According to its Kconfig help text, the sbc8360 watchdog driver is
only used on the Axiomtek SBC8360 single-board computer. This piece of
hardware is 32-bit x86 so the driver is useless beyond X86_32.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc7.orig/drivers/watchdog/Kconfig	2014-03-25 08:29:55.136283300 +0100
+++ linux-3.14-rc7/drivers/watchdog/Kconfig	2014-03-26 15:56:35.549231692 +0100
@@ -815,7 +815,7 @@ config 60XX_WDT
 
 config SBC8360_WDT
 	tristate "SBC8360 Watchdog Timer"
-	depends on X86
+	depends on X86_32
 	---help---
 
 	  This is the driver for the hardware watchdog on the SBC8360 Single


-- 
Jean Delvare
SUSE L3 Support
