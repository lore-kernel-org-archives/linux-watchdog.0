Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37496 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752983AbaCLVMj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 17:12:39 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 4/8] watchdog: orion: Introduce per-SoC enabled() function
Date: Wed, 12 Mar 2014 18:11:51 -0300
Message-Id: <1394658715-2017-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to support other SoCs, it's needed to have a different enabled()
implementation for each SoC. This commit adds no functionality, and it
consists of preparation work.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 1cb50d6..b255a9e 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -58,6 +58,7 @@ struct orion_watchdog_data {
 	int rstout_enable_bit;
 	int (*clock_init)(struct platform_device *,
 			  struct orion_watchdog *);
+	int (*enabled)(struct orion_watchdog *);
 	int (*start)(struct watchdog_device *);
 	int (*stop)(struct watchdog_device *);
 };
@@ -230,7 +231,7 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	return dev->data->stop(wdt_dev);
 }
 
-static int orion_wdt_enabled(struct orion_watchdog *dev)
+static int orion_enabled(struct orion_watchdog *dev)
 {
 	bool enabled, running;
 
@@ -240,6 +241,13 @@ static int orion_wdt_enabled(struct orion_watchdog *dev)
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
@@ -301,6 +309,7 @@ static const struct orion_watchdog_data orion_data = {
 	.wdt_enable_bit = BIT(4),
 	.wdt_counter_offset = 0x24,
 	.clock_init = orion_wdt_clock_init,
+	.enabled = orion_enabled,
 	.start = orion_start,
 	.stop = orion_stop,
 };
@@ -310,6 +319,7 @@ static const struct orion_watchdog_data armada370_data = {
 	.wdt_enable_bit = BIT(8),
 	.wdt_counter_offset = 0x34,
 	.clock_init = armada370_wdt_clock_init,
+	.enabled = orion_enabled,
 	.start = armada370_start,
 	.stop = armada370_stop,
 };
@@ -319,6 +329,7 @@ static const struct orion_watchdog_data armadaxp_data = {
 	.wdt_enable_bit = BIT(8),
 	.wdt_counter_offset = 0x34,
 	.clock_init = armadaxp_wdt_clock_init,
+	.enabled = orion_enabled,
 	.start = armada370_start,
 	.stop = armada370_stop,
 };
@@ -414,7 +425,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	 * removed and re-insterted, or if the bootloader explicitly
 	 * set a running watchdog before booting the kernel.
 	 */
-	if (!orion_wdt_enabled(dev))
+	if (!orion_wdt_enabled(&dev->wdt))
 		orion_wdt_stop(&dev->wdt);
 
 	/* Request the IRQ only after the watchdog is disabled */
-- 
1.9.0

