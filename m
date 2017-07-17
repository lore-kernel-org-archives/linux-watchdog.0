Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33833 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751304AbdGQPNr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Jul 2017 11:13:47 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/5] watchdog: renesas_wdt: check rate also for upper limit
Date: Mon, 17 Jul 2017 17:12:27 +0200
Message-Id: <20170717151230.12680-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
References: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When checking the clock rate, ensure also that counting all 16 bits
takes at least one second to match the granularity of the framework.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 4f8a3563b6aa53..0b9e8a9b1dd14c 100644
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

