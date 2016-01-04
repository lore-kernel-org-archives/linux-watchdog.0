Return-path: <fabio.estevam@nxp.com>
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <wim@iguana.be>
CC: <linux@roeck-us.net>, <harald@ccbib.org>, <festevam@gmail.com>,
	<linux-watchdog@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2] watchdog: stmp3xxx: Remove unused variables
Date: Mon, 4 Jan 2016 10:30:47 -0200
Message-ID: <1451910647-9313-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Commit 8d2fa17151ea3 ("watchdog: stmp3xxx: Stop the watchdog on system
halt") introduced the following build warning:

drivers/watchdog/stmp3xxx_rtc_wdt.c: In function 'wdt_notify_sys':
drivers/watchdog/stmp3xxx_rtc_wdt.c:78:29: warning: unused variable 'pdata' [-Wunused-variable]

Remove the unused 'pdata' and 'dev' variables.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- Also remove the 'dev' variable.

 drivers/watchdog/stmp3xxx_rtc_wdt.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index dbe0372..d8b11eb 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -74,9 +74,6 @@ static struct watchdog_device stmp3xxx_wdd = {
 static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
 			  void *unused)
 {
-	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
-	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
-
 	switch (code) {
 	case SYS_DOWN:	/* keep enabled, system might crash while going down */
 		break;
-- 
1.9.1
