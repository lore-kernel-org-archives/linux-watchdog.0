Return-path: <s.christ@phytec.de>
From: Stefan Christ <s.christ@phytec.de>
To: linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: [PATCH v2] watchdog: da9063_wdt: don't trigger watchdog too fast
Date: Wed, 6 Jul 2016 10:40:11 +0200
Message-Id: <1467794411-11155-1-git-send-email-s.christ@phytec.de>
List-ID: <linux-watchdog@vger.kernel.org>

Triggering the watchdog faster than T_WDMIN=256ms leads to resets of the
DA9063 chip. The datasheet says that the watchdog must only be triggered
in the timeframe T_WDMIN to T_WDMAX. The T_WDMAX is configured in the
driver.

Signed-off-by: Stefan Christ <s.christ@phytec.de>
---
v2: use internal kernel API 'min_hw_heartbeat_ms' instead of driver specific
    implementation.

Hi,

this is a follow up patch to the patch

    [RFC 1/6] watchdog: da9063_wdt: don't trigger watchdog too fast

in my RFC patch series. Using the internal kernel watchdog API also makes my
second patch

    [RFC 2/6] watchdog: da9063_wdt: use delayed work to trigger

obsolete, because the kernel API uses a delayed worker already.

Kind regards,
    Stefan Christ
---
 drivers/watchdog/da9063_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index a100f64..5d6b4e5 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -34,6 +34,7 @@ static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
 #define DA9063_WDT_MIN_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MIN]
 #define DA9063_WDT_MAX_TIMEOUT		wdt_timeout[DA9063_TWDSCALE_MAX]
 #define DA9063_WDG_TIMEOUT		wdt_timeout[3]
+#define DA9063_RESET_PROTECTION_MS	256
 
 struct da9063_watchdog {
 	struct da9063 *da9063;
@@ -171,6 +172,7 @@ static int da9063_wdt_probe(struct platform_device *pdev)
 	wdt->wdtdev.ops = &da9063_watchdog_ops;
 	wdt->wdtdev.min_timeout = DA9063_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = DA9063_WDT_MAX_TIMEOUT;
+	wdt->wdtdev.min_hw_heartbeat_ms = DA9063_RESET_PROTECTION_MS;
 	wdt->wdtdev.timeout = DA9063_WDG_TIMEOUT;
 	wdt->wdtdev.parent = &pdev->dev;
 
-- 
1.9.1
