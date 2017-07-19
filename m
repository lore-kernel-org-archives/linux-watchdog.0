Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:39791 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752808AbdGSI2H (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 19 Jul 2017 04:28:07 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Takeshi Kihara <takeshi.kihara.df@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/5] watchdog: renesas_wdt: add another divider option
Date: Wed, 19 Jul 2017 10:27:55 +0200
Message-Id: <20170719082755.21733-6-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170719082755.21733-1-wsa+renesas@sang-engineering.com>
References: <20170719082755.21733-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

If we set RWTCSRB to 0, we can gain 4096 as another divider value. This
is supported by all R-Car Gen2 and Gen3 devices which we aim to support.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 599ba5aaa0536f..e3f204bb8802aa 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -23,21 +23,22 @@
 #define RWTCSRA_WOVF	BIT(4)
 #define RWTCSRA_WRFLG	BIT(5)
 #define RWTCSRA_TME	BIT(7)
+#define RWTCSRB		8
 
 #define RWDT_DEFAULT_TIMEOUT 60U
 
 /*
  * In probe, clk_rate is checked to be not more than 16 bit * biggest clock
- * divider (10 bits). d is only a factor to fully utilize the WDT counter and
+ * divider (12 bits). d is only a factor to fully utilize the WDT counter and
  * will not exceed its 16 bits. Thus, no overflow, we stay below 32 bits.
  */
 #define MUL_BY_CLKS_PER_SEC(p, d) \
 	DIV_ROUND_UP((d) * (p)->clk_rate, clk_divs[(p)->cks])
 
-/* d is 16 bit, clk_divs 10 bit -> no 32 bit overflow */
+/* d is 16 bit, clk_divs 12 bit -> no 32 bit overflow */
 #define DIV_BY_CLKS_PER_SEC(p, d) ((d) * clk_divs[(p)->cks] / (p)->clk_rate)
 
-static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024 };
+static const unsigned int clk_divs[] = { 1, 4, 16, 32, 64, 128, 1024, 4096 };
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0);
@@ -77,6 +78,7 @@ static int rwdt_start(struct watchdog_device *wdev)
 
 	clk_prepare_enable(priv->clk);
 
+	rwdt_write(priv, 0, RWTCSRB);
 	rwdt_write(priv, priv->cks, RWTCSRA);
 	rwdt_init_timeout(wdev);
 
-- 
2.11.0

