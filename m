Return-Path: <andrew@aj.id.au>
Return-path: <andrew@aj.id.au>
From: Andrew Jeffery <andrew@aj.id.au>
To: linux-watchdog@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>,
	wim@iguana.be,
	linux@roeck-us.net,
	joel@jms.id.au,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	linux-aspeed@lists.ozlabs.org,
	ryan_chen@aspeedtech.com
Subject: [PATCH v2 1/4] watchdog: aspeed: Retain watchdog enabled state
Date: Wed, 20 Sep 2017 15:00:17 +0930
Message-Id: <20170920053020.6860-2-andrew@aj.id.au>
In-Reply-To: <20170920053020.6860-1-andrew@aj.id.au>
References: <20170920053020.6860-1-andrew@aj.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

An unintended post-condition of probe() is that the watchdog is
disabled. This behaviour was introduced by an unnecessary write to the
control register to configure the hardware based on the devicetree. The
write is unnecessary because the cached control value that is
manipulated by the code parsing the devicetree is eventually written by
aspeed_wdt_enable(), which is when we care how the control register
should be configured.

Remove the write to restore expected behaviour.

Fixes: b7f0b8ad25f3 ("drivers/watchdog: ASPEED reference dev tree properties for config")
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/watchdog/aspeed_wdt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 79cc766cd30f..6c6dd3f4c48d 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -243,9 +243,13 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	if (of_property_read_bool(np, "aspeed,external-signal"))
 		wdt->ctrl |= WDT_CTRL_WDT_EXT;
 
-	writel(wdt->ctrl, wdt->base + WDT_CTRL);
-
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
+		/*
+		 * The watchdog is running, but invoke aspeed_wdt_start() to
+		 * write wdt->ctrl to WDT_CTRL to ensure the watchdog's
+		 * configuration conforms to the driver's expectations.
+		 * Primarily, ensure we're using the 1MHz clock source.
+		 */
 		aspeed_wdt_start(&wdt->wdd);
 		set_bit(WDOG_HW_RUNNING, &wdt->wdd.status);
 	}
-- 
2.11.0
