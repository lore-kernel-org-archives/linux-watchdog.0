Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from anholt.net ([50.246.234.109]:37026 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033304AbdD1BCf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 27 Apr 2017 21:02:35 -0400
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>
Subject: [PATCH] watchdog: bcm281xx: Fix use of uninitialized spinlock.
Date: Thu, 27 Apr 2017 18:02:32 -0700
Message-Id: <20170428010232.19905-1-eric@anholt.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The bcm_kona_wdt_set_resolution_reg() call takes the spinlock, so
initialize it earlier.  Fixes a warning at boot with lock debugging
enabled.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/watchdog/bcm_kona_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index 6fce17d5b9f1..a5775dfd8d5f 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -304,6 +304,8 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 	if (!wdt)
 		return -ENOMEM;
 
+	spin_lock_init(&wdt->lock);
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(wdt->base))
@@ -316,7 +318,6 @@ static int bcm_kona_wdt_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	spin_lock_init(&wdt->lock);
 	platform_set_drvdata(pdev, wdt);
 	watchdog_set_drvdata(&bcm_kona_wdt_wdd, wdt);
 	bcm_kona_wdt_wdd.parent = &pdev->dev;
-- 
2.11.0

