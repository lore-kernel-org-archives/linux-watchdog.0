Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [85.220.129.31] ([85.220.129.31]:32922 "EHLO smtp1-2.goneo.de"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753628AbbFYKWd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Jun 2015 06:22:33 -0400
From: poeschel@lemonage.de
To: wim@iguana.be, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH v2] watchdog: omap_wdt: early_enable module parameter
Date: Thu, 25 Jun 2015 12:21:51 +0200
Message-Id: <1435227711-29875-1-git-send-email-poeschel@lemonage.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Add a early_enable module parameter to the omap_wdt that starts the
watchdog on module insertion. The default value is 0 which does not
start the watchdog - which also does not change the behavior if the
parameter is not given.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 Documentation/watchdog/watchdog-parameters.txt | 1 +
 drivers/watchdog/omap_wdt.c                    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 692791c..837a4e2 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -208,6 +208,7 @@ nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
 omap_wdt:
 timer_margin: initial watchdog timeout (in seconds)
+early_enable: Watchdog is started on module insertion (default=0)
 -------------------------------------------------
 orion_wdt:
 heartbeat: Initial watchdog heartbeat in seconds
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1e6be9e..29c5f33 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -53,6 +53,11 @@ static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
 MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
 
+static bool early_enable;
+module_param(early_enable, bool, 0);
+MODULE_PARM_DESC(early_enable,
+	"Watchdog is started on module insertion (default=0)");
+
 struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
@@ -269,6 +274,9 @@ static int omap_wdt_probe(struct platform_device *pdev)
 
 	pm_runtime_put_sync(wdev->dev);
 
+	if (early_enable)
+		omap_wdt_start(omap_wdt);
+
 	return 0;
 }
 
-- 
2.1.4

