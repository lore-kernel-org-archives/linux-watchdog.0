Return-path: <kesavan.abhilash@gmail.com>
Sender: Abhilash Kesavan <kesavan.abhilash@gmail.com>
From: Abhilash Kesavan <a.kesavan@samsung.com>
To: linux-watchdog@vger.kernel.org
Cc: wim@iguana.be,
	naveenkrishna.ch@gmail.com,
	linux@roeck-us.net
Subject: [PATCH] watchdog: s3c2410_wdt: Fix the mask bit offset for Exynos7
Date: Fri, 17 Oct 2014 21:42:53 +0530
Message-Id: <1413562373-12734-1-git-send-email-a.kesavan@samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

The watchdog mask bit offset listed for Exynos7 is incorrect.
Fix this.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/watchdog/s3c2410_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 8532c3e..1626dc6 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -161,7 +161,7 @@ static const struct s3c2410_wdt_variant drv_data_exynos5420 = {
 static const struct s3c2410_wdt_variant drv_data_exynos7 = {
 	.disable_reg = EXYNOS5_WDT_DISABLE_REG_OFFSET,
 	.mask_reset_reg = EXYNOS5_WDT_MASK_RESET_REG_OFFSET,
-	.mask_bit = 0,
+	.mask_bit = 23,
 	.rst_stat_reg = EXYNOS5_RST_STAT_REG_OFFSET,
 	.rst_stat_bit = 23,	/* A57 WDTRESET */
 	.quirks = QUIRK_HAS_PMU_CONFIG | QUIRK_HAS_RST_STAT,
-- 
1.7.9.5
