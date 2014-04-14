Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59113 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752242AbaDNNYa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Apr 2014 09:24:30 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [RESEND/PATCH v4 5/9] watchdog: orion: Introduce per-SoC enabled() function
Date: Mon, 14 Apr 2014 10:23:29 -0300
Message-Id: <1397481813-4962-6-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to support other SoCs, it's needed to have a different enabled()
implementation for each SoC. This commit adds no functionality, and it
consists of preparation work.

Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index be7c71c..ba316db 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -57,6 +57,7 @@ struct orion_watchdog_data {
 	int rstout_enable_bit;
 	int (*clock_init)(struct platform_device *,
 			  struct orion_watchdog *);
+	int (*enabled)(struct orion_watchdog *);
 	int (*start)(struct watchdog_device *);
 	int (*stop)(struct watchdog_device *);
 };
@@ -229,7 +230,7 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	return dev->data->stop(wdt_dev);
 }
 
-static int orion_wdt_enabled(struct orion_watchdog *dev)
+static int orion_enabled(struct orion_watchdog *dev)
 {
 	bool enabled, running;
 
@@ -239,6 +240,13 @@ static int orion_wdt_enabled(struct orion_watchdog *dev)
 	return enabled && running;
 }
 
+static int orion_wdt_enabled(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
+	return dev->data->enabled(dev);
+}
+
 static unsigned int orion_wdt_get_timeleft(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -300,6 +308,7 @@ static const struct orion_watchdog_data orion_data = {
 	.wdt_enable_bit = BIT(4),
 	.wdt_counter_offset = 0x24,
 	.clock_init = orion_wdt_clock_init,
+	.enabled = orion_enabled,
 	.start = orion_start,
 	.stop = orion_stop,
 };
@@ -309,6 +318,7 @@ static const struct orion_watchdog_data armada370_data = {
 	.wdt_enable_bit = BIT(8),
 	.wdt_counter_offset = 0x34,
 	.clock_init = armada370_wdt_clock_init,
+	.enabled = orion_enabled,
 	.start = armada370_start,
 	.stop = armada370_stop,
 };
@@ -318,6 +328,7 @@ static const struct orion_watchdog_data armadaxp_data = {
 	.wdt_enable_bit = BIT(8),
 	.wdt_counter_offset = 0x34,
 	.clock_init = armadaxp_wdt_clock_init,
+	.enabled = orion_enabled,
 	.start = armada370_start,
 	.stop = armada370_stop,
 };
@@ -424,7 +435,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	 * removed and re-insterted, or if the bootloader explicitly
 	 * set a running watchdog before booting the kernel.
 	 */
-	if (!orion_wdt_enabled(dev))
+	if (!orion_wdt_enabled(&dev->wdt))
 		orion_wdt_stop(&dev->wdt);
 
 	/* Request the IRQ only after the watchdog is disabled */
-- 
1.9.1

