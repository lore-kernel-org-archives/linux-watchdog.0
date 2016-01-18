Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:14831 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270AbcARTvA (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 18 Jan 2016 14:51:00 -0500
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Mans Rullgard <mans@mansr.com>, linux-watchdog@vger.kernel.org
From: Mason <slash.tmp@free.fr>
Subject: [PATCH] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
Message-ID: <569D421C.30504@free.fr>
Date: Mon, 18 Jan 2016 20:50:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Requested by arm-soc maintainer Kevin Hilman in v9 review.
http://article.gmane.org/gmane.linux.ports.arm.kernel/456331

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
Can this fix be pushed into 4.5 ?

(The 'x' in tangox is a wild-card; tango3 is legacy,
tango4 is current, tango5 is next.)
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4f0e7be0da34..e723e0169f88 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -145,7 +145,7 @@ config MENF21BMC_WATCHDOG
 config TANGOX_WATCHDOG
 	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
 	select WATCHDOG_CORE
-	depends on ARCH_TANGOX || COMPILE_TEST
+	depends on ARCH_TANGO || COMPILE_TEST
 	help
 	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
 	  and SMP87xx (tango4) family chips.

