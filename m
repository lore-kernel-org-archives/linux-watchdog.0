Return-Path: <zboszor@pr.hu>
Return-path: <zboszor@pr.hu>
From: Zoltan Boszormenyi <zboszor@pr.hu>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
	Christian Fetzer <fetzer.ch@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Nehal Shah <nehal-bakulchandra.shah@amd.com>,
	Tim Small <tim@seoss.co.uk>,
	Guenter Roeck <linux@roeck-us.net>,
	kernel@ekass.net,
	wim@iguana.be,
	jlayton@poochiereds.net,
	marc.2377@gmail.com,
	cshorler@googlemail.com,
	wsa@the-dreams.de,
	regressions@leemhuis.info,
	Alex Williamson <alex.williamson@redhat.com>,
	lyude@redhat.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jakub Sitnicki <jsitnicki@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Simon Guinot <simon.guinot@sequanux.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Mike Travis <travis@sgi.com>,
	Daeseok Youn <daeseok.youn@gmail.com>,
	Huang Rui <ray.huang@amd.com>,
	Andiry Xu <andiry.xu@amd.com>,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	David Howells <dhowells@redhat.com>,
	Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
	Alexandre Desnoyers <alex@qtec.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wan ZongShun <Vincent.Wan@amd.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Lucas Stach <dev@lynxeye.de>,
	Denis Turischev <denis.turischev@compulab.co.il>,
	=?UTF-8?q?B=C3=B6sz=C3=B6rm=C3=A9nyi=20Zolt=C3=A1n?= <zboszor@pr.hu>
Subject: [PATCH 5/5 v5] watchdog: sp5100_tco: Use request_declared_muxed_region()
Date: Mon, 18 Dec 2017 09:48:41 +0100
Message-Id: <20171218084841.9979-5-zboszor@pr.hu>
In-Reply-To: <20171218084841.9979-1-zboszor@pr.hu>
References: <20171218084841.9979-1-zboszor@pr.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Böszörményi Zoltán <zboszor@pr.hu>

Use the new request_declared_muxed_region() macro to synchronize
accesses to the SB800 I/O port pair (0xcd6 / 0xcd7) with the
PCI quirk for isochronous USB transfers and with the i2c-piix4
driver.

At the same time, remove the long lifetime request_region() call
to reserve these I/O ports, similarly to i2c-piix4 so the code is
now uniform across the three drivers.

v1: Started with a common mutex in a C source file.

v2: Referenced the common mutex from drivers/usb/host/pci-quirks.c

v3: Switched to using the new request_declared_muxed_region
    macro.

v4: Fixed checkpatch.pl warnings and use the new
    release_declared_region() macro.

v5: Rebased for 4.15-rc4
    Removed the last unnecessary release_region() call

Signed-off-by: Zoltán Böszörményi <zboszor@pr.hu>
---
 drivers/watchdog/sp5100_tco.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 028618c5eeba..ac17191a72bd 100644
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
@@ -70,6 +69,11 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started."
 		" (default=" __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+/* synchronized access to the I/O port pair */
+static struct resource sp5100_res = DEFINE_RES_IO_NAMED(SB800_IO_PM_INDEX_REG,
+						SP5100_PM_IOPORTS_SIZE,
+						TCO_MODULE_NAME);
+
 /*
  * Some TCO specific functions
  */
@@ -139,6 +143,7 @@ static void tco_timer_enable(void)
 	if (!tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
 		/* For SB800 or later */
 		/* Set the Watchdog timer resolution to 1 sec */
+		request_declared_muxed_region(&sp5100_res);
 		outb(SB800_PM_WATCHDOG_CONFIG, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
 		val |= SB800_PM_WATCHDOG_SECOND_RES;
@@ -150,6 +155,7 @@ static void tco_timer_enable(void)
 		val |= SB800_PCI_WATCHDOG_DECODE_EN;
 		val &= ~SB800_PM_WATCHDOG_DISABLE;
 		outb(val, SB800_IO_PM_DATA_REG);
+		release_declared_region(&sp5100_res);
 	} else {
 		/* For SP5100 or SB7x0 */
 		/* Enable watchdog decode bit */
@@ -164,11 +170,13 @@ static void tco_timer_enable(void)
 				       val);
 
 		/* Enable Watchdog timer and set the resolution to 1 sec */
+		request_declared_muxed_region(&sp5100_res);
 		outb(SP5100_PM_WATCHDOG_CONTROL, SP5100_IO_PM_INDEX_REG);
 		val = inb(SP5100_IO_PM_DATA_REG);
 		val |= SP5100_PM_WATCHDOG_SECOND_RES;
 		val &= ~SP5100_PM_WATCHDOG_DISABLE;
 		outb(val, SP5100_IO_PM_DATA_REG);
+		release_declared_region(&sp5100_res);
 	}
 }
 
@@ -361,16 +369,10 @@ static unsigned char sp5100_tco_setupdevice(void)
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
+	request_declared_muxed_region(&sp5100_res);
 	outb(base_addr+3, index_reg);
 	val = inb(data_reg);
 	outb(base_addr+2, index_reg);
@@ -380,6 +382,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 	outb(base_addr+0, index_reg);
 	/* Low three bits of BASE are reserved */
 	val = val << 8 | (inb(data_reg) & 0xf8);
+	release_declared_region(&sp5100_res);
 
 	pr_debug("Got 0x%04x from indirect I/O\n", val);
 
@@ -400,6 +403,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
 	} else {
 		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
+		request_declared_muxed_region(&sp5100_res);
 		outb(SB800_PM_ACPI_MMIO_EN+3, SB800_IO_PM_INDEX_REG);
 		val = inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+2, SB800_IO_PM_INDEX_REG);
@@ -408,6 +412,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
 		outb(SB800_PM_ACPI_MMIO_EN+0, SB800_IO_PM_INDEX_REG);
 		val = val << 8 | inb(SB800_IO_PM_DATA_REG);
+		release_declared_region(&sp5100_res);
 	}
 
 	/* The SBResource_MMIO is enabled and mapped memory space? */
@@ -429,7 +434,7 @@ static unsigned char sp5100_tco_setupdevice(void)
 		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
 
 	pr_notice("failed to find MMIO address, giving up.\n");
-	goto  unreg_region;
+	goto  exit;
 
 setup_wdt:
 	tcobase_phys = val;
@@ -469,8 +474,6 @@ static unsigned char sp5100_tco_setupdevice(void)
 
 unreg_mem_region:
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-unreg_region:
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 exit:
 	return 0;
 }
@@ -517,7 +520,6 @@ static int sp5100_tco_init(struct platform_device *dev)
 exit:
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 	return ret;
 }
 
@@ -531,7 +533,6 @@ static void sp5100_tco_cleanup(void)
 	misc_deregister(&sp5100_tco_miscdev);
 	iounmap(tcobase);
 	release_mem_region(tcobase_phys, SP5100_WDT_MEM_MAP_SIZE);
-	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 }
 
 static int sp5100_tco_remove(struct platform_device *dev)
-- 
2.13.6
