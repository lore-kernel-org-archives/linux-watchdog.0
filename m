Return-Path: <arvind.yadav.cs@gmail.com>
Return-path: <arvind.yadav.cs@gmail.com>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: wim@iguana.be,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: cadence_wdt: make of_device_ids const.
Date: Tue, 20 Jun 2017 11:04:26 +0530
Message-Id: <368e831c5ca264a6314361ca5b8a31cac00ea8ea.1497935866.git.arvind.yadav.cs@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

of_device_ids are not supposed to change at runtime. All functions
working with of_device_ids provided by <linux/of.h> work with const
of_device_ids. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   1962	    612	      4	   2578	    a12	drivers/watchdog/cadence_wdt.o

File size after constify cdns_wdt_of_match:
   text	   data	    bss	    dec	    hex	filename
   2378	    196	      4	   2578	    a12	drivers/watchdog/cadence_wdt.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/watchdog/cadence_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 8d61e8b..4824b0a 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -458,7 +458,7 @@ static int __maybe_unused cdns_wdt_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(cdns_wdt_pm_ops, cdns_wdt_suspend, cdns_wdt_resume);
 
-static struct of_device_id cdns_wdt_of_match[] = {
+static const struct of_device_id cdns_wdt_of_match[] = {
 	{ .compatible = "cdns,wdt-r1p2", },
 	{ /* end of table */ }
 };
-- 
1.9.1
