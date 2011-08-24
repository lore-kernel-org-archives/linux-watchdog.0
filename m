From: John Crispin <blogic@openwrt.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: [PATCH 3/8] MIPS: lantiq: fix watchdogs timeout handling
Date: Wed, 24 Aug 2011 10:31:39 +0200
Message-Id: <1314174704-15549-4-git-send-email-blogic@openwrt.org>
In-Reply-To: <1314174704-15549-1-git-send-email-blogic@openwrt.org>
References: <1314174704-15549-1-git-send-email-blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The enable function was using the global timeout variable for local operations.
This resulted in the value of the global variable being corrupted, thus
breaking the code.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Cc: linux-watchdog@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 drivers/watchdog/lantiq_wdt.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 7d82ada..102aed0 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -51,16 +51,16 @@ static int ltq_wdt_ok_to_close;
 static void
 ltq_wdt_enable(void)
 {
-	ltq_wdt_timeout = ltq_wdt_timeout *
+	unsigned long int timeout = ltq_wdt_timeout *
 			(ltq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
-	if (ltq_wdt_timeout > LTQ_MAX_TIMEOUT)
-		ltq_wdt_timeout = LTQ_MAX_TIMEOUT;
+	if (timeout > LTQ_MAX_TIMEOUT)
+		timeout = LTQ_MAX_TIMEOUT;
 
 	/* write the first password magic */
 	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
 	/* write the second magic plus the configuration and new timeout */
 	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
-		LTQ_WDT_PW2 | ltq_wdt_timeout, ltq_wdt_membase + LTQ_WDT_CR);
+		LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
 }
 
 static void
-- 
1.7.2.3
