Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:41432 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751230Ab3L3HMU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Dec 2013 02:12:20 -0500
From: Baruch Siach <baruch@tkos.co.il>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
	Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] watchdog: dw_wdt: remove build dependencies
Date: Mon, 30 Dec 2013 09:10:30 +0200
Message-Id: <230543f28a66b7bf4c4ebb63e4ac2a3000299ce4.1388387430.git.baruch@tkos.co.il>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There is nothing ARM specific in this driver. Also, clk.h now includes stubs
for !CONFIG_HAVE_CLK, so the driver should build anyway.

Cc: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/watchdog/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5be6e91..5ffac39 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -214,7 +214,6 @@ config SA1100_WATCHDOG
 
 config DW_WATCHDOG
 	tristate "Synopsys DesignWare watchdog"
-	depends on ARM && HAVE_CLK
 	help
 	  Say Y here if to include support for the Synopsys DesignWare
 	  watchdog timer found in many ARM chips.
-- 
1.8.5.2

