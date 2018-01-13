Return-Path: <elfring@users.sourceforge.net>
Return-path: <elfring@users.sourceforge.net>
To: linux-watchdog@vger.kernel.org, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <linux@roeck-us.net>, Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] watchdog/ie6xx_wdt: Combine two seq_printf() calls into one
 call in ie6xx_wdt_dbg_show()
Message-ID: <3b9880f2-2c21-8574-7659-74bc8e211852@users.sourceforge.net>
Date: Sat, 13 Jan 2018 13:50:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 Jan 2018 13:45:35 +0100

Some data were printed into a sequence by two separate function calls.
Print the same data by a single function call instead.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/watchdog/ie6xx_wdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 78c2541f5d52..f2963cb21df7 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -205,10 +205,8 @@ static int ie6xx_wdt_dbg_show(struct seq_file *s, void *unused)
 		inw(ie6xx_wdt_data.sch_wdtba + WDTCR));
 	seq_printf(s, "DCR   = 0x%08x\n",
 		inl(ie6xx_wdt_data.sch_wdtba + DCR));
-	seq_printf(s, "WDTLR = 0x%08x\n",
-		inw(ie6xx_wdt_data.sch_wdtba + WDTLR));
-
-	seq_printf(s, "\n");
+	seq_printf(s, "WDTLR = 0x%08x\n\n",
+		   inw(ie6xx_wdt_data.sch_wdtba + WDTLR));
 	return 0;
 }
 
-- 
2.15.1
