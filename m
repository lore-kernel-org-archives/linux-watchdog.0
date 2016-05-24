Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36563 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbcEXAb1 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 20:31:27 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	sfr@canb.auug.org.au, linux@roeck-us.net,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH v4 4/4] watchdog: ebc-c384_wdt: Allow build for X86_64
Date: Mon, 23 May 2016 20:31:19 -0400
Message-Id: <5f866ba9a06692b5a1360b116e2651c3b1596a79.1464049539.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1464049539.git.vilhelm.gray@gmail.com>
References: <cover.1464049539.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

With the introduction of the ISA_BUS_API Kconfig option, ISA-style
drivers may be built for X86_64 architectures. This patch changes the
ISA Kconfig option dependency of the WinSystems EBC-C384 watchdog timer
driver to ISA_BUS_API, thus allowing it to build for X86_64 as it is
expected to.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b54f26c..3938e2d 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -746,7 +746,7 @@ config ALIM7101_WDT
 
 config EBC_C384_WDT
 	tristate "WinSystems EBC-C384 Watchdog Timer"
-	depends on X86 && ISA
+	depends on ISA_BUS_API
 	select WATCHDOG_CORE
 	help
 	  Enables watchdog timer support for the watchdog timer on the
-- 
2.7.3

