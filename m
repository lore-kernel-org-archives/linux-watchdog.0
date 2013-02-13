Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:45848 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933922Ab3BMM3g (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 13 Feb 2013 07:29:36 -0500
Received: by mail-ea0-f179.google.com with SMTP id d12so444750eaa.38
        for <linux-watchdog@vger.kernel.org>; Wed, 13 Feb 2013 04:29:35 -0800 (PST)
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
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v8 7/7] watchdog: orion_wdt: move the min_timeout initialization
Date: Wed, 13 Feb 2013 13:22:30 +0100
Message-Id: <1360758150-23004-8-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
References: <1360758150-23004-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Move the min_timeout initialization inside the orion_wdt definition.

Only compile tested.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 3022a38..da57798 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -140,6 +140,7 @@ static const struct watchdog_ops orion_wdt_ops = {
 static struct watchdog_device orion_wdt = {
 	.info = &orion_wdt_info,
 	.ops = &orion_wdt_ops,
+	.min_timeout = 1,
 };
 
 static int orion_wdt_probe(struct platform_device *pdev)
@@ -164,7 +165,6 @@ static int orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	orion_wdt.min_timeout = 1;
 	orion_wdt.timeout = wdt_max_duration;
 	orion_wdt.max_timeout = wdt_max_duration;
 	watchdog_init_timeout(&orion_wdt, heartbeat, &pdev->dev);
-- 
1.8.1.1

