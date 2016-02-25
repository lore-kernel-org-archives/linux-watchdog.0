Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:36255 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933545AbcBYSby (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Feb 2016 13:31:54 -0500
Received: by mail-io0-f193.google.com with SMTP id b188so6393403iof.3
        for <linux-watchdog@vger.kernel.org>; Thu, 25 Feb 2016 10:31:53 -0800 (PST)
From: Sylvain Lemieux <slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	stigge@antcom.de, vz@mleia.com
Subject: [PATCH v4 1/6] watchdog: pnx4008: update logging during power-on
Date: Thu, 25 Feb 2016 13:31:35 -0500
Message-Id: <1456425100-28136-2-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456425100-28136-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

There is no need add the driver name in the text to display
on the console during the power-on:
pnx4008-watchdog 4003c000.watchdog: PNX4008 Watchdog Timer: heartbeat 19 sec

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
Changes from v3 to v4:
- none.

Changes from v2 to v3:
- none.

Changes from v1 to v2:
- new patch in v2.

 drivers/watchdog/pnx4008_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 313cd1c..88264a2 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -178,8 +178,7 @@ static int pnx4008_wdt_probe(struct platform_device *pdev)
 		goto disable_clk;
 	}
 
-	dev_info(&pdev->dev, "PNX4008 Watchdog Timer: heartbeat %d sec\n",
-		 pnx4008_wdd.timeout);
+	dev_info(&pdev->dev, "heartbeat %d sec\n", pnx4008_wdd.timeout);
 
 	return 0;
 
-- 
1.8.3.1

