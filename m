Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38775 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830AbbG3Jc0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jul 2015 05:32:26 -0400
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, kernel@pengutronix.de
Subject: [PATCH] watchdog: gpio-wdt: be more strict about hw_algo matching
Date: Thu, 30 Jul 2015 11:32:23 +0200
Message-Id: <1438248743-8722-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

strncmp(algo, "toggle", 6) doesn't compare the trailing '\0' byte, so
using

	hw_algo = "toggleboggle"

is recognized the same way as

	hw_algo = "toggle"

. While this doesn't introduce any problems for a device tree that
sticks to the documented settings it's still ugly.

Fix this by using strcmp to only match on "toggle" and "level".

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/gpio_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 1687cc2d7122..57d30f1f55ab 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -182,10 +182,10 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	ret = of_property_read_string(pdev->dev.of_node, "hw_algo", &algo);
 	if (ret)
 		return ret;
-	if (!strncmp(algo, "toggle", 6)) {
+	if (!strcmp(algo, "toggle")) {
 		priv->hw_algo = HW_ALGO_TOGGLE;
 		f = GPIOF_IN;
-	} else if (!strncmp(algo, "level", 5)) {
+	} else if (!strcmp(algo, "level")) {
 		priv->hw_algo = HW_ALGO_LEVEL;
 		f = priv->active_low ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
 	} else {
-- 
2.1.4

