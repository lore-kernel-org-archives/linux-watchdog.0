Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39671 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753900AbaAUJMr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:12:47 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v2 04/15] watchdog: orion: Handle IRQ
Date: Tue, 21 Jan 2014 06:12:30 -0300
Message-Id: <1390295561-3466-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

DT-enabled where an irqchip driver for the brigde interrupt controller is
available can handle the watchdog IRQ properly. Therefore, we request
the interruption and add a dummy handler that merely calls panic().

This is done in order to have an initial 'ack' of the interruption,
which clears the watchdog state.

Furthermore, since some platforms don't have such IRQ, this commit
makes the interruption specification optional.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../devicetree/bindings/watchdog/marvel.txt        |  2 ++
 drivers/watchdog/orion_wdt.c                       | 22 +++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

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
index cf64510..06e766f 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -19,6 +19,7 @@
 #include <linux/platform_device.h>
 #include <linux/watchdog.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/spinlock.h>
 #include <linux/clk.h>
@@ -131,10 +132,16 @@ static struct watchdog_device orion_wdt = {
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
@@ -151,6 +158,19 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	if (!wdt_reg)
 		return -ENOMEM;
 
+	irq = platform_get_irq(pdev, 0);
+	if (irq > 0) {
+		/*
+		 * Not all supported platforms specify an interruption for the
+		 * watchdog, so let's make it optional.
+		 */
+		ret = request_irq(irq, orion_wdt_irq, 0, pdev->name, NULL);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to request IRQ\n");
+			return ret;
+		}
+	}
+
 	wdt_max_duration = WDT_MAX_CYCLE_COUNT / wdt_tclk;
 
 	orion_wdt.timeout = wdt_max_duration;
-- 
1.8.1.5

