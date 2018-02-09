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
Subject: [PATCH 4/7] watchdog: pnx4008: make use of timeout-secs provided in devicetree
Date: Fri,  9 Feb 2018 20:27:21 +0100
Message-Id: <20180209192724.1227-5-marcus.folkesson@gmail.com>
In-Reply-To: <20180209192724.1227-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180209192724.1227-1-marcus.folkesson@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

watchdog_init_timeout() will allways pick timeout_param since it
defaults to a valid timeout.

Following best practice described in
Documentation/watchdog/watchdog-kernel-api.txt to make use of
the parameter logic.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/watchdog/pnx4008_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 0529aed158a4..8e261799c84e 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -78,7 +78,7 @@
 #define WDOG_COUNTER_RATE 13000000	/*the counter clock is 13 MHz fixed */
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
-static unsigned int heartbeat = DEFAULT_HEARTBEAT;
+static unsigned int heartbeat;
 
 static DEFINE_SPINLOCK(io_lock);
 static void __iomem	*wdt_base;
-- 
2.15.1
