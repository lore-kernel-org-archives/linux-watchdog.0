Return-Path: <monstr@monstr.eu>
Return-path: <monstr@monstr.eu>
Sender: Michal Simek <monstr@monstr.eu>
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org,
	monstr@monstr.eu
Cc: Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 1/2] watchdog: cadence_wdt: Enable access to module parameters
Date: Fri,  4 Aug 2017 09:39:16 +0200
Message-Id: <6c3cef5b847f315f5fc1eb891b040e33719e88c7.1501832354.git.michal.simek@xilinx.com>
List-ID: <linux-watchdog@vger.kernel.org>

Give read access to module parameters to all and write access to root.
This change also improves driver error path testing.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Please let me know what you think - I can use macros from stat.h if
required

---
 drivers/watchdog/cadence_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 05c000081e9d..dadd3b0c2d49 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -52,12 +52,12 @@
 static int wdt_timeout;
 static int nowayout = WATCHDOG_NOWAYOUT;
 
-module_param(wdt_timeout, int, 0);
+module_param(wdt_timeout, int, 0644);
 MODULE_PARM_DESC(wdt_timeout,
 		 "Watchdog time in seconds. (default="
 		 __MODULE_STRING(CDNS_WDT_DEFAULT_TIMEOUT) ")");
 
-module_param(nowayout, int, 0);
+module_param(nowayout, int, 0644);
 MODULE_PARM_DESC(nowayout,
 		 "Watchdog cannot be stopped once started (default="
 		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-- 
1.9.1
