Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Mingarelli, Thomas" <Thomas.Mingarelli@hp.com>
To: Axel Lin <axel.lin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Wim Van Sebroeck <wim@iguana.be>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Date: Tue, 8 Mar 2011 14:56:50 +0000
Subject: RE: [PATCH] watchdog: hpwdt: eliminate section mismatch warning
Message-ID: <183C1D5A376DE343AA8F94FC2A1EC1497D734E5608@GVW1091EXB.americas.hpqcorp.net>
References: <1299037784.16464.1.camel@mola>
In-Reply-To: <1299037784.16464.1.camel@mola>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Wim:


I ACK this patch.


Thanks,
Tom

-----Original Message-----
From: Axel Lin [mailto:axel.lin@gmail.com] 
Sent: Tuesday, March 01, 2011 9:50 PM
To: linux-kernel@vger.kernel.org
Cc: Mingarelli, Thomas; Wim Van Sebroeck; linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: hpwdt: eliminate section mismatch warning

hpwdt_init_nmi_decoding() is called in hpwdt_init_one error handling,
thus remove the  __devexit annotation of hpwdt_exit_nmi_decoding().

This patch fixes below warning:

WARNING: drivers/watchdog/hpwdt.o(.devinit.text+0x36f): Section mismatch in reference from the function hpwdt_init_one() to the function .devexit.text:hpwdt_exit_nmi_decoding()
The function __devinit hpwdt_init_one() references
a function __devexit hpwdt_exit_nmi_decoding().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __devexit annotation of
hpwdt_exit_nmi_decoding() so it may be used outside an exit section.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/watchdog/hpwdt.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index d54d4ba..8cb2685 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -710,7 +710,7 @@ static int __devinit hpwdt_init_nmi_decoding(struct pci_dev *dev)
 	return 0;
 }
 
-static void __devexit hpwdt_exit_nmi_decoding(void)
+static void hpwdt_exit_nmi_decoding(void)
 {
 	unregister_die_notifier(&die_notifier);
 	if (cru_rom_addr)
@@ -726,7 +726,7 @@ static int __devinit hpwdt_init_nmi_decoding(struct pci_dev *dev)
 	return 0;
 }
 
-static void __devexit hpwdt_exit_nmi_decoding(void)
+static void hpwdt_exit_nmi_decoding(void)
 {
 }
 #endif /* CONFIG_HPWDT_NMI_DECODING */
-- 
1.7.2
