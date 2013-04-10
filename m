Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:53696 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935862Ab3DJMgZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 10 Apr 2013 08:36:25 -0400
From: Nicolas Ferre <nicolas.ferre@atmel.com>
To: <wim@iguana.be>, <manabian@gmail.com>
CC: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	<devicetree-discuss@lists.ozlabs.org>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] watchdog: Revert the AT91RM9200_WATCHDOG dependency
Date: Wed, 10 Apr 2013 14:36:22 +0200
Message-ID: <1365597382-15455-1-git-send-email-nicolas.ferre@atmel.com>
In-Reply-To: <20130409202711.GG7867@spo001.leaseweb.com>
References: <20130409202711.GG7867@spo001.leaseweb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Compiling the at91rm9200_wdt.c driver without at91rm9200
support was leading to several errors:

drivers/built-in.o: In function `at91_wdt_close':
at91_adc.c:(.text+0xc9fe4): undefined reference to `at91_st_base'
drivers/built-in.o: In function `at91_wdt_write':
at91_adc.c:(.text+0xca004): undefined reference to `at91_st_base'
drivers/built-in.o: In function `at91wdt_shutdown':
at91_adc.c:(.text+0xca01c): undefined reference to `at91_st_base'
drivers/built-in.o: In function `at91wdt_suspend':
at91_adc.c:(.text+0xca038): undefined reference to `at91_st_base'
drivers/built-in.o: In function `at91_wdt_open':
at91_adc.c:(.text+0xca0cc): undefined reference to `at91_st_base'
drivers/built-in.o:at91_adc.c:(.text+0xca2c8): more undefined references to
`at91_st_base' follow

So, reverting the modification of the "depends" Kconfig line
introduced by patch a6a1bcd37 (watchdog: at91rm9200: add DT support)
seems to be the good solution.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9fcc70c..e89fc31 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -117,7 +117,7 @@ config ARM_SP805_WATCHDOG
 
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
-	depends on ARCH_AT91
+	depends on ARCH_AT91RM9200
 	help
 	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
 	  system when the timeout is reached.
-- 
1.8.0

