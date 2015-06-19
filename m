Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from [85.220.129.30] ([85.220.129.30]:52889 "EHLO smtp1.goneo.de"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752097AbbFSNSV (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 19 Jun 2015 09:18:21 -0400
From: poeschel@lemonage.de
To: wim@iguana.be, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars Poeschel <poeschel@lemonage.de>
Subject: [PATCH] watchdog: omap_wdt: start_enabled module parameter
Date: Fri, 19 Jun 2015 15:18:00 +0200
Message-Id: <1434719880-12393-1-git-send-email-poeschel@lemonage.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

Add a start_enabled module parameter to the omap_wdt that starts the
watchdog on module insertion. The default value is 0 which does not
start the watchdog - which also does not change the behaviour if the
parameter is not given.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 Documentation/watchdog/watchdog-parameters.txt |  1 +
 drivers/watchdog/omap_wdt.c                    | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/watchdog/watchdog-parameters.txt b/Documentation/watchdog/watchdog-parameters.txt
index 692791c..fb023bb 100644
--- a/Documentation/watchdog/watchdog-parameters.txt
+++ b/Documentation/watchdog/watchdog-parameters.txt
@@ -208,6 +208,7 @@ nowayout: Watchdog cannot be stopped once started
 -------------------------------------------------
 omap_wdt:
 timer_margin: initial watchdog timeout (in seconds)
+start_enabled: Watchdog is started on module insertion (default=0)
 -------------------------------------------------
 orion_wdt:
 heartbeat: Initial watchdog heartbeat in seconds
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index a29a61d..7dc8de7 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -53,6 +53,13 @@ static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
 MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
 
+#define START_DEFAULT	0
+static bool start_enabled = START_DEFAULT;
+module_param(start_enabled, bool, 0);
+MODULE_PARM_DESC(start_enabled,
+	"Watchdog is started on module insertion (default="
+	__MODULE_STRING(START_DEFAULT) ")");
+
 struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
@@ -280,6 +287,9 @@ static int omap_wdt_probe(struct platform_device *pdev)
 
 	pm_runtime_put_sync(wdev->dev);
 
+	if (start_enabled)
+		omap_wdt_start(omap_wdt);
+
 	return 0;
 }
 
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
