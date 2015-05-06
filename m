Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58905 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbEFLSE (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 May 2015 07:18:04 -0400
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	timo.kokkonen@offcode.fi, kernel@pengutronix.de
Subject: [PATCH] watchdog: imx2_wdt: also set wdog->timeout to new_timeout
Date: Wed,  6 May 2015 13:17:59 +0200
Message-Id: <1430911079-23738-1-git-send-email-m.grzeschik@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit faad5de0b104 ("watchdog: imx2_wdt: convert to watchdog core api")
removes the custom ioctl function. The generic ioctl handler is not
setting the wdog->timeout to the new_timeout but handing this preset
value back to the userspace. This patch sets the new value in the
drivers set_timeout function to fix that problem.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/watchdog/imx2_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5e6d808..7cee402 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -166,6 +166,8 @@ static int imx2_wdt_set_timeout(struct watchdog_device *wdog,
 {
 	struct imx2_wdt_device *wdev = watchdog_get_drvdata(wdog);
 
+	wdog->timeout = new_timeout;
+
 	regmap_update_bits(wdev->regmap, IMX2_WDT_WCR, IMX2_WDT_WCR_WT,
 			   WDOG_SEC_TO_COUNT(new_timeout));
 	return 0;
-- 
2.1.4

