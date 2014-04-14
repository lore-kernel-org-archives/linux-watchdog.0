Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59100 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752242AbaDNNYZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 14 Apr 2014 09:24:25 -0400
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
Subject: [RESEND/PATCH v4 4/9] watchdog: orion: Introduce per-SoC stop() function
Date: Mon, 14 Apr 2014 10:23:28 -0300
Message-Id: <1397481813-4962-5-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1397481813-4962-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

In order to support other SoCs, it's needed to have a different stop()
implementation for each SoC. This commit adds no functionality, and it
consists of preparation work.

Tested-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 365d6cc..be7c71c 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -58,6 +58,7 @@ struct orion_watchdog_data {
 	int (*clock_init)(struct platform_device *,
 			  struct orion_watchdog *);
 	int (*start)(struct watchdog_device *);
+	int (*stop)(struct watchdog_device *);
 };
 
 struct orion_watchdog {
@@ -192,7 +193,7 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	return dev->data->start(wdt_dev);
 }
 
-static int orion_wdt_stop(struct watchdog_device *wdt_dev)
+static int orion_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 
@@ -205,6 +206,29 @@ static int orion_wdt_stop(struct watchdog_device *wdt_dev)
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
@@ -277,6 +301,7 @@ static const struct orion_watchdog_data orion_data = {
 	.wdt_counter_offset = 0x24,
 	.clock_init = orion_wdt_clock_init,
 	.start = orion_start,
+	.stop = orion_stop,
 };
 
 static const struct orion_watchdog_data armada370_data = {
@@ -285,6 +310,7 @@ static const struct orion_watchdog_data armada370_data = {
 	.wdt_counter_offset = 0x34,
 	.clock_init = armada370_wdt_clock_init,
 	.start = armada370_start,
+	.stop = armada370_stop,
 };
 
 static const struct orion_watchdog_data armadaxp_data = {
@@ -293,6 +319,7 @@ static const struct orion_watchdog_data armadaxp_data = {
 	.wdt_counter_offset = 0x34,
 	.clock_init = armadaxp_wdt_clock_init,
 	.start = armada370_start,
+	.stop = armada370_stop,
 };
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
-- 
1.9.1

