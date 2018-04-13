Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:47650 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754339AbeDMOT2 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 13 Apr 2018 10:19:28 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] watchdog: renesas-wdt: Add support for WDIOF_CARDRESET
Date: Fri, 13 Apr 2018 16:19:24 +0200
Message-Id: <20180413141924.8982-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>

This patch adds the WDIOF_CARDRESET support for the Renesas platform
watchdog, to know if the board reboot is due to a watchdog reset.

This is done via the WOVF bit (bit 4) of the RWTCSRA register, which
indicates if RWTCNT overflowed, triggering the reset in last boot.

Signed-off-by: Veeraiyan Chidambaram <veeraiyan.chidambaram@in.bosch.com>
[takeshi.kihara.df: changed to read the RWTCSRA register while clock is
 enabled]
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

Changes since v1:
* removed typo in commit message
* added rev tags
* no code changes

 drivers/watchdog/renesas_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 6b8c6ddfe30b..514db5cc1595 100644
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

