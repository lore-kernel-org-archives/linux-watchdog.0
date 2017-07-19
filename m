Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39770 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752847AbdGSI2F (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Jul 2017 04:28:05 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/5] watchdog: renesas_wdt: avoid (theoretical) type overflow
Date: Wed, 19 Jul 2017 10:27:51 +0200
Message-Id: <20170719082755.21733-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170719082755.21733-1-wsa+renesas@sang-engineering.com>
References: <20170719082755.21733-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Because the smallest clock divider we can select is 1, 'clks_per_sec'
must be the same type as 'rate'.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Changes since V1:

* use proper type also in the private struct

 drivers/watchdog/renesas_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index cf61c92f7ecd63..22b0348826deb1 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -37,7 +37,7 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	struct clk *clk;
-	unsigned int clks_per_sec;
+	unsigned long clks_per_sec;
 	u8 cks;
 };
 
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

