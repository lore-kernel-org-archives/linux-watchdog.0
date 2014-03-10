Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40188 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbaCJU2U (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 10 Mar 2014 16:28:20 -0400
Date: Mon, 10 Mar 2014 21:28:17 +0100
From: Jean Delvare <jdelvare@suse.de>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] watchdog: iTCO_wdt: Fix the parent device
Message-ID: <20140310212817.08adda85@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The watchdog's parent is iTCO_wdt (the platform device) not lpc_ich
(the PCI device.) Setting the parent right makes it much easier for
the user to figure out which driver/module is handling the watchdog
device node.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
---
 drivers/watchdog/iTCO_wdt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.14-rc5.orig/drivers/watchdog/iTCO_wdt.c	2014-01-20 03:40:07.000000000 +0100
+++ linux-3.14-rc5/drivers/watchdog/iTCO_wdt.c	2014-03-08 13:56:01.905564783 +0100
@@ -485,7 +485,7 @@ static int iTCO_wdt_probe(struct platfor
 	iTCO_wdt_watchdog_dev.bootstatus = 0;
 	iTCO_wdt_watchdog_dev.timeout = WATCHDOG_TIMEOUT;
 	watchdog_set_nowayout(&iTCO_wdt_watchdog_dev, nowayout);
-	iTCO_wdt_watchdog_dev.parent = dev->dev.parent;
+	iTCO_wdt_watchdog_dev.parent = &dev->dev;
 
 	/* Make sure the watchdog is not running */
 	iTCO_wdt_stop(&iTCO_wdt_watchdog_dev);


-- 
Jean Delvare
SUSE L3 Support
