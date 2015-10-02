Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36795 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbbJBDZm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 1 Oct 2015 23:25:42 -0400
Received: by ykdt18 with SMTP id t18so99672274ykd.3
        for <linux-watchdog@vger.kernel.org>; Thu, 01 Oct 2015 20:25:41 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] watchdog: imx2_wdt: Use register definition in regmap_write()
Date: Fri,  2 Oct 2015 00:25:28 -0300
Message-Id: <1443756328-11680-1-git-send-email-festevam@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

In order to improve readability it is better to pass the register name
definition rather than to pass its hardcoded offset.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/watchdog/imx2_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 0bb1a1d..29ef719 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -91,7 +91,7 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
 						    struct imx2_wdt_device,
 						    restart_handler);
 	/* Assert SRS signal */
-	regmap_write(wdev->regmap, 0, wcr_enable);
+	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
 	/*
 	 * Due to imx6q errata ERR004346 (WDOG: WDOG SRS bit requires to be
 	 * written twice), we add another two writes to ensure there must be at
@@ -99,8 +99,8 @@ static int imx2_restart_handler(struct notifier_block *this, unsigned long mode,
 	 * the target check here, since the writes shouldn't be a huge burden
 	 * for other platforms.
 	 */
-	regmap_write(wdev->regmap, 0, wcr_enable);
-	regmap_write(wdev->regmap, 0, wcr_enable);
+	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
+	regmap_write(wdev->regmap, IMX2_WDT_WCR, wcr_enable);
 
 	/* wait for reset to assert... */
 	mdelay(500);
-- 
1.9.1

