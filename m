Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:30339 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933724Ab3E1JZz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 May 2013 05:25:55 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] wdrtas: don't use custom version of print_hex_dump
Date: Tue, 28 May 2013 12:25:49 +0300
Message-Id: <1369733149-25487-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Kernel has nice helpers to dump buffers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/watchdog/wdrtas.c | 29 +++--------------------------
 1 file changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index 0a77655..3045deb 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -162,31 +162,6 @@ static void wdrtas_timer_stop(void)
 }
 
 /**
- * wdrtas_log_scanned_event - logs an event we received during keepalive
- *
- * wdrtas_log_scanned_event prints a message to the log buffer dumping
- * the results of the last event-scan call
- */
-static void wdrtas_log_scanned_event(void)
-{
-	int i;
-
-	for (i = 0; i < WDRTAS_LOGBUFFER_LEN; i += 16)
-		pr_info("dumping event (line %i/%i), data = "
-			"%02x %02x %02x %02x  %02x %02x %02x %02x   "
-			"%02x %02x %02x %02x  %02x %02x %02x %02x\n",
-			(i / 16) + 1, (WDRTAS_LOGBUFFER_LEN / 16),
-			wdrtas_logbuffer[i + 0], wdrtas_logbuffer[i + 1],
-			wdrtas_logbuffer[i + 2], wdrtas_logbuffer[i + 3],
-			wdrtas_logbuffer[i + 4], wdrtas_logbuffer[i + 5],
-			wdrtas_logbuffer[i + 6], wdrtas_logbuffer[i + 7],
-			wdrtas_logbuffer[i + 8], wdrtas_logbuffer[i + 9],
-			wdrtas_logbuffer[i + 10], wdrtas_logbuffer[i + 11],
-			wdrtas_logbuffer[i + 12], wdrtas_logbuffer[i + 13],
-			wdrtas_logbuffer[i + 14], wdrtas_logbuffer[i + 15]);
-}
-
-/**
  * wdrtas_timer_keepalive - resets watchdog timer to keep system alive
  *
  * wdrtas_timer_keepalive restarts the watchdog timer by calling the
@@ -205,7 +180,9 @@ static void wdrtas_timer_keepalive(void)
 		if (result < 0)
 			pr_err("event-scan failed: %li\n", result);
 		if (result == 0)
-			wdrtas_log_scanned_event();
+			print_hex_dump(KERN_INFO, "dumping event, data: ",
+				DUMP_PREFIX_OFFSET, 16, 1,
+				wdrtas_logbuffer, WDRTAS_LOGBUFFER_LEN, false);
 	} while (result == 0);
 }
 
-- 
1.8.2.rc0.22.gb3600c3

