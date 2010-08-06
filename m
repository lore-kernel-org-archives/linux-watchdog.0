Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:17848 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751403Ab0HFVe0 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:34:26 -0400
Date: Fri, 6 Aug 2010 23:34:24 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (9/12): hpwdt_pretimeout reorganization
Message-ID: <20100806213424.GH31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit 20b311bcad0950b3e0ec96dd68ce7de3f9fcd009
Author: dann frazier <dannf@hp.com>
Date:   Tue Jul 27 17:50:49 2010 -0600

    watchdog: hpwdt (9/12): hpwdt_pretimeout reorganization
    
    Reorganize this function to remove excess indentation and highlight
    the single return code. (No functional change).
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 554526c..7ce7317 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -465,24 +465,26 @@ static int hpwdt_pretimeout(struct notifier_block *nb, unsigned long ulReason,
 	static int die_nmi_called;
 
 	if (ulReason != DIE_NMI && ulReason != DIE_NMI_IPI)
-		return NOTIFY_OK;
-
-	if (hpwdt_nmi_sourcing) {
-		spin_lock_irqsave(&rom_lock, rom_pl);
-		if (!die_nmi_called)
-			asminline_call(&cmn_regs, cru_rom_addr);
-		die_nmi_called = 1;
-		spin_unlock_irqrestore(&rom_lock, rom_pl);
-		if (cmn_regs.u1.ral == 0) {
-			printk(KERN_WARNING "hpwdt: An NMI occurred, "
-				"but unable to determine source.\n");
-		} else {
-			if (allow_kdump)
-				hpwdt_stop();
-			panic("An NMI occurred, please see the Integrated "
-				"Management Log for details.\n");
-		}
+		goto out;
+
+	if (!hpwdt_nmi_sourcing)
+		goto out;
+
+	spin_lock_irqsave(&rom_lock, rom_pl);
+	if (!die_nmi_called)
+		asminline_call(&cmn_regs, cru_rom_addr);
+	die_nmi_called = 1;
+	spin_unlock_irqrestore(&rom_lock, rom_pl);
+	if (cmn_regs.u1.ral == 0) {
+		printk(KERN_WARNING "hpwdt: An NMI occurred, "
+			"but unable to determine source.\n");
+	} else {
+		if (allow_kdump)
+			hpwdt_stop();
+		panic("An NMI occurred, please see the Integrated "
+			"Management Log for details.\n");
 	}
+out:
 	return NOTIFY_OK;
 }
 
