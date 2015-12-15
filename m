Return-path: <ukl@pengutronix.de>
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel@pengutronix.de,
	linux-watchdog@vger.kernel.org,
	Lars Poeschel <poeschel@lemonage.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 1/2] watchdog: omap: don't disable runtime pm before starting device
Date: Tue, 15 Dec 2015 11:37:40 +0100
Message-Id: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

omap_wdt_start calls pm_runtime_get_sync so dropping a reference just
before calling omap_wdt_start doesn't make much sense. Moreover there is
no point to use the synchronous variant of pm_runtime_put because the
driver doesn't care if the clock is disabled before or after
omap_wdt_probe returns.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/omap_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 7abd6988d94a..af8947429c91 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -282,11 +282,11 @@ static int omap_wdt_probe(struct platform_device *pdev)
 		readl_relaxed(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		wdev->wdog.timeout);
 
-	pm_runtime_put_sync(wdev->dev);
-
 	if (early_enable)
 		omap_wdt_start(&wdev->wdog);
 
+	pm_runtime_put(wdev->dev);
+
 	return 0;
 }
 
-- 
2.6.2
