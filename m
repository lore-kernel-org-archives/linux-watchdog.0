Return-Path: <lin.sunze@gmail.com>
Return-path: <lin.sunze@gmail.com>
From: SZ Lin <sz.lin@moxa.com>
To: wim@iguana.be
Cc: linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SZ Lin <sz.lin@moxa.com>
Subject: [PATCH] watchdog: moxart_wdt: Replace decimal permissions with 4 digit octal
Date: Sat, 29 Jul 2017 17:15:43 +0800
Message-Id: <20170729091543.11777-1-sz.lin@moxa.com>
List-ID: <linux-watchdog@vger.kernel.org>

ERROR: Use 4 digit octal (0777) not decimal permissions

This error was detected by checkpatch.pl

Signed-off-by: SZ Lin <sz.lin@moxa.com>
---
 drivers/watchdog/moxart_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 2c4a73d1e214..05684aa89b88 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -170,7 +170,7 @@ static struct platform_driver moxart_wdt_driver = {
 };
 module_platform_driver(moxart_wdt_driver);
 
-module_param(heartbeat, int, 0);
+module_param(heartbeat, int, 0000);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds");
 
 MODULE_DESCRIPTION("MOXART watchdog driver");
-- 
2.13.3
