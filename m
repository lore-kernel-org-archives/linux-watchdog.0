Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bon0057.outbound.protection.outlook.com ([157.56.111.57]:26992
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751456AbcADM6a (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Jan 2016 07:58:30 -0500
From: Fabio Estevam <fabio.estevam@nxp.com>
To: <wim@iguana.be>
CC: <linux@roeck-us.net>, <harald@ccbib.org>, <festevam@gmail.com>,
	<linux-watchdog@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH] watchdog: stmp3xxx: Remove unused variable
Date: Mon, 4 Jan 2016 10:26:28 -0200
Message-ID: <1451910388-7863-1-git-send-email-fabio.estevam@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Commit 8d2fa17151ea3 ("watchdog: stmp3xxx: Stop the watchdog on system
halt") introduced the following build warning:

drivers/watchdog/stmp3xxx_rtc_wdt.c: In function 'wdt_notify_sys':
drivers/watchdog/stmp3xxx_rtc_wdt.c:78:29: warning: unused variable 'pdata' [-Wunused-variable]

Remove the unused 'pdata' variable.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index dbe0372..9ad39f6 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -75,7 +75,6 @@ static int wdt_notify_sys(struct notifier_block *nb, unsigned long code,
 			  void *unused)
 {
 	struct device *dev = watchdog_get_drvdata(&stmp3xxx_wdd);
-	struct stmp3xxx_wdt_pdata *pdata = dev_get_platdata(dev);
 
 	switch (code) {
 	case SYS_DOWN:	/* keep enabled, system might crash while going down */
-- 
1.9.1

