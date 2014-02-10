Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33589 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752231AbaBJXBD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Feb 2014 18:01:03 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v7 05/18] watchdog: orion: Handle the interrupt so it's properly acked
Date: Mon, 10 Feb 2014 20:00:24 -0300
Message-Id: <1392073237-2554-6-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392073237-2554-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DT-enabled plaforms, where the irqchip driver for the brigde interrupt
controller is available, can handle the watchdog IRQ properly. Therefore,
request the interrupt and add a dummy handler that merely calls panic().

This is done in order to have an initial 'ack' of the interruption,
which clears the watchdog state.

Furthermore, since some platforms don't have such IRQ, this commit
makes the interrupt specification optional.

Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/watchdog/marvel.txt        |  2 ++
 drivers/watchdog/orion_wdt.c                       | 24 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/marvel.txt b/Documentation/devicetree/bindings/watchdog/marvel.txt
index 5dc8d30..0731fbd 100644
--- a/Documentation/devicetree/bindings/watchdog/marvel.txt
+++ b/Documentation/devicetree/bindings/watchdog/marvel.txt
@@ -7,6 +7,7 @@ Required Properties:
 
 Optional properties:
 
+- interrupts	: Contains the IRQ for watchdog expiration
 - timeout-sec	: Contains the watchdog timeout in seconds
 
 Example:
@@ -14,6 +15,7 @@ Example:
 	wdt@20300 {
 		compatible = "marvell,orion-wdt";
 		reg = <0x20300 0x28>;
+		interrupts = <3>;
 		timeout-sec = <10>;
 		status = "okay";
 	};
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index e10b0b1..b7067ac 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -119,10 +120,16 @@ static struct watchdog_device orion_wdt = {
 	.min_timeout = 1,
 };
 
+static irqreturn_t orion_wdt_irq(int irq, void *devid)
+{
+	panic("Watchdog Timeout");
+	return IRQ_HANDLED;
+}
+
 static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
-	int ret;
+	int ret, irq;
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
@@ -161,6 +168,21 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!orion_wdt_enabled())
 		orion_wdt_stop(&orion_wdt);
 
+	/* Request the IRQ only after the watchdog is disabled */
+	irq = platform_get_irq(pdev, 0);
+	if (irq > 0) {
+		/*
+		 * Not all supported platforms specify an interrupt for the
+		 * watchdog, so let's make it optional.
+		 */
+		ret = devm_request_irq(&pdev->dev, irq, orion_wdt_irq, 0,
+				       pdev->name, &orion_wdt);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request IRQ\n");
+			goto disable_clk;
+		}
+	}
+
 	watchdog_set_nowayout(&orion_wdt, nowayout);
 	ret = watchdog_register_device(&orion_wdt);
 	if (ret)
-- 
1.8.1.5

