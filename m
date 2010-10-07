From: David Daney <ddaney@caviumnetworks.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org
Cc: David Daney <ddaney@caviumnetworks.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 13/14] watchdog: octeon-wdt: Use I/O clock rate for timing calculations.
Date: Thu,  7 Oct 2010 16:03:52 -0700
Message-Id: <1286492633-26885-14-git-send-email-ddaney@caviumnetworks.com>
In-Reply-To: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
References: <1286492633-26885-1-git-send-email-ddaney@caviumnetworks.com>
Return-Path: <David.Daney@caviumnetworks.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The creation of the I/O clock domain requires some adjustments.  Since
the watchdog counters are clocked by the I/O clock, use its rate for
timing calculations.

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/octeon-wdt-main.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 2a41017..fb0aed0 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -477,7 +477,7 @@ static void octeon_wdt_calc_parameters(int t)
 
 	countdown_reset = periods > 2 ? periods - 2 : 0;
 	heartbeat = t;
-	timeout_cnt = ((octeon_get_clock_rate() >> 8) * timeout_sec) >> 8;
+	timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * timeout_sec) >> 8;
 }
 
 static int octeon_wdt_set_heartbeat(int t)
@@ -676,7 +676,7 @@ static int __init octeon_wdt_init(void)
 	max_timeout_sec = 6;
 	do {
 		max_timeout_sec--;
-		timeout_cnt = ((octeon_get_clock_rate() >> 8) * max_timeout_sec) >> 8;
+		timeout_cnt = ((octeon_get_io_clock_rate() >> 8) * max_timeout_sec) >> 8;
 	} while (timeout_cnt > 65535);
 
 	BUG_ON(timeout_cnt == 0);
-- 
1.7.2.3
