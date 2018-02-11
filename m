Return-Path: <marcus.folkesson@gmail.com>
Return-path: <marcus.folkesson@gmail.com>
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
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v3 1/7] watchdog: sama5d4: make use of timeout-secs provided in devicetree
Date: Sun, 11 Feb 2018 21:08:41 +0100
Message-Id: <20180211200847.25000-1-marcus.folkesson@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

watchdog_init_timeout() will allways pick timeout_param since it
defaults to a valid timeout.

Following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt to make use of
the parameter logic.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v3:
    	- Use wdd->timeout instead of wdt_timeout when print out
    	  timout in probe function.

 drivers/watchdog/sama5d4_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 0ae947c3d7bc..255169916dbb 100644
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
@@ -273,7 +273,7 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdt);
 
 	dev_info(&pdev->dev, "initialized (timeout = %d sec, nowayout = %d)\n",
-		 wdt_timeout, nowayout);
+		 wdd->timeout, nowayout);
 
 	return 0;
 }
-- 
2.15.1
