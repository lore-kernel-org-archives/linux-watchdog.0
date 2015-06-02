Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:63871 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbbFBMqZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 2 Jun 2015 08:46:25 -0400
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>
CC: <linux-watchdog@vger.kernel.org>
Subject: [PATCH] watchdog: imx2_wdt: set watchdog parent device
Date: Tue, 2 Jun 2015 15:46:18 +0300
Message-ID: <1433249178-30779-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If on watchdog device registration a parent device is not set, then
the registered watchdog is considered to be a virtual device:

  /sys/devices/virtual/watchdog/watchdog0
  /sys/devices/virtual/watchdog/watchdog1

Setting a correct reference to a platform device allows to
distinguish multiple instances of iMX2+ hardware watchdogs:

  /sys/devices/soc0/soc/2000000.aips-bus/20bc000.wdog/watchdog/watchdog0
  /sys/devices/soc0/soc/2000000.aips-bus/20c0000.wdog/watchdog/watchdog1

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/watchdog/imx2_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 5e6d808..3450a46 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -256,6 +256,7 @@ static int __init imx2_wdt_probe(struct platform_device *pdev)
 	wdog->ops		= &imx2_wdt_ops;
 	wdog->min_timeout	= 1;
 	wdog->max_timeout	= IMX2_WDT_MAX_TIME;
+	wdog->parent		= &pdev->dev;
 
 	clk_prepare_enable(wdev->clk);
 
-- 
2.1.4

