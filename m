Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ee0-f52.google.com ([74.125.83.52]:64402 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236Ab3AHKEa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 8 Jan 2013 05:04:30 -0500
Received: by mail-ee0-f52.google.com with SMTP id d17so111533eek.39
        for <linux-watchdog@vger.kernel.org>; Tue, 08 Jan 2013 02:04:29 -0800 (PST)
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
Subject: [PATCH v7 4/6] watchdog: s3c2410_wdt: add timeout-sec property binding
Date: Tue,  8 Jan 2013 11:04:13 +0100
Message-Id: <1357639455-21935-5-git-send-email-fabio.porcedda@gmail.com>
In-Reply-To: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
References: <1357639455-21935-1-git-send-email-fabio.porcedda@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Only compile tested.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
---
 Documentation/devicetree/bindings/watchdog/samsung-wdt.txt | 3 +++
 drivers/watchdog/s3c2410_wdt.c                             | 6 ++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
index 79ead82..451127a 100644
--- a/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/samsung-wdt.txt
@@ -9,3 +9,6 @@ Required properties:
 - reg : base physical address of the controller and length of memory mapped
 	region.
 - interrupts : interrupt number to the cpu.
+
+Optional properties:
+- timeout-sec : contains the watchdog timeout in seconds.
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 27bcd4e..2f187ae 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -53,7 +53,7 @@
 #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
 static bool nowayout	= WATCHDOG_NOWAYOUT;
-static int tmr_margin	= CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME;
+static int tmr_margin;
 static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
 static int soft_noboot;
 static int debug;
@@ -226,6 +226,7 @@ static struct watchdog_ops s3c2410wdt_ops = {
 static struct watchdog_device s3c2410_wdd = {
 	.info = &s3c2410_wdt_ident,
 	.ops = &s3c2410wdt_ops,
+	.timeout = CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME,
 };
 
 /* interrupt handler code */
@@ -365,7 +366,8 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	/* see if we can actually set the requested timer margin, and if
 	 * not, try the default value */
 
-	if (s3c2410wdt_set_heartbeat(&s3c2410_wdd, tmr_margin)) {
+	watchdog_init_timeout(&s3c2410_wdd, tmr_margin,  pdev->dev.of_node);
+	if (s3c2410wdt_set_heartbeat(&s3c2410_wdd, s3c2410_wdd.timeout)) {
 		started = s3c2410wdt_set_heartbeat(&s3c2410_wdd,
 					CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME);
 
-- 
1.8.0.3

