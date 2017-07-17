Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33830 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbdGQPNq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Jul 2017 11:13:46 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/5] watchdog: renesas_wdt: avoid (theoretical) type overflow
Date: Mon, 17 Jul 2017 17:12:26 +0200
Message-Id: <20170717151230.12680-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
References: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Because the smallest clock divider we can select is 1, 'clks_per_sec'
must be the same type as 'rate'.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index cf61c92f7ecd63..4f8a3563b6aa53 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -112,8 +112,7 @@ static int rwdt_probe(struct platform_device *pdev)
 {
 	struct rwdt_priv *priv;
 	struct resource *res;
-	unsigned long rate;
-	unsigned int clks_per_sec;
+	unsigned long rate, clks_per_sec;
 	int ret, i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-- 
2.11.0

