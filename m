Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:52671 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCTVgo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Mar 2018 17:36:44 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] watchdog: renesas-wdt: Add support for WDIOF_CARDRESET
Date: Tue, 20 Mar 2018 22:36:26 +0100
Message-Id: <20180320213626.14208-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>

This patch adds the WDIOF_CARDRESET support for the Renessas platform
watchdog, to know if the board reboot is due to a watchdog reset.

This is done via the WOVF bit (bit 4) of the RWTCSRA register, which
indicates if RWTCNT overflowed, triggering the reset in last boot.

Signed-off-by: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
[takeshi.kihara.df: changed to read the RWTCSRA register while clock is
 enabled]
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 6b8c6ddfe30b31..514db5cc159511 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -121,7 +121,8 @@ static int rwdt_restart(struct watchdog_device *wdev, unsigned long action,
 }
 
 static const struct watchdog_info rwdt_ident = {
-	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT,
+	.options = WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
+		WDIOF_CARDRESET,
 	.identity = "Renesas WDT Watchdog",
 };
 
@@ -197,9 +198,10 @@ static int rwdt_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 
 	pm_runtime_enable(&pdev->dev);
-
 	pm_runtime_get_sync(&pdev->dev);
 	priv->clk_rate = clk_get_rate(clk);
+	priv->wdev.bootstatus = (readb_relaxed(priv->base + RWTCSRA) &
+				RWTCSRA_WOVF) ? WDIOF_CARDRESET : 0;
 	pm_runtime_put(&pdev->dev);
 
 	if (!priv->clk_rate) {
-- 
2.11.0

