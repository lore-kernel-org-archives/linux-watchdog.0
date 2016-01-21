Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp4-g21.free.fr ([212.27.42.4]:49678 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759175AbcAUO1S (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 21 Jan 2016 09:27:18 -0500
From: Mason <slash.tmp@free.fr>
Subject: [PATCH v2] watchdog: tango: rename ARCH_TANGOX to ARCH_TANGO
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Mans Rullgard <mans@mansr.com>, linux-watchdog@vger.kernel.org
Message-ID: <56A0EABB.3090901@free.fr>
Date: Thu, 21 Jan 2016 15:27:07 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

This change was requested by arm-soc maintainer Kevin Hilman
because the X in TANGOX is a wildcard.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
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

