Return-Path: <arvind.yadav.cs@gmail.com>
Return-path: <arvind.yadav.cs@gmail.com>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: sp805: constify amba_id
Date: Wed, 23 Aug 2017 22:04:08 +0530
Message-Id: <5ed165409809ce4f450748e667a12bdcebd6b3f4.1503505965.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

amba_id are not supposed to change at runtime. All functions
working with const amba_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/sp805_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index e7a715e..03805bc 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -281,7 +281,7 @@ static int __maybe_unused sp805_wdt_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
 		sp805_wdt_resume);
 
-static struct amba_id sp805_wdt_ids[] = {
+static const struct amba_id sp805_wdt_ids[] = {
 	{
 		.id	= 0x00141805,
 		.mask	= 0x00ffffff,
-- 
2.7.4
