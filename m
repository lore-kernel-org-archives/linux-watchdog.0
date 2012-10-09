Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46214 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450Ab2JIMEa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 9 Oct 2012 08:04:30 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so3446960eek.19
        for <linux-watchdog@vger.kernel.org>; Tue, 09 Oct 2012 05:04:29 -0700 (PDT)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Andrew Victor <linux@maxim.org.za>,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>
Cc: devicetree-discuss@lists.ozlabs.org
Subject: [PATCH v4 7/8] watchdog: orion_wdt: move the min_timeout initialization
Date: Tue,  9 Oct 2012 14:04:10 +0200
Message-Id: <1349784251-28261-8-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
References: <1349784251-28261-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Move the min_timeout initialization inside the orion_wdt definition.

Only compile tested.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 446a3e9..3b4e228 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -140,6 +140,7 @@ static const struct watchdog_ops orion_wdt_ops = {
 static struct watchdog_device orion_wdt = {
 	.info = &orion_wdt_info,
 	.ops = &orion_wdt_ops,
+	.min_timeout = 1,
 };
 
 static int __devinit orion_wdt_probe(struct platform_device *pdev)
@@ -162,7 +163,6 @@ static int __devinit orion_wdt_probe(struct platform_device *pdev)
 
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
-	orion_wdt.min_timeout = 1;
 	orion_wdt.timeout = wdt_max_duration;
 	orion_wdt.max_timeout = wdt_max_duration;
 	watchdog_init_timeout(&orion_wdt, heartbeat, pdev->dev.of_node);
-- 
1.7.11.3

