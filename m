Return-Path: <Jayachandran.Nair@cavium.com>
Return-path: <Jayachandran.Nair@cavium.com>
From: Jayachandran C <jnair@caviumnetworks.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Cc: Fu Wei <fu.wei@linaro.org>,
	linux-kernel@vger.kernel.org,
	Jayachandran C <jnair@caviumnetworks.com>
Subject: [PATCH] watchdog: sbsa: use 32-bit read for WCV
Date: Wed, 28 Feb 2018 02:52:20 -0800
Message-Id: <1519815140-5336-1-git-send-email-jnair@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

According to SBSA spec v3.1 section 5.3:
  All registers are 32 bits in size and should be accessed using
  32-bit reads and writes. If an access size other than 32 bits
  is used then the results are IMPLEMENTATION DEFINED.
  [...]
  The Generic Watchdog is little-endian

The current code uses readq to read the watchdog compare register
which does a 64-bit access. This fails on ThunderX2 which does not
implement 64-bit access to this register.

Fix this by using lo_hi_readq() that does two 32-bit reads.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 drivers/watchdog/sbsa_gwdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 316c2eb..e8bd988 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -50,6 +50,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -159,7 +160,7 @@ static unsigned int sbsa_gwdt_get_timeleft(struct watchdog_device *wdd)
 	    !(readl(gwdt->control_base + SBSA_GWDT_WCS) & SBSA_GWDT_WCS_WS0))
 		timeleft += readl(gwdt->control_base + SBSA_GWDT_WOR);
 
-	timeleft += readq(gwdt->control_base + SBSA_GWDT_WCV) -
+	timeleft += lo_hi_readq(gwdt->control_base + SBSA_GWDT_WCV) -
 		    arch_counter_get_cntvct();
 
 	do_div(timeleft, gwdt->clk);
-- 
2.7.4
