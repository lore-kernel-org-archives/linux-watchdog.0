Return-Path: <festevam@gmail.com>
Return-path: <festevam@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
To: wim@iguana.be
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	wsa+renesas@sang-engineering.com,
	justinpopo6@gmail.com,
	Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/2] watchdog: renesas-wdt: Check the return value from clk_prepare_enable()
Date: Sat, 22 Jul 2017 17:22:58 -0300
Message-Id: <1500754979-19836-1-git-send-email-festevam@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Fabio Estevam <fabio.estevam@nxp.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/watchdog/renesas_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index cf61c92..ca3dc4c 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -62,9 +62,13 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
 
 static int rwdt_start(struct watchdog_device *wdev)
 {
+	int ret;
+
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
 
-	clk_prepare_enable(priv->clk);
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
 
 	rwdt_write(priv, priv->cks, RWTCSRA);
 	rwdt_init_timeout(wdev);
-- 
2.7.4
