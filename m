Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.sigma-star.at ([95.130.255.111]:14385 "EHLO
	mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbbEDTBc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 May 2015 15:01:32 -0400
From: Richard Weinberger <richard@nod.at>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH] watchdog: cadence: Add dependency on HAS_IOMEM
Date: Mon,  4 May 2015 21:01:25 +0200
Message-Id: <1430766085-500-1-git-send-email-richard@nod.at>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Not all architectures have io memory.

Fixes:
drivers/built-in.o: In function `cdns_wdt_probe':
cadence_wdt.c:(.text+0x33b7c9): undefined reference to `devm_ioremap_resource'

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e5e7c55..2634948 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -169,6 +169,7 @@ config AT91SAM9X_WATCHDOG
 
 config CADENCE_WATCHDOG
 	tristate "Cadence Watchdog Timer"
+	depends on HAS_IOMEM
 	select WATCHDOG_CORE
 	help
 	  Say Y here if you want to include support for the watchdog
-- 
1.8.4.5

