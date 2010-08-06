Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:58551 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964821Ab0HFVbt (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 6 Aug 2010 17:31:49 -0400
Date: Fri, 6 Aug 2010 23:31:48 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: dann frazier <dannf@hp.com>
Cc: Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Thomas Mingarelli <thomas.mingarelli@hp.com>
Subject: watchdog: hpwdt (5/12): Make x86 assembly ifdef guard more strict
Message-ID: <20100806213148.GD31433@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

commit fe66f8898210175a13fb553b95b1db2d3a898cf0
Author: dann frazier <dannf@hp.com>
Date:   Tue Jul 27 17:50:59 2010 -0600

    watchdog: hpwdt (5/12): Make x86 assembly ifdef guard more strict
    
    The 32-bit assembly is guarded by an #ifndef CONFIG_X86_64. Kconfig prevents
    us from building this driver on !X86, so that happens to suffice - but we
    should really lock it down to #ifdef CONFIG_X86_32.
    
    Signed-off-by: dann frazier <dannf@hp.com>
    Acked-by: Thomas Mingarelli <Thomas.Mingarelli@hp.com>
    Signed-off-by: Wim Van Sebroeck <wim@iguana.be>

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index e18f6b9..77ca72c 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -133,7 +133,7 @@ static struct cmn_registers cmn_regs;
 extern asmlinkage void asminline_call(struct cmn_registers *pi86Regs,
 						unsigned long *pRomEntry);
 
-#ifndef CONFIG_X86_64
+#ifdef CONFIG_X86_32
 /* --32 Bit Bios------------------------------------------------------------ */
 
 #define HPWDT_ARCH	32
@@ -322,8 +322,9 @@ static int __devinit detect_cru_service(void)
 	iounmap(p);
 	return rc;
 }
-
-#else
+/* ------------------------------------------------------------------------- */
+#endif /* CONFIG_X86_32 */
+#ifdef CONFIG_X86_64
 /* --64 Bit Bios------------------------------------------------------------ */
 
 #define HPWDT_ARCH	64
@@ -401,10 +402,8 @@ static int __devinit detect_cru_service(void)
 	/* if cru_rom_addr has been set then we found a CRU service */
 	return ((cru_rom_addr != NULL) ? 0 : -ENODEV);
 }
-
 /* ------------------------------------------------------------------------- */
-
-#endif
+#endif /* CONFIG_X86_64 */
 
 /*
  *	Watchdog operations
