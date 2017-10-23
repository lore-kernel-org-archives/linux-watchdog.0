Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:51394 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdJWWzz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 23 Oct 2017 18:55:55 -0400
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@iguana.be, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 2/3] watchdog: hpwdt: Check source of NMI
Date: Mon, 23 Oct 2017 16:46:17 -0600
Message-Id: <0875a9cc4f607f551fdedc9f6495883bb917a48d.1508797127.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508797127.git.jerry.hoemann@hpe.com>
References: <cover.1508797127.git.jerry.hoemann@hpe.com>
In-Reply-To: <cover.1508797127.git.jerry.hoemann@hpe.com>
References: <cover.1508797127.git.jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Do not claim the NMI (i.e. return NMI_DONE) if the source of
the NMI isn't the iLO watchdog or debug.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9fd869f..e616583 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -52,6 +52,7 @@
 static unsigned long hpwdt_is_open;
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
+static unsigned long __iomem *hpwdt_nmistat;
 static unsigned long __iomem *hpwdt_timer_reg;
 static unsigned long __iomem *hpwdt_timer_con;
 
@@ -474,6 +475,11 @@ static int hpwdt_time_left(void)
 	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
 }
 
+static int hpwdt_my_nmi(void)
+{
+	return ioread8(hpwdt_nmistat) & 0x6;
+}
+
 #ifdef CONFIG_HPWDT_NMI_DECODING
 /*
  *	NMI Handler
@@ -486,6 +492,9 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (!hpwdt_nmi_decoding)
 		return NMI_DONE;
 
+	if ((ulReason == NMI_UNKNOWN) && !hpwdt_my_nmi())
+		return NMI_DONE;
+
 	spin_lock_irqsave(&rom_lock, rom_pl);
 	if (!die_nmi_called && !is_icru && !is_uefi)
 		asminline_call(&cmn_regs, cru_rom_addr);
@@ -842,6 +851,7 @@ static int hpwdt_init_one(struct pci_dev *dev,
 		retval = -ENOMEM;
 		goto error_pci_iomap;
 	}
+	hpwdt_nmistat	= pci_mem_addr + 0x6e;
 	hpwdt_timer_reg = pci_mem_addr + 0x70;
 	hpwdt_timer_con = pci_mem_addr + 0x72;
 
-- 
1.8.3.1

