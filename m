Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay007.isp.belgacom.be ([195.238.6.173]:34280 "EHLO
	mailrelay007.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751636Ab0HFVdB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:33:01 -0400
Date: Fri, 6 Aug 2010 23:33:00 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (7/12): allow full range of timer values supported
	by hardware
Message-ID: <20100806213300.GF31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 98652432b335c3721816bb38607e9b9554efbb42
Author: dann frazier <dannf@hp.com>
Date:   Wed Jun 2 16:23:40 2010 -0600

    watchdog: hpwdt (7/12): allow full range of timer values supported by hardware
    
    The hpwdt timer is a 16 bit value with 128ms resolution.
    Let applications use this entire range.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index a5d36ae..0029991 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -36,6 +36,8 @@
 
 #define HPWDT_VERSION			"1.1.1"
 #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
+#define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
+#define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
 #define DEFAULT_MARGIN			30
 
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
@@ -432,8 +434,7 @@ static void hpwdt_ping(void)
 
 static int hpwdt_change_timer(int new_margin)
 {
-	/* Arbitrary, can't find the card's limits */
-	if (new_margin < 5 || new_margin > 600) {
+	if (new_margin < 1 || new_margin > HPWDT_MAX_TIMER) {
 		printk(KERN_WARNING
 			"hpwdt: New value passed in is invalid: %d seconds.\n",
 			new_margin);
