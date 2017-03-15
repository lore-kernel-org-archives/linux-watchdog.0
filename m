Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51147 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752315AbdCOSRG (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 15 Mar 2017 14:17:06 -0400
From: Michael Tretter <m.tretter@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: support.opensource@diasemi.com, wim@iguana.be, linux@roeck-us.net,
        p.zabel@pengutronix.de, Michael Tretter <m.tretter@pengutronix.de>
Subject: [PATCH] watchdog: da9063: Disable watchdog before changing timeout
Date: Wed, 15 Mar 2017 19:17:01 +0100
Message-Id: <20170315181701.28430-1-m.tretter@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The DA9063 watchdog always resets the system when systemd changes the
timeout value after Barebox already set a timeout value.

If the watchdog is disabled before setting a new timeout, the system is
not reset and the watchdog is still enabled.

This patch is based on a previous patch by Philipp Zabel [1], but does
not wait for 150 us, because the DA9063 does not require a delay after
disabling the watchdog.

[1] https://www.spinics.net/lists/linux-watchdog/msg07143.html

Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 4691c5509129..fcdc12d14d03 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -55,8 +55,19 @@ static unsigned int da9063_wdt_timeout_to_sel(unsigned int secs)
 
 static int _da9063_wdt_set_timeout(struct da9063 *da9063, unsigned int regval)
 {
-	return regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
-				  DA9063_TWDSCALE_MASK, regval);
+	int ret;
+
+	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
+			         DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
+	if (ret)
+		dev_warn(da9063->dev,
+			 "Failed to disable watchdog before setting new timeout\n");
+
+	if (regval)
+		ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
+				DA9063_TWDSCALE_MASK, regval);
+
+	return ret;
 }
 
 static int da9063_wdt_start(struct watchdog_device *wdd)
-- 
2.11.0

