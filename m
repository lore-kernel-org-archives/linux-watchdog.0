Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49589 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752336AbaAVXGN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 18:06:13 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-watchdog@vger.kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Fabio Estevam <festevam@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Cooper <jason@lakedaemon.net>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v4 13/18] watchdog: orion: Add per-compatible watchdog start implementation
Date: Wed, 22 Jan 2014 20:05:10 -0300
Message-Id: <1390431915-5115-14-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
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
index 5ce5d48..471d6d9 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -50,6 +50,7 @@ struct orion_watchdog_data {
 	int rstout_enable_bit;
 	int (*clock_init) (struct platform_device *,
 			   struct orion_watchdog *);
+	int (*start) (struct watchdog_device *);
 };
 
 struct orion_watchdog {
@@ -86,7 +87,7 @@ static int orion_wdt_ping(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
-static int orion_wdt_start(struct watchdog_device *wdt_dev)
+static int orion_start(struct watchdog_device *wdt_dev)
 {
 	struct orion_watchdog *dev = watchdog_get_drvdata(wdt_dev);
 
@@ -105,6 +106,14 @@ static int orion_wdt_start(struct watchdog_device *wdt_dev)
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
@@ -183,6 +192,7 @@ static const struct orion_watchdog_data orion_data = {
 	.wdt_enable_bit = BIT(4),
 	.wdt_counter_offset = 0x24,
 	.clock_init = orion_wdt_clock_init,
+	.start = orion_start,
 };
 
 static const struct of_device_id orion_wdt_of_match_table[] = {
-- 
1.8.1.5

