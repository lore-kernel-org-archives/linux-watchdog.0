Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:58894 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbeKHFRz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 8 Nov 2018 00:17:55 -0500
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2] watchdog: renesas_wdt: don't set divider while watchdog is running
Date: Wed,  7 Nov 2018 20:46:02 +0100
Message-Id: <20181107194602.7209-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The datasheet says we must stop the timer before changing the clock
divider. This can happen when the restart handler is called while the
watchdog is running.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Change since V1: reworded commit message.

I sent V1 back then when it was more a recommendation of the datasheet to do it
like this. But meanwhile the code changed, so we actually need to do it.

 drivers/watchdog/renesas_wdt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 0d74c3e48979..55c9eb6c6e51 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -74,12 +74,17 @@ static int rwdt_init_timeout(struct watchdog_device *wdev)
 static int rwdt_start(struct watchdog_device *wdev)
 {
 	struct rwdt_priv *priv = watchdog_get_drvdata(wdev);
+	u8 val;
 
 	pm_runtime_get_sync(wdev->parent);
 
-	rwdt_write(priv, 0, RWTCSRB);
-	rwdt_write(priv, priv->cks, RWTCSRA);
+	/* Stop the timer before we modify any register */
+	val = readb_relaxed(priv->base + RWTCSRA) & ~RWTCSRA_TME;
+	rwdt_write(priv, val, RWTCSRA);
+
 	rwdt_init_timeout(wdev);
+	rwdt_write(priv, priv->cks, RWTCSRA);
+	rwdt_write(priv, 0, RWTCSRB);
 
 	while (readb_relaxed(priv->base + RWTCSRA) & RWTCSRA_WRFLG)
 		cpu_relax();
-- 
2.11.0
