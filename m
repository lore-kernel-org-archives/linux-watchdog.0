Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39777 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752858AbdGSI2G (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Jul 2017 04:28:06 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 2/5] watchdog: renesas_wdt: check rate also for upper limit
Date: Wed, 19 Jul 2017 10:27:52 +0200
Message-Id: <20170719082755.21733-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170719082755.21733-1-wsa+renesas@sang-engineering.com>
References: <20170719082755.21733-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When checking the clock rate, ensure also that counting all 16 bits
takes at least one second to match the granularity of the framework.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 22b0348826deb1..8437dd52153208 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -134,14 +134,14 @@ static int rwdt_probe(struct platform_device *pdev)
 
 	for (i = ARRAY_SIZE(clk_divs) - 1; i >= 0; i--) {
 		clks_per_sec = DIV_ROUND_UP(rate, clk_divs[i]);
-		if (clks_per_sec) {
+		if (clks_per_sec && clks_per_sec < 65536) {
 			priv->clks_per_sec = clks_per_sec;
 			priv->cks = i;
 			break;
 		}
 	}
 
-	if (!clks_per_sec) {
+	if (i < 0) {
 		dev_err(&pdev->dev, "Can't find suitable clock divider\n");
 		return -ERANGE;
 	}
-- 
2.11.0

