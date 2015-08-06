Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55373 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755220AbbHFQhS (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Aug 2015 12:37:18 -0400
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, support.opensource@diasemi.com,
	kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 2/2] watchdog: da9063: Disable and wait before changing timeout
Date: Thu,  6 Aug 2015 18:36:59 +0200
Message-Id: <1438879019-12978-2-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>
References: <1438879019-12978-1-git-send-email-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The DA9063 watchdog occasionally enters error condition and resets the
system if the timeout is changed quickly after the timer was enabled.

The method of disabling and waiting for > 150 µs before setting the
new timeout is taken from the DA9052 driver.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/watchdog/da9063_wdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index b2e9201..87e14d8 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -67,6 +67,11 @@ static int _da9063_wdt_set_timeout(struct da9063_watchdog *wdt,
 	mutex_lock(&wdt->mutex);
 
 	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
+				 DA9063_TWDSCALE_MASK, DA9063_TWDSCALE_DISABLE);
+
+	usleep_range(150, 300);
+
+	ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONTROL_D,
 				 DA9063_TWDSCALE_MASK, regval);
 
 	wdt->defer_ping = false;
-- 
2.4.6

