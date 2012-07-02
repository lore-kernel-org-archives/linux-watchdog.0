Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:60986 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab2GBVdM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 2 Jul 2012 17:33:12 -0400
Received: by ghrr11 with SMTP id r11so4612715ghr.19
        for <linux-watchdog@vger.kernel.org>; Mon, 02 Jul 2012 14:33:11 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: shawn.guo@linaro.org, kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] watchdog: imx2_wdt: Select the driver via ARCH_MXC
Date: Mon,  2 Jul 2012 18:33:02 -0300
Message-Id: <1341264782-19098-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

With device tree support in place, we should not use IMX_HAVE_PLATFORM_IMX2_WDT
as a dependency for selecting the imx2_wdt driver.

Use ARCH_MXC symbol instead, so that the driver can be even selected by a device-tree
only SoC, such as i.MX6. 

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/watchdog/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 277ecbc..f821f2f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -341,7 +341,7 @@ config MAX63XX_WATCHDOG
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
-	depends on IMX_HAVE_PLATFORM_IMX2_WDT
+	depends on ARCH_MXC
 	help
 	  This is the driver for the hardware watchdog
 	  on the Freescale IMX2 and later processors.
-- 
1.7.1

