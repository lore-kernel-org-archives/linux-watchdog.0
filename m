Return-Path: <hauke@hauke-m.de>
Return-path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	john@phrozen.org,
	dev@kresin.me,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 1/3] wdt: lantiq: update register names to better match spec
Date: Thu, 13 Sep 2018 23:32:09 +0200
Message-Id: <20180913213211.16781-2-hauke@hauke-m.de>
In-Reply-To: <20180913213211.16781-1-hauke@hauke-m.de>
References: <20180913213211.16781-1-hauke@hauke-m.de>
List-ID: <linux-watchdog@vger.kernel.org>

Some of the names of the bits were confusing to me.
Now the bits share the same prefix as the register they are set on.

The LTQ_WDT_CR_PWL register (bits 26:25) is the pre warning limit and it
does not turn anything on. It has 4 possible divers 1/2, 1/4, 1/8 and
1/16, this drivers only uses 1/16.
The LTQ_WDT_CR_CLKDIV register bits(25:24) is only configuring a clock
divers and do not turn any thing on too, all possible values are valid
dividers.
Using the LTQ_WDT_SR prefix is also wrong these bits are used in the
LTQ_WDT_CR registers, SR is the status register which is read only.

This uses GENMASK where it is a mask and it uses shifts when a value is
written to some bits.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/lantiq_wdt.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 7f43cefa0eae..a086005fbaac 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
+#include <linux/bitops.h>
 #include <linux/watchdog.h>
 #include <linux/of_platform.h>
 #include <linux/uaccess.h>
@@ -40,18 +41,19 @@
  * essentially the following two magic passwords need to be written to allow
  * IO access to the WDT core
  */
-#define LTQ_WDT_PW1		0x00BE0000
-#define LTQ_WDT_PW2		0x00DC0000
+#define LTQ_WDT_CR_PW1		0x00BE0000
+#define LTQ_WDT_CR_PW2		0x00DC0000
+
+#define LTQ_WDT_CR		0x0		/* watchdog control register */
+#define  LTQ_WDT_CR_GEN		BIT(31)		/* enable bit */
+/* Pre-warning limit set to 1/16 of max WDT period */
+#define  LTQ_WDT_CR_PWL		(0x3 << 26)
+/* set clock divider to 0x40000 */
+#define  LTQ_WDT_CR_CLKDIV	(0x3 << 24)
+#define  LTQ_WDT_CR_PW_MASK	GENMASK(23, 16)	/* Password field */
+#define  LTQ_WDT_CR_MAX_TIMEOUT	((1 << 16) - 1)	/* The reload field is 16 bit */
 
-#define LTQ_WDT_CR		0x0	/* watchdog control register */
-#define LTQ_WDT_SR		0x8	/* watchdog status register */
-
-#define LTQ_WDT_SR_EN		(0x1 << 31)	/* enable bit */
-#define LTQ_WDT_SR_PWD		(0x3 << 26)	/* turn on power */
-#define LTQ_WDT_SR_CLKDIV	(0x3 << 24)	/* turn on clock and set */
-						/* divider to 0x40000 */
 #define LTQ_WDT_DIVIDER		0x40000
-#define LTQ_MAX_TIMEOUT		((1 << 16) - 1)	/* the reload field is 16 bit */
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 
@@ -68,26 +70,26 @@ ltq_wdt_enable(void)
 {
 	unsigned long int timeout = ltq_wdt_timeout *
 			(ltq_io_region_clk_rate / LTQ_WDT_DIVIDER) + 0x1000;
-	if (timeout > LTQ_MAX_TIMEOUT)
-		timeout = LTQ_MAX_TIMEOUT;
+	if (timeout > LTQ_WDT_CR_MAX_TIMEOUT)
+		timeout = LTQ_WDT_CR_MAX_TIMEOUT;
 
 	/* write the first password magic */
-	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
 	/* write the second magic plus the configuration and new timeout */
-	ltq_w32(LTQ_WDT_SR_EN | LTQ_WDT_SR_PWD | LTQ_WDT_SR_CLKDIV |
-		LTQ_WDT_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
+	ltq_w32(LTQ_WDT_CR_GEN | LTQ_WDT_CR_PWL | LTQ_WDT_CR_CLKDIV |
+		LTQ_WDT_CR_PW2 | timeout, ltq_wdt_membase + LTQ_WDT_CR);
 }
 
 static void
 ltq_wdt_disable(void)
 {
 	/* write the first password magic */
-	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
+	ltq_w32(LTQ_WDT_CR_PW1, ltq_wdt_membase + LTQ_WDT_CR);
 	/*
 	 * write the second password magic with no config
 	 * this turns the watchdog off
 	 */
-	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
+	ltq_w32(LTQ_WDT_CR_PW2, ltq_wdt_membase + LTQ_WDT_CR);
 }
 
 static ssize_t
-- 
2.11.0
