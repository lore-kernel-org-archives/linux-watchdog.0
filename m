Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32898 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbcEFM7w (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 May 2016 08:59:52 -0400
From: Muhammad Falak R Wani <falakreyaz@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] watchdog: shwdt: Use setup_timer()
Date: Fri,  6 May 2016 18:29:41 +0530
Message-Id: <1462539581-26207-2-git-send-email-falakreyaz@gmail.com>
In-Reply-To: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com>
References: <1462539581-26207-1-git-send-email-falakreyaz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The function setup_timer combines the initialization of a timer with
the initialization of the timer's function and data fields.
The multiline code for timer initialization is now replaced
with function setup_timer.

Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>
---
 drivers/watchdog/shwdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index f908121..517a733 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -275,9 +275,7 @@ static int sh_wdt_probe(struct platform_device *pdev)
 		return rc;
 	}
 
-	init_timer(&wdt->timer);
-	wdt->timer.function	= sh_wdt_ping;
-	wdt->timer.data		= (unsigned long)wdt;
+	setup_timer(&wdt->timer, sh_wdt_ping, (unsigned long)wdt);
 	wdt->timer.expires	= next_ping_period(clock_division_ratio);
 
 	dev_info(&pdev->dev, "initialized.\n");
-- 
1.9.1

