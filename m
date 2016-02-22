Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33991 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751014AbcBVQ4J (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Feb 2016 11:56:09 -0500
Received: by mail-io0-f175.google.com with SMTP id 9so185150968iom.1
        for <linux-watchdog@vger.kernel.org>; Mon, 22 Feb 2016 08:56:09 -0800 (PST)
From: slemieux.tyco@gmail.com
To: linux-arm-kernel@lists.infradead.org, wim@iguana.be,
	manabian@gmail.com
Cc: linux-watchdog@vger.kernel.org, linux@roeck-us.net,
	stigge@antcom.de, vz@mleia.com
Subject: [PATCH v2 1/5] watchdog: pnx4008: update logging during power-on
Date: Mon, 22 Feb 2016 11:55:39 -0500
Message-Id: <1456160143-26761-2-git-send-email-slemieux.tyco@gmail.com>
In-Reply-To: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
References: <1456160143-26761-1-git-send-email-slemieux.tyco@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Sylvain Lemieux <slemieux@tycoint.com>

There is no need add the driver name in the text to display
on the console during the power-on:
pnx4008-watchdog 4003c000.watchdog: PNX4008 Watchdog Timer: heartbeat 19 sec

Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
---
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

