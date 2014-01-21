Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39739 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753419AbaAUJNN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 04:13:13 -0500
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
Subject: [PATCH v2 10/15] watchdog: orion: Add per-compatible watchdog start implementation
Date: Tue, 21 Jan 2014 06:12:36 -0300
Message-Id: <1390295561-3466-11-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

To handle differences between SoCs this commit adds per-compatible
string start() function for the watchdog kick-off. This is preparation
work and makes no functionality changes to the current driver.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index e94bb97..d6009fe 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -53,6 +53,7 @@ struct orion_watchdog_data {
 	int rstout_enable_bit;
 	int (*clock_init) (struct platform_device *,
 			   struct orion_watchdog *);
+	int (*start) (struct watchdog_device *);
 };
 
 struct orion_watchdog {
@@ -89,7 +90,7 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
-static int orion_wdt_start(struct watchdog_device *wdt_dev)
+static int orion_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 
@@ -111,6 +112,14 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static int orion_wdt_start(struct watchdog_device *wdt_dev)
+{
+	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
+
+	/* There are some per-SoC quirks to handle */
+	return dev->data->start(wdt_dev);
+}
+
 static int orion_wdt_stop(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
@@ -172,6 +181,7 @@ static const struct orion_watchdog_data orion_data = {
 	.wdt_enable_bit = BIT(4),
 	.wdt_counter_offset = 0x24,
 	.clock_init = orion_wdt_clock_init,
+	.start = orion_start,
 };
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
-- 
1.8.1.5

