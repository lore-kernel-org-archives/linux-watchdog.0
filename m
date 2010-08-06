Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay008.isp.belgacom.be ([195.238.6.174]:54358 "EHLO
	mailrelay008.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964821Ab0HFVcc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:32:32 -0400
Date: Fri, 6 Aug 2010 23:32:31 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (6/12): Introduce SECS_TO_TICKS() macro
Message-ID: <20100806213231.GE31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit ca6b602bca8cd425fcb6163ace653b9c47e8dc6a
Author: dann frazier <dannf@hp.com>
Date:   Wed Jun 2 16:23:39 2010 -0600

    watchdog: hpwdt (6/12): Introduce SECS_TO_TICKS() macro
    
    Define a macro to convert from seconds to timer ticks.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 77ca72c..a5d36ae 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -35,6 +35,7 @@
 #include <asm/cacheflush.h>
 
 #define HPWDT_VERSION			"1.1.1"
+#define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
 #define DEFAULT_MARGIN			30
 
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
@@ -410,7 +411,7 @@ static int __devinit detect_cru_service(void)
  */
 static void hpwdt_start(void)
 {
-	reload = (soft_margin * 1000) / 128;
+	reload = SECS_TO_TICKS(soft_margin);
 	iowrite16(reload, hpwdt_timer_reg);
 	iowrite16(0x85, hpwdt_timer_con);
 }
@@ -443,7 +444,7 @@ static int hpwdt_change_timer(int new_margin)
 	printk(KERN_DEBUG
 		"hpwdt: New timer passed in is %d seconds.\n",
 		new_margin);
-	reload = (soft_margin * 1000) / 128;
+	reload = SECS_TO_TICKS(soft_margin);
 
 	return 0;
 }
