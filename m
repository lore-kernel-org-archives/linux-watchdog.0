Return-path: <krzk@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Kukjin Kim <kgene@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/7] watchdog: s3c2410: Add prefix to local function
Date: Fri, 24 Feb 2017 23:07:43 +0200
Message-Id: <20170224210746.12459-4-krzk@kernel.org>
In-Reply-To: <20170224210746.12459-1-krzk@kernel.org>
References: <20170224210746.12459-1-krzk@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Functions marked static inline might not be inlined so a driver-specific
prefix for function name helps when looking through call backtrace.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/s3c2410_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index f7aad19d20ff..a031842ffcb0 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -507,9 +507,8 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 	return 0;
 }
 
-/* s3c2410_get_wdt_driver_data */
 static inline struct s3c2410_wdt_variant *
-get_wdt_drv_data(struct platform_device *pdev)
+s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
@@ -541,7 +540,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	spin_lock_init(&wdt->lock);
 	wdt->wdt_device = s3c2410_wdd;
 
-	wdt->drv_data = get_wdt_drv_data(pdev);
+	wdt->drv_data = s3c2410_get_wdt_drv_data(pdev);
 	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
 		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
 						"samsung,syscon-phandle");
-- 
2.9.3
