Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58005 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756499AbbBGREX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 7 Feb 2015 12:04:23 -0500
Received: by mail-we0-f174.google.com with SMTP id k11so10386984wes.5
        for <linux-watchdog@vger.kernel.org>; Sat, 07 Feb 2015 09:04:22 -0800 (PST)
From: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Subject: [PATCH] watchdog: bcm47xx_wdt.c: allow enabling on BCM5301X arch
Date: Sat,  7 Feb 2015 18:04:10 +0100
Message-Id: <1423328650-2894-1-git-send-email-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

BCM5301X (ARCH_BCM_5301X) is a new Broadcom architecture using the same
SoC bus driver (bcma) as BCM47XX but based on ARM instead of MIPS.

Signed-off-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2aaef7b..ca6c949 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1113,7 +1113,7 @@ config ATH79_WDT
 
 config BCM47XX_WDT
 	tristate "Broadcom BCM47xx Watchdog Timer"
-	depends on BCM47XX
+	depends on BCM47XX || ARCH_BCM_5301X
 	select WATCHDOG_CORE
 	help
 	  Hardware driver for the Broadcom BCM47xx Watchdog Timer.
-- 
1.8.4.5

