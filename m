Return-path: <wsa@the-dreams.de>
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 5/6] watchdog: atlas7_wdt: test clock rate to avoid division by 0
Date: Wed,  2 Mar 2016 23:33:36 +0100
Message-Id: <1456958018-7849-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
References: <1456958018-7849-1-git-send-email-wsa@the-dreams.de>
List-ID: <linux-watchdog@vger.kernel.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The clk API may return 0 on clk_get_rate, so we should check the result before
using it as a divisor.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Should go individually via subsystem tree.

 drivers/watchdog/atlas7_wdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
index df6d9242a31958..ed80734befae16 100644
--- a/drivers/watchdog/atlas7_wdt.c
+++ b/drivers/watchdog/atlas7_wdt.c
@@ -154,6 +154,11 @@ static int atlas7_wdt_probe(struct platform_device *pdev)
 	writel(0, wdt->base + ATLAS7_WDT_CNT_CTRL);
 
 	wdt->tick_rate = clk_get_rate(clk);
+	if (!wdt->tick_rate) {
+		ret = -EINVAL;
+		goto err1;
+	}
+
 	wdt->clk = clk;
 	atlas7_wdd.min_timeout = 1;
 	atlas7_wdd.max_timeout = UINT_MAX / wdt->tick_rate;
-- 
2.7.0
