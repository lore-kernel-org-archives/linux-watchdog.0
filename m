Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45262 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBJJT2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 10 Feb 2018 04:19:28 -0500
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v2 1/7] watchdog: sama5d4: make use of timeout-secs provided in devicetree
Date: Sat, 10 Feb 2018 10:19:05 +0100
Message-Id: <20180210091911.3644-1-marcus.folkesson@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

watchdog_init_timeout() will allways pick timeout_param since it
defaults to a valid timeout.

Following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt to make use of
the parameter logic.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sama5d4_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 0ae947c3d7bc..e6c679383734 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -33,7 +33,7 @@ struct sama5d4_wdt {
 	unsigned long		last_ping;
 };
 
-static int wdt_timeout = WDT_DEFAULT_TIMEOUT;
+static int wdt_timeout;
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
 module_param(wdt_timeout, int, 0);
@@ -212,7 +212,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	wdd = &wdt->wdd;
-	wdd->timeout = wdt_timeout;
+	wdd->timeout = WDT_DEFAULT_TIMEOUT;
 	wdd->info = &sama5d4_wdt_info;
 	wdd->ops = &sama5d4_wdt_ops;
 	wdd->min_timeout = MIN_WDT_TIMEOUT;
-- 
2.15.1

