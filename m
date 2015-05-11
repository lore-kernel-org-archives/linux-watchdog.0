Return-path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-watchdog@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>,
	"Wim Van Sebroeck" <wim@iguana.be>
CC: Andrew Bresticker <abrestic@chromium.org>, James Hogan
	<james.hogan@imgtec.com>, James Hartley <james.hartley@imgtec.com>, "Naidu
 Tellapati" <naidu.tellapati@imgtec.com>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH 2/2] watchdog: imgpdc: Add some documentation about the timeout
Date: Mon, 11 May 2015 14:41:05 -0300
Message-ID: <1431366065-16281-3-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

This watchdog hardware can be configured in terms of power-of-two
clock cycles. Therefore, the watchdog timeout configured by the user
will be rounded-up to the next possible hardware timeout.

This commit adds a comment explaining this.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/watchdog/imgpdc_wdt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 56b8ebc..0f73621 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -9,6 +9,35 @@
  *
  * Based on drivers/watchdog/sunxi_wdt.c Copyright (c) 2013 Carlo Caione
  *                                                     2012 Henrik Nordstrom
+ *
+ * Notes
+ * -----
+ * The timeout value is rounded to the next power of two clock cycles.
+ * This is configured using the PDC_WDT_CONFIG register, according to this
+ * formula:
+ *
+ *     timeout = 2^(delay + 1) clock cycles
+ *
+ * Where 'delay' is the value written in PDC_WDT_CONFIG register.
+ *
+ * Therefore, the hardware only allows to program watchdog timeouts, expressed
+ * as a power of two number of watchdog clock cycles. The current implementation
+ * guarantees that the actual watchdog timeout will be _at least_ the value
+ * programmed in the imgpdg_wdt driver.
+ *
+ * The following table shows how the user-configured timeout relates
+ * to the actual hardware timeout (watchdog clock @ 40000 Hz):
+ *
+ * input timeout | WD_DELAY | actual timeout
+ * -----------------------------------
+ *      10       |   18     |  13 seconds
+ *      20       |   19     |  26 seconds
+ *      30       |   20     |  52 seconds
+ *      60       |   21     |  104 seconds
+ *
+ * Albeit coarse, this granularity would suffice most watchdog uses.
+ * If the platform allows it, the user should be able to change the watchdog
+ * clock rate and achieve a finer timeout granularity.
  */
 
 #include <linux/clk.h>
-- 
2.3.3
