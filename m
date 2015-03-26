Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:36876 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbbCZOeU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 26 Mar 2015 10:34:20 -0400
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: linux-kernel@lists.codethink.co.uk
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, Andrew Victor <linux@maxim.org.za>,
	Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Subject: [PATCH] watchdog: at91sam9: use endian agnostic IO
Date: Thu, 26 Mar 2015 14:34:14 +0000
Message-Id: <1427380454-2002-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use endian agnostic IO functions for the watchdog driver for when it
is enabled on ATSAMA5D36 devices running in big endian.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
CC: Boris Brezillon <boris.brezillon@free-electrons.com>
CC: Guenter Roeck <linux@roeck-us.net>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org
CC: Andrew Victor <linux@maxim.org.za>
CC: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/watchdog/at91sam9_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 1443b3c..e4698f7 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -40,9 +40,9 @@
 #define DRV_NAME "AT91SAM9 Watchdog"
 
 #define wdt_read(wdt, field) \
-	__raw_readl((wdt)->base + (field))
+	readl_relaxed((wdt)->base + (field))
 #define wdt_write(wtd, field, val) \
-	__raw_writel((val), (wdt)->base + (field))
+	writel_relaxed((val), (wdt)->base + (field))
 
 /* AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
  * use this to convert a watchdog
-- 
2.1.4

