Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933399AbdCKRnQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 11 Mar 2017 12:43:16 -0500
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] watchdog: s3c2410: Constify local structures
Date: Sat, 11 Mar 2017 19:42:53 +0200
Message-Id: <20170311174255.23327-2-krzk@kernel.org>
In-Reply-To: <20170311174255.23327-1-krzk@kernel.org>
References: <20170311174255.23327-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
modified so they can be made const to increase code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/s3c2410_wdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 6ed97596ca80..5eaec319e499 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -131,7 +131,7 @@ struct s3c2410_wdt {
 	unsigned long		wtdat_save;
 	struct watchdog_device	wdt_device;
 	struct notifier_block	freq_transition;
-	struct s3c2410_wdt_variant *drv_data;
+	const struct s3c2410_wdt_variant *drv_data;
 	struct regmap *pmureg;
 };
 
@@ -401,7 +401,7 @@ static const struct watchdog_ops s3c2410wdt_ops = {
 	.restart = s3c2410wdt_restart,
 };
 
-static struct watchdog_device s3c2410_wdd = {
+static const struct watchdog_device s3c2410_wdd = {
 	.info = &s3c2410_wdt_ident,
 	.ops = &s3c2410wdt_ops,
 	.timeout = S3C2410_WATCHDOG_DEFAULT_TIME,
@@ -507,15 +507,15 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 	return 0;
 }
 
-static inline struct s3c2410_wdt_variant *
+static inline const struct s3c2410_wdt_variant *
 s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
 		const struct of_device_id *match;
 		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
-		return (struct s3c2410_wdt_variant *)match->data;
+		return (const struct s3c2410_wdt_variant *)match->data;
 	} else {
-		return (struct s3c2410_wdt_variant *)
+		return (const struct s3c2410_wdt_variant *)
 			platform_get_device_id(pdev)->driver_data;
 	}
 }
-- 
2.9.3

