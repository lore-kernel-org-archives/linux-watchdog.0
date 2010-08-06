Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:57893 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751542Ab0HFV3Y (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:29:24 -0400
Date: Fri, 6 Aug 2010 23:29:22 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (2/12): Group options that affect watchdog
	behavior together
Message-ID: <20100806212922.GA31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 1ab4c2fe17f4182c361b73d8ad4ca24a6b943dc2
Author: dann frazier <dannf@hp.com>
Date:   Tue Jul 27 17:50:54 2010 -0600

    watchdog: hpwdt (2/12): Group options that affect watchdog behavior together
    
    Reorganization only.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 183b7a4..0ad9af2 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -794,13 +794,13 @@ MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
 module_param(soft_margin, int, 0);
 MODULE_PARM_DESC(soft_margin, "Watchdog timeout in seconds");
 
-module_param(allow_kdump, int, 0);
-MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
-
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+module_param(allow_kdump, int, 0);
+MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
+
 module_param(priority, int, 0);
 MODULE_PARM_DESC(priority, "The hpwdt driver handles NMIs first or last"
 		" (default = 0/Last)\n");
