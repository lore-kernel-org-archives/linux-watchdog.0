Return-Path: <ezequiel.garcia@free-electrons.com>
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v4 4/9] watchdog: orion: Introduce per-SoC stop() function
Date: Sat, 15 Mar 2014 15:17:59 -0300
Message-Id: <1394907484-26002-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

In order to support other SoCs, it's needed to have a different stop()
implementation for each SoC. This commit adds no functionality, and it
consists of preparation work.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 7d9f93f..2d07e6d 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -59,6 +59,7 @@ struct orion_watchdog_data {
 	int (*clock_init)(struct platform_device *,
 			  struct orion_watchdog *);
 	int (*start)(struct watchdog_device *);
+	int (*stop)(struct watchdog_device *);
 };
 
 struct orion_watchdog {
@@ -193,7 +194,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	return dev->data->start(wdt_dev);
 }
 
-static int orion_wdt_stop(struct watchdog_device *wdt_dev)
+static int orion_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 
@@ -206,6 +207,29 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int armada370_stop(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+	u32 reg;
+
+	/* Disable reset on watchdog */
+	reg = readl(dev->rstout);
+	reg &= ~dev->data->rstout_enable_bit;
+	writel(reg, dev->rstout);
+
+	/* Disable watchdog timer */
+	atomic_io_modify(dev->reg + TIMER_CTRL, dev->data->wdt_enable_bit, 0);
+
+	return 0;
+}
+
+static int orion_wdt_stop(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
+	return dev->data->stop(wdt_dev);
+}
+
 static int orion_wdt_enabled(struct orion_watchdog *dev)
 {
 	bool enabled, running;
@@ -278,6 +302,7 @@ static const struct orion_watchdog_data orion_data = {
 	.wdt_counter_offset = 0x24,
 	.clock_init = orion_wdt_clock_init,
 	.start = orion_start,
+	.stop = orion_stop,
 };
 
 static const struct orion_watchdog_data armada370_data = {
@@ -286,6 +311,7 @@ static const struct orion_watchdog_data armada370_data = {
 	.wdt_counter_offset = 0x34,
 	.clock_init = armada370_wdt_clock_init,
 	.start = armada370_start,
+	.stop = armada370_stop,
 };
 
 static const struct orion_watchdog_data armadaxp_data = {
@@ -294,6 +320,7 @@ static const struct orion_watchdog_data armadaxp_data = {
 	.wdt_counter_offset = 0x34,
 	.clock_init = armadaxp_wdt_clock_init,
 	.start = armada370_start,
+	.stop = armada370_stop,
 };
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
-- 
1.9.0
