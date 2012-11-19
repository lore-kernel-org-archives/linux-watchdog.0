Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41687 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab2KSSiG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Nov 2012 13:38:06 -0500
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Wan ZongShun <mcuos.com@gmail.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	linux-watchdog@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	patches@opensource.wolfsonmicro.com
Subject: [PATCH 152/493] watchdog: remove use of __devinit
Date: Mon, 19 Nov 2012 13:21:41 -0500
Message-Id: <1353349642-3677-152-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinit is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Wim Van Sebroeck <wim@iguana.be> 
Cc: Wan ZongShun <mcuos.com@gmail.com> 
Cc: Ben Dooks <ben-linux@fluff.org> 
Cc: Kukjin Kim <kgene.kim@samsung.com> 
Cc: linux-watchdog@vger.kernel.org 
Cc: uclinux-dist-devel@blackfin.uclinux.org 
Cc: linux-arm-kernel@lists.infradead.org 
Cc: linux-samsung-soc@vger.kernel.org 
Cc: patches@opensource.wolfsonmicro.com 
---
 drivers/watchdog/acquirewdt.c     |  2 +-
 drivers/watchdog/advantechwdt.c   |  2 +-
 drivers/watchdog/ar7_wdt.c        |  2 +-
 drivers/watchdog/at91rm9200_wdt.c |  2 +-
 drivers/watchdog/ath79_wdt.c      |  2 +-
 drivers/watchdog/bcm63xx_wdt.c    |  2 +-
 drivers/watchdog/bfin_wdt.c       |  2 +-
 drivers/watchdog/cpu5wdt.c        |  4 ++--
 drivers/watchdog/cpwd.c           |  2 +-
 drivers/watchdog/da9052_wdt.c     |  2 +-
 drivers/watchdog/davinci_wdt.c    |  2 +-
 drivers/watchdog/dw_wdt.c         |  2 +-
 drivers/watchdog/ep93xx_wdt.c     |  2 +-
 drivers/watchdog/gef_wdt.c        |  2 +-
 drivers/watchdog/geodewdt.c       |  2 +-
 drivers/watchdog/hpwdt.c          | 26 +++++++++++++-------------
 drivers/watchdog/i6300esb.c       |  6 +++---
 drivers/watchdog/iTCO_wdt.c       |  2 +-
 drivers/watchdog/ib700wdt.c       |  2 +-
 drivers/watchdog/ie6xx_wdt.c      |  6 +++---
 drivers/watchdog/jz4740_wdt.c     |  2 +-
 drivers/watchdog/ks8695_wdt.c     |  2 +-
 drivers/watchdog/lantiq_wdt.c     |  2 +-
 drivers/watchdog/max63xx_wdt.c    |  2 +-
 drivers/watchdog/mpc8xxx_wdt.c    |  2 +-
 drivers/watchdog/mpcore_wdt.c     |  2 +-
 drivers/watchdog/mtx-1_wdt.c      |  2 +-
 drivers/watchdog/mv64x60_wdt.c    |  2 +-
 drivers/watchdog/nuc900_wdt.c     |  2 +-
 drivers/watchdog/nv_tco.c         |  4 ++--
 drivers/watchdog/of_xilinx_wdt.c  |  2 +-
 drivers/watchdog/omap_wdt.c       |  2 +-
 drivers/watchdog/orion_wdt.c      |  2 +-
 drivers/watchdog/pcwd.c           |  4 ++--
 drivers/watchdog/pcwd_pci.c       |  2 +-
 drivers/watchdog/pnx4008_wdt.c    |  2 +-
 drivers/watchdog/rc32434_wdt.c    |  2 +-
 drivers/watchdog/rdc321x_wdt.c    |  2 +-
 drivers/watchdog/riowd.c          |  2 +-
 drivers/watchdog/s3c2410_wdt.c    |  2 +-
 drivers/watchdog/sch311x_wdt.c    |  2 +-
 drivers/watchdog/shwdt.c          |  2 +-
 drivers/watchdog/sp5100_tco.c     |  4 ++--
 drivers/watchdog/sp805_wdt.c      |  2 +-
 drivers/watchdog/stmp3xxx_wdt.c   |  2 +-
 drivers/watchdog/ts72xx_wdt.c     |  2 +-
 drivers/watchdog/twl4030_wdt.c    |  2 +-
 drivers/watchdog/via_wdt.c        |  2 +-
 drivers/watchdog/wdt_pci.c        |  2 +-
 drivers/watchdog/wm831x_wdt.c     |  2 +-
 drivers/watchdog/wm8350_wdt.c     |  2 +-
 drivers/watchdog/xen_wdt.c        |  2 +-
 52 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index 49e0b89..e009f93 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -240,7 +240,7 @@ static struct miscdevice acq_miscdev = {
  *	Init & exit routines
  */
 
-static int __devinit acq_probe(struct platform_device *dev)
+static int acq_probe(struct platform_device *dev)
 {
 	int ret;
 
diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index 9a74156..cc50c57 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -238,7 +238,7 @@ static struct miscdevice advwdt_miscdev = {
  *	Init & exit routines
  */
 
-static int __devinit advwdt_probe(struct platform_device *dev)
+static int advwdt_probe(struct platform_device *dev)
 {
 	int ret;
 
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index eb633d9..154347e 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -274,7 +274,7 @@ static struct miscdevice ar7_wdt_miscdev = {
 	.fops		= &ar7_wdt_fops,
 };
 
-static int __devinit ar7_wdt_probe(struct platform_device *pdev)
+static int ar7_wdt_probe(struct platform_device *pdev)
 {
 	int rc;
 
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 75f3a6b..cc290bb 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -199,7 +199,7 @@ static struct miscdevice at91wdt_miscdev = {
 	.fops		= &at91wdt_fops,
 };
 
-static int __devinit at91wdt_probe(struct platform_device *pdev)
+static int at91wdt_probe(struct platform_device *pdev)
 {
 	int res;
 
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 367ef5e..5c0967d 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -224,7 +224,7 @@ static struct miscdevice ath79_wdt_miscdev = {
 	.fops = &ath79_wdt_fops,
 };
 
-static int __devinit ath79_wdt_probe(struct platform_device *pdev)
+static int ath79_wdt_probe(struct platform_device *pdev)
 {
 	u32 ctrl;
 	int err;
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index e81b784..5a7cff6 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -236,7 +236,7 @@ static struct miscdevice bcm63xx_wdt_miscdev = {
 };
 
 
-static int __devinit bcm63xx_wdt_probe(struct platform_device *pdev)
+static int bcm63xx_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *r;
diff --git a/drivers/watchdog/bfin_wdt.c b/drivers/watchdog/bfin_wdt.c
index 4a85dbf..241f8af 100644
--- a/drivers/watchdog/bfin_wdt.c
+++ b/drivers/watchdog/bfin_wdt.c
@@ -356,7 +356,7 @@ static const struct watchdog_info bfin_wdt_info = {
  *	Registers the misc device.  Actual device
  *	initialization is handled by bfin_wdt_open().
  */
-static int __devinit bfin_wdt_probe(struct platform_device *pdev)
+static int bfin_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 7e88839..6eb710b 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -215,7 +215,7 @@ static struct miscdevice cpu5wdt_misc = {
 
 /* init/exit function */
 
-static int __devinit cpu5wdt_init(void)
+static int cpu5wdt_init(void)
 {
 	unsigned int val;
 	int err;
@@ -256,7 +256,7 @@ no_port:
 	return err;
 }
 
-static int __devinit cpu5wdt_init_module(void)
+static int cpu5wdt_init_module(void)
 {
 	return cpu5wdt_init();
 }
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index ed7f434..731578b 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -528,7 +528,7 @@ static const struct file_operations cpwd_fops = {
 	.llseek =		no_llseek,
 };
 
-static int __devinit cpwd_probe(struct platform_device *op)
+static int cpwd_probe(struct platform_device *op)
 {
 	struct device_node *options;
 	const char *str_prop;
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 463e9e5..93a3165 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -179,7 +179,7 @@ static const struct watchdog_ops da9052_wdt_ops = {
 };
 
 
-static int __devinit da9052_wdt_probe(struct platform_device *pdev)
+static int da9052_wdt_probe(struct platform_device *pdev)
 {
 	struct da9052 *da9052 = dev_get_drvdata(pdev->dev.parent);
 	struct da9052_wdt_data *driver_data;
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 00b509c..9f371b8 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -199,7 +199,7 @@ static struct miscdevice davinci_wdt_miscdev = {
 	.fops = &davinci_wdt_fops,
 };
 
-static int __devinit davinci_wdt_probe(struct platform_device *pdev)
+static int davinci_wdt_probe(struct platform_device *pdev)
 {
 	int ret = 0, size;
 	struct device *dev = &pdev->dev;
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 6a8448d..49e24e5 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -293,7 +293,7 @@ static struct miscdevice dw_wdt_miscdev = {
 	.minor		= WATCHDOG_MINOR,
 };
 
-static int __devinit dw_wdt_drv_probe(struct platform_device *pdev)
+static int dw_wdt_drv_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 91703a5..f1bd88c 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -112,7 +112,7 @@ static struct watchdog_device ep93xx_wdt_wdd = {
 	.ops		= &ep93xx_wdt_ops,
 };
 
-static int __devinit ep93xx_wdt_probe(struct platform_device *pdev)
+static int ep93xx_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	unsigned long val;
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index 17f4cae..276f009 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -262,7 +262,7 @@ static struct miscdevice gef_wdt_miscdev = {
 };
 
 
-static int __devinit gef_wdt_probe(struct platform_device *dev)
+static int gef_wdt_probe(struct platform_device *dev)
 {
 	int timeout = 10;
 	u32 freq;
diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index a340e04..28a3a87 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -215,7 +215,7 @@ static struct miscdevice geodewdt_miscdev = {
 	.fops = &geodewdt_fops,
 };
 
-static int __devinit geodewdt_probe(struct platform_device *dev)
+static int geodewdt_probe(struct platform_device *dev)
 {
 	int ret;
 
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 03687bc..cc25ddf 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -212,7 +212,7 @@ asm(".text                          \n\t"
  *	0        :  SUCCESS
  *	<0       :  FAILURE
  */
-static int __devinit cru_detect(unsigned long map_entry,
+static int cru_detect(unsigned long map_entry,
 	unsigned long map_offset)
 {
 	void *bios32_map;
@@ -268,7 +268,7 @@ static int __devinit cru_detect(unsigned long map_entry,
 /*
  *	bios_checksum
  */
-static int __devinit bios_checksum(const char __iomem *ptr, int len)
+static int bios_checksum(const char __iomem *ptr, int len)
 {
 	char sum = 0;
 	int i;
@@ -293,7 +293,7 @@ static int __devinit bios_checksum(const char __iomem *ptr, int len)
  *	0        :  SUCCESS
  *	<0       :  FAILURE
  */
-static int __devinit bios32_present(const char __iomem *p)
+static int bios32_present(const char __iomem *p)
 {
 	struct bios32_service_dir *bios_32_ptr;
 	int length;
@@ -323,7 +323,7 @@ static int __devinit bios32_present(const char __iomem *p)
 	return -ENODEV;
 }
 
-static int __devinit detect_cru_service(void)
+static int detect_cru_service(void)
 {
 	char __iomem *p, *q;
 	int rc = -1;
@@ -395,7 +395,7 @@ asm(".text                      \n\t"
  *	This function checks whether or not a SMBIOS/DMI record is
  *	the 64bit CRU info or not
  */
-static void __devinit dmi_find_cru(const struct dmi_header *dm, void *dummy)
+static void dmi_find_cru(const struct dmi_header *dm, void *dummy)
 {
 	struct smbios_cru64_info *smbios_cru64_ptr;
 	unsigned long cru_physical_address;
@@ -414,7 +414,7 @@ static void __devinit dmi_find_cru(const struct dmi_header *dm, void *dummy)
 	}
 }
 
-static int __devinit detect_cru_service(void)
+static int detect_cru_service(void)
 {
 	cru_rom_addr = NULL;
 
@@ -647,7 +647,7 @@ static struct miscdevice hpwdt_miscdev = {
 
 #ifdef CONFIG_HPWDT_NMI_DECODING
 #ifdef CONFIG_X86_LOCAL_APIC
-static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
+static void hpwdt_check_nmi_decoding(struct pci_dev *dev)
 {
 	/*
 	 * If nmi_watchdog is turned off then we can turn on
@@ -656,7 +656,7 @@ static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
 	hpwdt_nmi_decoding = 1;
 }
 #else
-static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
+static void hpwdt_check_nmi_decoding(struct pci_dev *dev)
 {
 	dev_warn(&dev->dev, "NMI decoding is disabled. "
 		"Your kernel does not support a NMI Watchdog.\n");
@@ -671,7 +671,7 @@ static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
  *	This check is independent of architecture and needs to be made for
  *	any ProLiant system.
  */
-static void __devinit dmi_find_icru(const struct dmi_header *dm, void *dummy)
+static void dmi_find_icru(const struct dmi_header *dm, void *dummy)
 {
 	struct smbios_proliant_info *smbios_proliant_ptr;
 
@@ -682,7 +682,7 @@ static void __devinit dmi_find_icru(const struct dmi_header *dm, void *dummy)
 	}
 }
 
-static int __devinit hpwdt_init_nmi_decoding(struct pci_dev *dev)
+static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 {
 	int retval;
 
@@ -762,11 +762,11 @@ static void hpwdt_exit_nmi_decoding(void)
 		iounmap(cru_rom_addr);
 }
 #else /* !CONFIG_HPWDT_NMI_DECODING */
-static void __devinit hpwdt_check_nmi_decoding(struct pci_dev *dev)
+static void hpwdt_check_nmi_decoding(struct pci_dev *dev)
 {
 }
 
-static int __devinit hpwdt_init_nmi_decoding(struct pci_dev *dev)
+static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 {
 	return 0;
 }
@@ -776,7 +776,7 @@ static void hpwdt_exit_nmi_decoding(void)
 }
 #endif /* CONFIG_HPWDT_NMI_DECODING */
 
-static int __devinit hpwdt_init_one(struct pci_dev *dev,
+static int hpwdt_init_one(struct pci_dev *dev,
 					const struct pci_device_id *ent)
 {
 	int retval;
diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 2574066..31b87db 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -344,7 +344,7 @@ MODULE_DEVICE_TABLE(pci, esb_pci_tbl);
  *      Init & exit routines
  */
 
-static unsigned char __devinit esb_getdevice(struct pci_dev *pdev)
+static unsigned char esb_getdevice(struct pci_dev *pdev)
 {
 	if (pci_enable_device(pdev)) {
 		pr_err("failed to enable device\n");
@@ -375,7 +375,7 @@ err_devput:
 	return 0;
 }
 
-static void __devinit esb_initdevice(void)
+static void esb_initdevice(void)
 {
 	u8 val1;
 	u16 val2;
@@ -416,7 +416,7 @@ static void __devinit esb_initdevice(void)
 	esb_timer_set_heartbeat(heartbeat);
 }
 
-static int __devinit esb_probe(struct pci_dev *pdev,
+static int esb_probe(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	int ret;
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index b83f935..fb341df 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -390,7 +390,7 @@ static void __devexit iTCO_wdt_cleanup(void)
 	iTCO_wdt_private.gcs = NULL;
 }
 
-static int __devinit iTCO_wdt_probe(struct platform_device *dev)
+static int iTCO_wdt_probe(struct platform_device *dev)
 {
 	int ret = -ENODEV;
 	unsigned long val32;
diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index 4e992c8..5249596 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -277,7 +277,7 @@ static struct miscdevice ibwdt_miscdev = {
  *	Init & exit routines
  */
 
-static int __devinit ibwdt_probe(struct platform_device *dev)
+static int ibwdt_probe(struct platform_device *dev)
 {
 	int res;
 
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 93b2cda..94eef6f 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -225,7 +225,7 @@ static const struct file_operations ie6xx_wdt_dbg_operations = {
 	.release	= single_release,
 };
 
-static void __devinit ie6xx_wdt_debugfs_init(void)
+static void ie6xx_wdt_debugfs_init(void)
 {
 	/* /sys/kernel/debug/ie6xx_wdt */
 	ie6xx_wdt_data.debugfs = debugfs_create_file("ie6xx_wdt",
@@ -238,7 +238,7 @@ static void ie6xx_wdt_debugfs_exit(void)
 }
 
 #else
-static void __devinit ie6xx_wdt_debugfs_init(void)
+static void ie6xx_wdt_debugfs_init(void)
 {
 }
 
@@ -247,7 +247,7 @@ static void ie6xx_wdt_debugfs_exit(void)
 }
 #endif
 
-static int __devinit ie6xx_wdt_probe(struct platform_device *pdev)
+static int ie6xx_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	u8 wdtlr;
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 331a613..eb7008a 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -144,7 +144,7 @@ static const struct watchdog_ops jz4740_wdt_ops = {
 	.set_timeout = jz4740_wdt_set_timeout,
 };
 
-static int __devinit jz4740_wdt_probe(struct platform_device *pdev)
+static int jz4740_wdt_probe(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata;
 	struct watchdog_device *jz4740_wdt;
diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 6ac9ff2..c305adb 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -235,7 +235,7 @@ static struct miscdevice ks8695wdt_miscdev = {
 	.fops		= &ks8695wdt_fops,
 };
 
-static int __devinit ks8695wdt_probe(struct platform_device *pdev)
+static int ks8695wdt_probe(struct platform_device *pdev)
 {
 	int res;
 
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index ce4df08..fd9f43c 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -186,7 +186,7 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
-static int __devinit
+static int
 ltq_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 7e95221..b572c75 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -174,7 +174,7 @@ static struct watchdog_device max63xx_wdt_dev = {
 	.ops = &max63xx_wdt_ops,
 };
 
-static int __devinit max63xx_wdt_probe(struct platform_device *pdev)
+static int max63xx_wdt_probe(struct platform_device *pdev)
 {
 	struct resource	*wdt_mem;
 	struct max63xx_timeout *table;
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index e44d6d9..5c23a6b 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -188,7 +188,7 @@ static struct miscdevice mpc8xxx_wdt_miscdev = {
 };
 
 static const struct of_device_id mpc8xxx_wdt_match[];
-static int __devinit mpc8xxx_wdt_probe(struct platform_device *ofdev)
+static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 {
 	int ret;
 	const struct of_device_id *match;
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index cf66cee..4f90ac5 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -327,7 +327,7 @@ static struct miscdevice mpcore_wdt_miscdev = {
 	.fops		= &mpcore_wdt_fops,
 };
 
-static int __devinit mpcore_wdt_probe(struct platform_device *pdev)
+static int mpcore_wdt_probe(struct platform_device *pdev)
 {
 	struct mpcore_wdt *wdt;
 	struct resource *res;
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 5474a06..8c64276 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -204,7 +204,7 @@ static struct miscdevice mtx1_wdt_misc = {
 };
 
 
-static int __devinit mtx1_wdt_probe(struct platform_device *pdev)
+static int mtx1_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 
diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
index 7d37da5..2876027 100644
--- a/drivers/watchdog/mv64x60_wdt.c
+++ b/drivers/watchdog/mv64x60_wdt.c
@@ -253,7 +253,7 @@ static struct miscdevice mv64x60_wdt_miscdev = {
 	.fops = &mv64x60_wdt_fops,
 };
 
-static int __devinit mv64x60_wdt_probe(struct platform_device *dev)
+static int mv64x60_wdt_probe(struct platform_device *dev)
 {
 	struct mv64x60_wdt_pdata *pdata = dev->dev.platform_data;
 	struct resource *r;
diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index a77f690..d05daef 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -242,7 +242,7 @@ static struct miscdevice nuc900wdt_miscdev = {
 	.fops		= &nuc900wdt_fops,
 };
 
-static int __devinit nuc900wdt_probe(struct platform_device *pdev)
+static int nuc900wdt_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index e0d4496..45452845 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -302,7 +302,7 @@ MODULE_DEVICE_TABLE(pci, tco_pci_tbl);
  *	Init & exit routines
  */
 
-static unsigned char __devinit nv_tco_getdevice(void)
+static unsigned char nv_tco_getdevice(void)
 {
 	struct pci_dev *dev = NULL;
 	u32 val;
@@ -376,7 +376,7 @@ out:
 	return 0;
 }
 
-static int __devinit nv_tco_init(struct platform_device *dev)
+static int nv_tco_init(struct platform_device *dev)
 {
 	int ret;
 
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index df8c5f3..fd3e5f6 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -289,7 +289,7 @@ static struct miscdevice xwdt_miscdev = {
 	.fops       = &xwdt_fops,
 };
 
-static int __devinit xwdt_probe(struct platform_device *pdev)
+static int xwdt_probe(struct platform_device *pdev)
 {
 	int rc;
 	u32 *tmptr;
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1596a5d..36a7246 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -264,7 +264,7 @@ static const struct file_operations omap_wdt_fops = {
 	.llseek = no_llseek,
 };
 
-static int __devinit omap_wdt_probe(struct platform_device *pdev)
+static int omap_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res, *mem;
 	struct omap_wdt_dev *wdev;
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 33a0872..e6b7bd2 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -142,7 +142,7 @@ static struct watchdog_device orion_wdt = {
 	.ops = &orion_wdt_ops,
 };
 
-static int __devinit orion_wdt_probe(struct platform_device *pdev)
+static int orion_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res;
 	int ret;
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index df454c9..cef246a 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -801,7 +801,7 @@ static inline int get_revision(void)
  *  The initial rate is once per second at board start up, then twice
  *  per second for normal operation.
  */
-static int __devinit pcwd_isa_match(struct device *dev, unsigned int id)
+static int pcwd_isa_match(struct device *dev, unsigned int id)
 {
 	int base_addr = pcwd_ioports[id];
 	int port0, last_port0;	/* Reg 0, in case it's REV A */
@@ -846,7 +846,7 @@ static int __devinit pcwd_isa_match(struct device *dev, unsigned int id)
 	return retval;
 }
 
-static int __devinit pcwd_isa_probe(struct device *dev, unsigned int id)
+static int pcwd_isa_probe(struct device *dev, unsigned int id)
 {
 	int ret;
 
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index 1407a6f..6ec84b5 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -682,7 +682,7 @@ static struct notifier_block pcipcwd_notifier = {
  *	Init & exit routines
  */
 
-static int __devinit pcipcwd_card_init(struct pci_dev *pdev,
+static int pcipcwd_card_init(struct pci_dev *pdev,
 		const struct pci_device_id *ent)
 {
 	int ret = -EIO;
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 5c07fa4..4f7afea 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -146,7 +146,7 @@ static struct watchdog_device pnx4008_wdd = {
 	.max_timeout = MAX_HEARTBEAT,
 };
 
-static int __devinit pnx4008_wdt_probe(struct platform_device *pdev)
+static int pnx4008_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *r;
 	int ret = 0;
diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index cf983d3..2266280 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -260,7 +260,7 @@ static struct miscdevice rc32434_wdt_miscdev = {
 	.fops	= &rc32434_wdt_fops,
 };
 
-static int __devinit rc32434_wdt_probe(struct platform_device *pdev)
+static int rc32434_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct resource *r;
diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index 2768214..9466706 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -225,7 +225,7 @@ static struct miscdevice rdc321x_wdt_misc = {
 	.fops	= &rdc321x_wdt_fops,
 };
 
-static int __devinit rdc321x_wdt_probe(struct platform_device *pdev)
+static int rdc321x_wdt_probe(struct platform_device *pdev)
 {
 	int err;
 	struct resource *r;
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 65851f4..84f5233 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -174,7 +174,7 @@ static struct miscdevice riowd_miscdev = {
 	.fops	= &riowd_fops
 };
 
-static int __devinit riowd_probe(struct platform_device *op)
+static int riowd_probe(struct platform_device *op)
 {
 	struct riowd *p;
 	int err = -EINVAL;
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index c317420..2e28c14 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -303,7 +303,7 @@ static inline void s3c2410wdt_cpufreq_deregister(void)
 }
 #endif
 
-static int __devinit s3c2410wdt_probe(struct platform_device *pdev)
+static int s3c2410wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev;
 	unsigned int wtcon;
diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index 766b132..8ecec29 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -356,7 +356,7 @@ static struct miscdevice sch311x_wdt_miscdev = {
  *	Init & exit routines
  */
 
-static int __devinit sch311x_wdt_probe(struct platform_device *pdev)
+static int sch311x_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	int err;
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index ce1be6e..9c57af9 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -217,7 +217,7 @@ static struct watchdog_device sh_wdt_dev = {
 	.ops	= &sh_wdt_ops,
 };
 
-static int __devinit sh_wdt_probe(struct platform_device *pdev)
+static int sh_wdt_probe(struct platform_device *pdev)
 {
 	struct sh_wdt *wdt;
 	struct resource *res;
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 066901b..7ee39a7 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -271,7 +271,7 @@ MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
  * Init & exit routines
  */
 
-static unsigned char __devinit sp5100_tco_setupdevice(void)
+static unsigned char sp5100_tco_setupdevice(void)
 {
 	struct pci_dev *dev = NULL;
 	u32 val;
@@ -361,7 +361,7 @@ exit:
 	return 0;
 }
 
-static int __devinit sp5100_tco_init(struct platform_device *dev)
+static int sp5100_tco_init(struct platform_device *dev)
 {
 	int ret;
 	u32 val;
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index cd5812f..05bfde4 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -210,7 +210,7 @@ static const struct watchdog_ops wdt_ops = {
 	.get_timeleft	= wdt_timeleft,
 };
 
-static int __devinit
+static int
 sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	struct sp805_wdt *wdt;
diff --git a/drivers/watchdog/stmp3xxx_wdt.c b/drivers/watchdog/stmp3xxx_wdt.c
index 4226250..254cce3 100644
--- a/drivers/watchdog/stmp3xxx_wdt.c
+++ b/drivers/watchdog/stmp3xxx_wdt.c
@@ -204,7 +204,7 @@ static struct miscdevice stmp3xxx_wdt_miscdev = {
 	.fops = &stmp3xxx_wdt_fops,
 };
 
-static int __devinit stmp3xxx_wdt_probe(struct platform_device *pdev)
+static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 2acc1fe..d6e94b4 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -390,7 +390,7 @@ static struct miscdevice ts72xx_wdt_miscdev = {
 	.fops		= &ts72xx_wdt_fops,
 };
 
-static __devinit int ts72xx_wdt_probe(struct platform_device *pdev)
+static int ts72xx_wdt_probe(struct platform_device *pdev)
 {
 	struct ts72xx_wdt *wdt;
 	struct resource *r1, *r2;
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index cf59a38..6dab509 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -170,7 +170,7 @@ static const struct file_operations twl4030_wdt_fops = {
 	.write		= twl4030_wdt_write_fop,
 };
 
-static int __devinit twl4030_wdt_probe(struct platform_device *pdev)
+static int twl4030_wdt_probe(struct platform_device *pdev)
 {
 	int ret = 0;
 	struct twl4030_wdt *wdt;
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index a9af1dd..098dfab 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -155,7 +155,7 @@ static struct watchdog_device wdt_dev = {
 	.max_timeout =	WDT_TIMEOUT_MAX,
 };
 
-static int __devinit wdt_probe(struct pci_dev *pdev,
+static int wdt_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *ent)
 {
 	unsigned char conf;
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index 05c14e4..13d27c8 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -605,7 +605,7 @@ static struct notifier_block wdtpci_notifier = {
 };
 
 
-static int __devinit wdtpci_init_one(struct pci_dev *dev,
+static int wdtpci_init_one(struct pci_dev *dev,
 					const struct pci_device_id *ent)
 {
 	int ret = -EIO;
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index f9c54fe..170c82e 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -181,7 +181,7 @@ static const struct watchdog_ops wm831x_wdt_ops = {
 	.set_timeout = wm831x_wdt_set_timeout,
 };
 
-static int __devinit wm831x_wdt_probe(struct platform_device *pdev)
+static int wm831x_wdt_probe(struct platform_device *pdev)
 {
 	struct wm831x *wm831x = dev_get_drvdata(pdev->dev.parent);
 	struct wm831x_pdata *chip_pdata;
diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index 770b6da..4530fa0 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -140,7 +140,7 @@ static struct watchdog_device wm8350_wdt = {
 	.max_timeout = 4,
 };
 
-static int __devinit wm8350_wdt_probe(struct platform_device *pdev)
+static int wm8350_wdt_probe(struct platform_device *pdev)
 {
 	struct wm8350 *wm8350 = platform_get_drvdata(pdev);
 
diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index 99b956f..1eb6bdc 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -244,7 +244,7 @@ static struct miscdevice xen_wdt_miscdev = {
 	.fops =		&xen_wdt_fops,
 };
 
-static int __devinit xen_wdt_probe(struct platform_device *dev)
+static int xen_wdt_probe(struct platform_device *dev)
 {
 	struct sched_watchdog wd = { .id = ~0 };
 	int ret = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wd);
-- 
1.8.0

