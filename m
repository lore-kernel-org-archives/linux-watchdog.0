Return-path: <zboszor@pr.hu>
From: Zoltan Boszormenyi <zboszor@pr.hu>
To: linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Menzel <paulepanter@users.sourceforge.net>,
	Christian Fetzer <fetzer.ch@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Nehal Shah <nehal-bakulchandra.shah@amd.com>,
	Tim Small <tim@seoss.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	Zoltan Boszormenyi <zboszor@pr.hu>
Subject: [PATCH 3/3 v2] watchdog: sp5100_tco: Use the common mutex
Date: Mon,  3 Apr 2017 09:51:33 +0200
Message-Id: <20170403075133.12343-4-zboszor@pr.hu>
In-Reply-To: <20170403075133.12343-1-zboszor@pr.hu>
References: <<20170401110223.12056-1-zboszor@pr.hu>>
 <20170403075133.12343-1-zboszor@pr.hu>
List-ID: <linux-watchdog@vger.kernel.org>

Use the common mutex from usb/host/pci-quirks.c to synchronize
accesses to the SB800 I/O port pair (0xcd6 / 0xcd7) with the
PCI quirk for isochronous USB transfers and with the i2c-piix4
driver.

At the same time, remove the request_region() call to reserve
these I/O ports, similarly to i2c-piix4 so the code is now uniform
across the three individual drivers.

v2: Explicit extern reference for sb800_mutex

Signed-off-by: Zoltan Boszormenyi <zboszor@pr.hu>
---
 drivers/watchdog/sp5100_tco.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 028618c..4dca9e89 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -36,9 +36,16 @@
 #include <linux/platform_device.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
+#include <linux/mutex.h>
 
 #include "sp5100_tco.h"
 
+/*
+ * sb800_mutex in drivers/usb/host/pci-quirks.c protects
+ * parallel access to the I/O port pair 0xCD6 / 0xCD7.
+ */
+extern struct mutex sb800_mutex;
+
 /* Module and version information */
 #define TCO_VERSION "0.05"
 #define TCO_MODULE_NAME "SP5100 TCO timer"
@@ -48,7 +55,6 @@
 static u32 tcobase_phys;
 static u32 tco_wdt_fired;
 static void __iomem *tcobase;
-static unsigned int pm_iobase;
 static DEFINE_SPINLOCK(tco_lock);	/* Guards the hardware */
 static unsigned long timer_alive;
 static char tco_expect_close;
@@ -138,6 +144,8 @@ static void tco_timer_enable(void)
 
 	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
 		/* For SB800 or later */
+		mutex_lock(&sb800_mutex);
+
 		/* Set the Watchdog timer resolution to 1 sec */
 		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
@@ -150,6 +158,8 @@ static void tco_timer_enable(void)
 		val |= SB800_PCI_WATCHDOG_DECODE_EN;
 		val &= ~SB800_PM_WATCHDOG_DISABLE;
 		outb(val, SB800_IO_PM_DATA_REG);
+
+		mutex_unlock(&sb800_mutex);
 	} else {
 		/* For SP5100 or SB7x0 */
 		/* Enable watchdog decode bit */
@@ -164,11 +174,13 @@ static void tco_timer_enable(void)
 				       val);
 
 		/* Enable Watchdog timer and set the resolution to 1 sec */
+		mutex_lock(&sb800_mutex);
 		outb(SP5100_PM_WATCHDOG_CONTROL, SP5100_IO_PM_INDEX_REG);
 		val = inb(SP5100_IO_PM_DATA_REG);
 		val |= SP5100_PM_WATCHDOG_SECOND_RES;
 		val &= ~SP5100_PM_WATCHDOG_DISABLE;
 		outb(val, SP5100_IO_PM_DATA_REG);
+		mutex_unlock(&sb800_mutex);
 	}
 }
 
@@ -361,16 +373,10 @@ static unsigned char sp5100_tco_setupdevice(void)
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
+	mutex_lock(&sb800_mutex);
 	outb(base_addr+3, index_reg);
 	val = inb(data_reg);
 	outb(base_addr+2, index_reg);
@@ -380,6 +386,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 	outb(base_addr+0, index_reg);
 	/* Low three bits of BASE are reserved */
 	val = val << 8 | (inb(data_reg) & 0xf8);
+	mutex_unlock(&sb800_mutex);
 
 	pr_debug("Got 0x%04x from indirect I/O\n", val);
 
@@ -400,6 +407,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
 	} else {
 		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
+		mutex_lock(&sb800_mutex);
 		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+2, SB800_IO_PM_INDEX_REG);
@@ -408,6 +416,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
+		mutex_unlock(&sb800_mutex);
 	}
 
 	/* The SBResource_MMIO is enabled and mapped memory space? */
@@ -429,7 +438,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
 
 	pr_notice("failed to find MMIO address, giving up.\n");
-	goto  unreg_region;
+	goto  exit;
 
 setup_wdt:
 	tcobase_phys = val;
@@ -469,8 +478,6 @@ static unsigned char sp5100_tco_setupdevice(void)
 
 unreg_mem_region:
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-unreg_region:
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 exit:
 	return 0;
 }
@@ -517,7 +524,6 @@ static int sp5100_tco_init(struct platform_device *dev)
 exit:
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 	return ret;
 }
 
@@ -531,7 +537,6 @@ static void sp5100_tco_cleanup(void)
 	misc_deregister(&sp5100_tco_miscdev);
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 }
 
 static int sp5100_tco_remove(struct platform_device *dev)
-- 
2.9.3
