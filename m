Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:35574 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbeLDMB5 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Dec 2018 07:01:57 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC] watchdog: renesas_wdt: don't keep timer value during suspend/resume
Date: Tue,  4 Dec 2018 13:01:46 +0100
Message-Id: <20181204120146.1923-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

After discussing this mail thread [1] again, we concluded that giving
userspace enough time to prepare is our favourite option. So, do not
keep the time value when suspended but reset it when resuming.

[1] https://patchwork.kernel.org/patch/10252209/

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Fabrizio: can you agree to that? The R-Car BSP team and we (the R-Car upstream
team) would prefer it this way (knowing it is also not perfect).

 drivers/watchdog/renesas_wdt.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index b570962e84f3..9f2307bf727b 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -48,7 +48,6 @@ struct rwdt_priv {
 	void __iomem *base;
 	struct watchdog_device wdev;
 	unsigned long clk_rate;
-	u16 time_left;
 	u8 cks;
 };
 
@@ -263,10 +262,9 @@ static int __maybe_unused rwdt_suspend(struct device *dev)
 {
 	struct rwdt_priv *priv = dev_get_drvdata(dev);
 
-	if (watchdog_active(&priv->wdev)) {
-		priv->time_left = readw(priv->base + RWTCNT);
+	if (watchdog_active(&priv->wdev))
 		rwdt_stop(&priv->wdev);
-	}
+
 	return 0;
 }
 
@@ -274,10 +272,9 @@ static int __maybe_unused rwdt_resume(struct device *dev)
 {
 	struct rwdt_priv *priv = dev_get_drvdata(dev);
 
-	if (watchdog_active(&priv->wdev)) {
+	if (watchdog_active(&priv->wdev))
 		rwdt_start(&priv->wdev);
-		rwdt_write(priv, priv->time_left, RWTCNT);
-	}
+
 	return 0;
 }
 
-- 
2.11.0
