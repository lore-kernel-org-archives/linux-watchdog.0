Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail7.pr.hu ([87.242.0.7]:53374 "EHLO mail7.pr.hu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbdDAKHX (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 1 Apr 2017 06:07:23 -0400
From: =?UTF-8?q?Zolt=C3=A1n=20B=C3=B6sz=C3=B6rm=C3=A9nyi?=
        <zboszor@pr.hu>
To: linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        =?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?=
        <zboszor@pr.hu>
Subject: [PATCH 3/3] watchdog: sp5100_tco: Synchronize I/O port accesses
Date: Sat,  1 Apr 2017 12:06:09 +0200
Message-Id: <20170401100609.9054-4-zboszor@pr.hu>
In-Reply-To: <20170401100609.9054-1-zboszor@pr.hu>
References: <20170401100609.9054-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Böszörményi Zoltán <zboszor@pr.hu>

Use the new header and the mutex from usb/host/pci-quirks.c

This change will allow accesses to the SB800 I/O port pair
synchronized with the PCI quirk when isochronous USB transfers
are performed and with i2c-piix4.

At the same time, remove the request_region() call to reserve
these I/O ports, similarly to i2c-piix4 so the code is now uniform
across the three individual drivers.

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 drivers/watchdog/sp5100_tco.c | 24 +++++++++++-------------
 drivers/watchdog/sp5100_tco.h | 10 ++++++----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 028618c..dc125df 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -48,7 +48,6 @@
 static u32 tcobase_phys;
 static u32 tco_wdt_fired;
 static void __iomem *tcobase;
-static unsigned int pm_iobase;
 static DEFINE_SPINLOCK(tco_lock);	/* Guards the hardware */
 static unsigned long timer_alive;
 static char tco_expect_close;
@@ -138,6 +137,8 @@ static void tco_timer_enable(void)
 
 	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
 		/* For SB800 or later */
+		enter_sb800();
+
 		/* Set the Watchdog timer resolution to 1 sec */
 		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
@@ -150,6 +151,8 @@ static void tco_timer_enable(void)
 		val |= SB800_PCI_WATCHDOG_DECODE_EN;
 		val &= ~SB800_PM_WATCHDOG_DISABLE;
 		outb(val, SB800_IO_PM_DATA_REG);
+
+		leave_sb800();
 	} else {
 		/* For SP5100 or SB7x0 */
 		/* Enable watchdog decode bit */
@@ -164,11 +167,13 @@ static void tco_timer_enable(void)
 				       val);
 
 		/* Enable Watchdog timer and set the resolution to 1 sec */
+		enter_sb800();
 		outb(SP5100_PM_WATCHDOG_CONTROL, SP5100_IO_PM_INDEX_REG);
 		val = inb(SP5100_IO_PM_DATA_REG);
 		val |= SP5100_PM_WATCHDOG_SECOND_RES;
 		val &= ~SP5100_PM_WATCHDOG_DISABLE;
 		outb(val, SP5100_IO_PM_DATA_REG);
+		leave_sb800();
 	}
 }
 
@@ -361,16 +366,10 @@ static unsigned char sp5100_tco_setupdevice(void)
 		base_addr = SB800_PM_WATCHDOG_BASE;
 	}
 
-	/* Request the IO ports used by this driver */
-	pm_iobase = SP5100_IO_PM_INDEX_REG;
-	if (!request_region(pm_iobase, SP5100_PM_IOPORTS_SIZE, dev_name)) {
-		pr_err("I/O address 0x%04x already in use\n", pm_iobase);
-		goto exit;
-	}
-
 	/*
 	 * First, Find the watchdog timer MMIO address from indirect I/O.
 	 */
+	enter_sb800();
 	outb(base_addr+3, index_reg);
 	val = inb(data_reg);
 	outb(base_addr+2, index_reg);
@@ -380,6 +379,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 	outb(base_addr+0, index_reg);
 	/* Low three bits of BASE are reserved */
 	val = val << 8 | (inb(data_reg) & 0xf8);
+	leave_sb800();
 
 	pr_debug("Got 0x%04x from indirect I/O\n", val);
 
@@ -400,6 +400,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
 	} else {
 		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
+		enter_sb800();
 		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+2, SB800_IO_PM_INDEX_REG);
@@ -408,6 +409,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
+		leave_sb800();
 	}
 
 	/* The SBResource_MMIO is enabled and mapped memory space? */
@@ -429,7 +431,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
 
 	pr_notice("failed to find MMIO address, giving up.\n");
-	goto  unreg_region;
+	goto  exit;
 
 setup_wdt:
 	tcobase_phys = val;
@@ -469,8 +471,6 @@ static unsigned char sp5100_tco_setupdevice(void)
 
 unreg_mem_region:
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-unreg_region:
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 exit:
 	return 0;
 }
@@ -517,7 +517,6 @@ static int sp5100_tco_init(struct platform_device *dev)
 exit:
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 	return ret;
 }
 
@@ -531,7 +530,6 @@ static void sp5100_tco_cleanup(void)
 	misc_deregister(&sp5100_tco_miscdev);
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 }
 
 static int sp5100_tco_remove(struct platform_device *dev)
diff --git a/drivers/watchdog/sp5100_tco.h b/drivers/watchdog/sp5100_tco.h
index 2b28c00..f5d9402 100644
--- a/drivers/watchdog/sp5100_tco.h
+++ b/drivers/watchdog/sp5100_tco.h
@@ -6,6 +6,8 @@
  *	TCO timer driver for sp5100 chipsets
  */
 
+#include <linux/sb800.h>
+
 /*
  * Some address definitions for the Watchdog
  */
@@ -24,8 +26,8 @@
  */
 
 /*  For SP5100/SB7x0 chipset */
-#define SP5100_IO_PM_INDEX_REG		0xCD6
-#define SP5100_IO_PM_DATA_REG		0xCD7
+#define SP5100_IO_PM_INDEX_REG		SB800_PIIX4_SMB_IDX
+#define SP5100_IO_PM_DATA_REG		SB800_PIIX4_SMB_DATA
 
 #define SP5100_SB_RESOURCE_MMIO_BASE	0x9C
 
@@ -45,8 +47,8 @@
 
 
 /*  For SB8x0(or later) chipset */
-#define SB800_IO_PM_INDEX_REG		0xCD6
-#define SB800_IO_PM_DATA_REG		0xCD7
+#define SB800_IO_PM_INDEX_REG		SB800_PIIX4_SMB_IDX
+#define SB800_IO_PM_DATA_REG		SB800_PIIX4_SMB_DATA
 
 #define SB800_PM_ACPI_MMIO_EN		0x24
 #define SB800_PM_WATCHDOG_CONTROL	0x48
-- 
2.9.3

