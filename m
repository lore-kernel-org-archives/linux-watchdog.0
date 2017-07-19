Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39784 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752865AbdGSI2G (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Jul 2017 04:28:06 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/5] watchdog: renesas_wdt: don't round closest with get_timeleft
Date: Wed, 19 Jul 2017 10:27:53 +0200
Message-Id: <20170719082755.21733-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170719082755.21733-1-wsa+renesas@sang-engineering.com>
References: <20170719082755.21733-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

We should never return more time left than there actually is. So, switch
to a plain divider instead of DIV_ROUND_CLOSEST.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 8437dd52153208..3763437cd0b015 100644
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

