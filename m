Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54813 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbeINP1r (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 14 Sep 2018 11:27:47 -0400
From: Romain Izard <romain.izard.pro@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Romain Izard <romain.izard.pro@gmail.com>
Subject: [PATCH 1/2] watchdog: sama5d4: fix timeout-sec usage
Date: Fri, 14 Sep 2018 12:13:38 +0200
Message-Id: <20180914101339.7382-2-romain.izard.pro@gmail.com>
In-Reply-To: <20180914101339.7382-1-romain.izard.pro@gmail.com>
References: <20180914101339.7382-1-romain.izard.pro@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When using watchdog_init_timeout to update the default timeout value,
an error means that there is no "timeout-sec" in the relevant device
tree node.

This should not prevent binding of the driver to the device.

Fixes: 976932e40036 ("watchdog: sama5d4: make use of timeout-secs provided in devicetree")
Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
---
 drivers/watchdog/sama5d4_wdt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 255169916dbb..1e93c1b0e3cf 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -247,11 +247,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to set timeout value\n");
-		return ret;
-	}
+	watchdog_init_timeout(wdd, wdt_timeout, &pdev->dev);
 
 	timeout = WDT_SEC2TICKS(wdd->timeout);
 
-- 
2.17.1
