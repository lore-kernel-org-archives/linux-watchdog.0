Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp2.macau.ctm.net ([202.175.3.60]:48232 "EHLO
	smtp2.macau.ctm.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832AbaCELRj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 5 Mar 2014 06:17:39 -0500
From: Markus Mayer <markus.mayer@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linux Watchdog List <linux-watchdog@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Markus Mayer <markus.mayer@linaro.org>
Subject: [PATCH] watchdog: bcm281xx: Fix Kconfig dependency
Date: Wed,  5 Mar 2014 18:57:41 +0800
Message-Id: <1394017061-5481-1-git-send-email-markus.mayer@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use more the applicable ARCH_BCM_MOBILE option instead of ARCH_BCM as
dependency for bcm_kona_wdt.c.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79d2589..47a6f10 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1160,7 +1160,7 @@ config BCM2835_WDT
 
 config BCM_KONA_WDT
 	tristate "BCM Kona Watchdog"
-	depends on ARCH_BCM
+	depends on ARCH_BCM_MOBILE
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog timer on the following Broadcom BCM281xx
-- 
1.9.0

