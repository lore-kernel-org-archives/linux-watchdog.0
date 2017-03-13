Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751330AbdCMTHo (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 13 Mar 2017 15:07:44 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] watchdog: s3c2410: Constify local structures
Date: Mon, 13 Mar 2017 21:07:24 +0200
Message-Id: <20170313190726.2988-2-krzk@kernel.org>
In-Reply-To: <20170313190726.2988-1-krzk@kernel.org>
References: <20170313190726.2988-1-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
modified so they can be made const to increase code safeness.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/watchdog/s3c2410_wdt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 6ed97596ca80..52b66bcdd1ef 100644
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
@@ -507,7 +507,7 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
 	return 0;
 }
 
-static inline struct s3c2410_wdt_variant *
+static inline const struct s3c2410_wdt_variant *
 s3c2410_get_wdt_drv_data(struct platform_device *pdev)
 {
 	if (pdev->dev.of_node) {
-- 
2.9.3

