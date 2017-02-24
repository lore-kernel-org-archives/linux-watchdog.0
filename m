Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdBXVI0 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 16:08:26 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 6/7] watchdog: s3c2410: Simplify getting driver data
Date: Fri, 24 Feb 2017 23:07:45 +0200
Message-Id: <20170224210746.12459-6-krzk@kernel.org>
In-Reply-To: <20170224210746.12459-1-krzk@kernel.org>
References: <20170224210746.12459-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Simplify the flow in helper function for getting the driver data by
using of_device_get_match_data() and only one if() branch.

The code should be equivalent.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/s3c2410_wdt.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 5eaec319e499..d7ddee0668c3 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 #include <linux/delay.h>
@@ -510,14 +511,16 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 static inline const struct s3c2410_wdt_variant *
 s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 {
-	if (pdev->dev.of_node) {
-		const struct of_device_id *match;
-		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
-		return (const struct s3c2410_wdt_variant *)match->data;
-	} else {
-		return (const struct s3c2410_wdt_variant *)
-			platform_get_device_id(pdev)->driver_data;
+	const struct s3c2410_wdt_variant *variant;
+
+	variant = of_device_get_match_data(&pdev->dev);
+	if (!variant) {
+		/* Device matched by platform_device_id */
+		variant = (const struct s3c2410_wdt_variant *)
+			  platform_get_device_id(pdev)->driver_data;
 	}
+
+	return variant;
 }
 
 static int s3c2410wdt_probe(struct platform_device *pdev)
-- 
2.9.3

