Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39254 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934213AbbDXJs4 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 24 Apr 2015 05:48:56 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Felipe Balbi <balbi@ti.com>,
	kernel@pengutronix.de
Subject: [PATCH 3/3] watchdog: omap: simplify assignment of bootstatus
Date: Fri, 24 Apr 2015 11:48:33 +0200
Message-Id: <1429868913-24049-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1429868913-24049-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Instead of using an over-long expression involving the ?: operator use
an if and intead of an else branch rely on the fact that the data
structure was allocated using devm_kzalloc. This also allows to put the
used helper variable into a more local scope.

There is no functional change.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/omap_wdt.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 479e7c8e44f5..0421c06a6cf0 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -209,7 +209,6 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	struct omap_wd_timer_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct resource *res;
 	struct omap_wdt_dev *wdev;
-	u32 rs;
 	int ret;
 
 	wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
@@ -242,12 +241,11 @@ static int omap_wdt_probe(struct platform_device *pdev)
 	pm_runtime_enable(wdev->dev);
 	pm_runtime_get_sync(wdev->dev);
 
-	if (pdata && pdata->read_reset_sources)
-		rs = pdata->read_reset_sources();
-	else
-		rs = 0;
-	wdev->wdog.bootstatus = (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT)) ?
-		WDIOF_CARDRESET : 0;
+	if (pdata && pdata->read_reset_sources) {
+		u32 rs = pdata->read_reset_sources();
+		if (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT))
+			wdev->wdog.bootstatus = WDIOF_CARDRESET;
+	}
 
 	omap_wdt_disable(wdev);
 
-- 
2.1.4

