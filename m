Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:33839 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751303AbdGQPNq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Jul 2017 11:13:46 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 3/5] watchdog: renesas_wdt: don't round closest with get_timeleft
Date: Mon, 17 Jul 2017 17:12:28 +0200
Message-Id: <20170717151230.12680-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
References: <20170717151230.12680-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We should never return more time left than there actually is. So, switch
to a plain divider instead of DIV_ROUND_CLOSEST.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 0b9e8a9b1dd14c..d2390695d3453f 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -92,7 +92,7 @@ static unsigned int rwdt_get_timeleft(struct watchdog_device *wdev)
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 	u16 val = readw_relaxed(priv->base + RWTCNT);
 
-	return DIV_ROUND_CLOSEST(65536 - val, priv->clks_per_sec);
+	return (65536 - val) / priv->clks_per_sec;
 }
 
 static const struct watchdog_info rwdt_ident = {
-- 
2.11.0

