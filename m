Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:59620 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3BMMWp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 07:22:45 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so462604eaa.25
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 04:22:44 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org,
	Wenyou Yang <wenyou.yang@atmel.com>,
	Wolfram Sang <w.sang@pengutronix.de>,
	Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH v8 4/7] watchdog: pnx4008: add timeout-sec property binding
Date: Wed, 13 Feb 2013 13:22:27 +0100
Message-Id: <1360758150-23004-5-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Only compile tested.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Wolfram Sang <w.sang@pengutronix.de>
Cc: Masanari Iida <standby24x7@gmail.com>
---
 Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt | 4 ++++
 drivers/watchdog/pnx4008_wdt.c                             | 7 +++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt b/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
index 7c7f688..556d06c 100644
--- a/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/pnx4008-wdt.txt
@@ -5,9 +5,13 @@ Required properties:
 - reg: physical base address of the controller and length of memory mapped
   region.
 
+Optional properties:
+- timeout-sec: contains the watchdog timeout in seconds.
+
 Example:
 
 	watchdog@4003C000 {
 		compatible = "nxp,pnx4008-wdt";
 		reg = <0x4003C000 0x1000>;
+		timeout-sec = <10>;
 	};
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index dcba5da..bbc249a 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -142,6 +142,7 @@ static const struct watchdog_ops pnx4008_wdt_ops = {
 static struct watchdog_device pnx4008_wdd = {
 	.info = &pnx4008_wdt_ident,
 	.ops = &pnx4008_wdt_ops,
+	.timeout = DEFAULT_HEARTBEAT,
 	.min_timeout = 1,
 	.max_timeout = MAX_HEARTBEAT,
 };
@@ -151,8 +152,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	struct resource *r;
 	int ret = 0;
 
-	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
-		heartbeat = DEFAULT_HEARTBEAT;
+	watchdog_init_timeout(&pnx4008_wdd, heartbeat, &pdev->dev);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt_base = devm_request_and_ioremap(&pdev->dev, r);
@@ -167,7 +167,6 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		goto out;
 
-	pnx4008_wdd.timeout = heartbeat;
 	pnx4008_wdd.bootstatus = (readl(WDTIM_RES(wdt_base)) & WDOG_RESET) ?
 			WDIOF_CARDRESET : 0;
 	watchdog_set_nowayout(&pnx4008_wdd, nowayout);
@@ -181,7 +180,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "PNX4008 Watchdog Timer: heartbeat %d sec\n",
-			heartbeat);
+		 pnx4008_wdd.timeout);
 
 	return 0;
 
-- 
1.8.1.1

