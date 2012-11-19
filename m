Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:42027 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754346Ab2KSSsB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Nov 2012 13:48:01 -0500
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
Subject: [PATCH 435/493] watchdog: remove use of __devexit
Date: Mon, 19 Nov 2012 13:26:24 -0500
Message-Id: <1353349642-3677-435-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

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
 drivers/watchdog/acquirewdt.c     | 2 +-
 drivers/watchdog/advantechwdt.c   | 2 +-
 drivers/watchdog/ar7_wdt.c        | 2 +-
 drivers/watchdog/at91rm9200_wdt.c | 2 +-
 drivers/watchdog/ath79_wdt.c      | 2 +-
 drivers/watchdog/bcm63xx_wdt.c    | 2 +-
 drivers/watchdog/bfin_wdt.c       | 2 +-
 drivers/watchdog/cpu5wdt.c        | 4 ++--
 drivers/watchdog/cpwd.c           | 2 +-
 drivers/watchdog/da9052_wdt.c     | 2 +-
 drivers/watchdog/davinci_wdt.c    | 2 +-
 drivers/watchdog/dw_wdt.c         | 2 +-
 drivers/watchdog/ep93xx_wdt.c     | 2 +-
 drivers/watchdog/gef_wdt.c        | 2 +-
 drivers/watchdog/geodewdt.c       | 2 +-
 drivers/watchdog/hpwdt.c          | 2 +-
 drivers/watchdog/i6300esb.c       | 2 +-
 drivers/watchdog/iTCO_wdt.c       | 4 ++--
 drivers/watchdog/ib700wdt.c       | 2 +-
 drivers/watchdog/ie6xx_wdt.c      | 2 +-
 drivers/watchdog/jz4740_wdt.c     | 2 +-
 drivers/watchdog/ks8695_wdt.c     | 2 +-
 drivers/watchdog/lantiq_wdt.c     | 2 +-
 drivers/watchdog/max63xx_wdt.c    | 2 +-
 drivers/watchdog/mpc8xxx_wdt.c    | 2 +-
 drivers/watchdog/mpcore_wdt.c     | 2 +-
 drivers/watchdog/mtx-1_wdt.c      | 2 +-
 drivers/watchdog/mv64x60_wdt.c    | 2 +-
 drivers/watchdog/nuc900_wdt.c     | 2 +-
 drivers/watchdog/nv_tco.c         | 4 ++--
 drivers/watchdog/of_xilinx_wdt.c  | 2 +-
 drivers/watchdog/omap_wdt.c       | 2 +-
 drivers/watchdog/orion_wdt.c      | 2 +-
 drivers/watchdog/pcwd.c           | 2 +-
 drivers/watchdog/pcwd_pci.c       | 2 +-
 drivers/watchdog/pnx4008_wdt.c    | 2 +-
 drivers/watchdog/rc32434_wdt.c    | 2 +-
 drivers/watchdog/rdc321x_wdt.c    | 2 +-
 drivers/watchdog/riowd.c          | 2 +-
 drivers/watchdog/s3c2410_wdt.c    | 2 +-
 drivers/watchdog/sch311x_wdt.c    | 2 +-
 drivers/watchdog/shwdt.c          | 2 +-
 drivers/watchdog/sp5100_tco.c     | 4 ++--
 drivers/watchdog/sp805_wdt.c      | 2 +-
 drivers/watchdog/stmp3xxx_wdt.c   | 2 +-
 drivers/watchdog/ts72xx_wdt.c     | 2 +-
 drivers/watchdog/twl4030_wdt.c    | 2 +-
 drivers/watchdog/via_wdt.c        | 2 +-
 drivers/watchdog/wdt_pci.c        | 2 +-
 drivers/watchdog/wm831x_wdt.c     | 2 +-
 drivers/watchdog/wm8350_wdt.c     | 2 +-
 drivers/watchdog/xen_wdt.c        | 2 +-
 52 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index e009f93..24a5177 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -275,7 +275,7 @@ out:
 	return ret;
 }
 
-static int __devexit acq_remove(struct platform_device *dev)
+static int acq_remove(struct platform_device *dev)
 {
 	misc_deregister(&acq_miscdev);
 	release_region(wdt_start, 1);
diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index cc50c57..cc6702f 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -282,7 +282,7 @@ unreg_stop:
 	goto out;
 }
 
-static int __devexit advwdt_remove(struct platform_device *dev)
+static int advwdt_remove(struct platform_device *dev)
 {
 	misc_deregister(&advwdt_miscdev);
 	release_region(wdt_start, 1);
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index 154347e..3003e2a 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -314,7 +314,7 @@ out:
 	return rc;
 }
 
-static int __devexit ar7_wdt_remove(struct platform_device *pdev)
+static int ar7_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&ar7_wdt_miscdev);
 	clk_put(vbus_clk);
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index cc290bb..89831ed 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -216,7 +216,7 @@ static int at91wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit at91wdt_remove(struct platform_device *pdev)
+static int at91wdt_remove(struct platform_device *pdev)
 {
 	int res;
 
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 5c0967d..7c8ede7 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -270,7 +270,7 @@ err_clk_put:
 	return err;
 }
 
-static int __devexit ath79_wdt_remove(struct platform_device *pdev)
+static int ath79_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&ath79_wdt_miscdev);
 	clk_disable(wdt_clk);
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 5a7cff6..b2b80d4 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -286,7 +286,7 @@ unmap:
 	return ret;
 }
 
-static int __devexit bcm63xx_wdt_remove(struct platform_device *pdev)
+static int bcm63xx_wdt_remove(struct platform_device *pdev)
 {
 	if (!nowayout)
 		bcm63xx_wdt_pause();
diff --git a/drivers/watchdog/bfin_wdt.c b/drivers/watchdog/bfin_wdt.c
index 241f8af..5d36d6f 100644
--- a/drivers/watchdog/bfin_wdt.c
+++ b/drivers/watchdog/bfin_wdt.c
@@ -379,7 +379,7 @@ static int bfin_wdt_probe(struct platform_device *pdev)
  *	Unregisters the misc device.  Actual device
  *	deinitialization is handled by bfin_wdt_close().
  */
-static int __devexit bfin_wdt_remove(struct platform_device *pdev)
+static int bfin_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&bfin_wdt_miscdev);
 	return 0;
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 6eb710b..cd87758 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -261,7 +261,7 @@ static int cpu5wdt_init_module(void)
 	return cpu5wdt_init();
 }
 
-static void __devexit cpu5wdt_exit(void)
+static void cpu5wdt_exit(void)
 {
 	if (cpu5wdt_device.queue) {
 		cpu5wdt_device.queue = 0;
@@ -274,7 +274,7 @@ static void __devexit cpu5wdt_exit(void)
 
 }
 
-static void __devexit cpu5wdt_exit_module(void)
+static void cpu5wdt_exit_module(void)
 {
 	cpu5wdt_exit();
 }
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 731578b..11d55ce 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -640,7 +640,7 @@ out_free:
 	goto out;
 }
 
-static int __devexit cpwd_remove(struct platform_device *op)
+static int cpwd_remove(struct platform_device *op)
 {
 	struct cpwd *p = dev_get_drvdata(&op->dev);
 	int i;
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index 93a3165..8be70d8 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -224,7 +224,7 @@ err:
 	return ret;
 }
 
-static int __devexit da9052_wdt_remove(struct platform_device *pdev)
+static int da9052_wdt_remove(struct platform_device *pdev)
 {
 	struct da9052_wdt_data *driver_data = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 9f371b8..6000aea 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -248,7 +248,7 @@ static int davinci_wdt_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit davinci_wdt_remove(struct platform_device *pdev)
+static int davinci_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&davinci_wdt_miscdev);
 	if (wdt_mem) {
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 49e24e5..a0eba3c 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -333,7 +333,7 @@ out_put_clk:
 	return ret;
 }
 
-static int __devexit dw_wdt_drv_remove(struct platform_device *pdev)
+static int dw_wdt_drv_remove(struct platform_device *pdev)
 {
 	misc_deregister(&dw_wdt_miscdev);
 
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index f1bd88c..e057484 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -156,7 +156,7 @@ static int ep93xx_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ep93xx_wdt_remove(struct platform_device *pdev)
+static int ep93xx_wdt_remove(struct platform_device *pdev)
 {
 	watchdog_unregister_device(&ep93xx_wdt_wdd);
 	return 0;
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index 276f009..b9c5b58 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -285,7 +285,7 @@ static int gef_wdt_probe(struct platform_device *dev)
 	return misc_register(&gef_wdt_miscdev);
 }
 
-static int __devexit gef_wdt_remove(struct platform_device *dev)
+static int gef_wdt_remove(struct platform_device *dev)
 {
 	misc_deregister(&gef_wdt_miscdev);
 
diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index 28a3a87..fcd599d 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -243,7 +243,7 @@ static int geodewdt_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int __devexit geodewdt_remove(struct platform_device *dev)
+static int geodewdt_remove(struct platform_device *dev)
 {
 	misc_deregister(&geodewdt_miscdev);
 	return 0;
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index cc25ddf..8717255 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -848,7 +848,7 @@ error_pci_iomap:
 	return retval;
 }
 
-static void __devexit hpwdt_exit(struct pci_dev *dev)
+static void hpwdt_exit(struct pci_dev *dev)
 {
 	if (!nowayout)
 		hpwdt_stop();
diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 31b87db..2b2ea13 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -465,7 +465,7 @@ err_unmap:
 	return ret;
 }
 
-static void __devexit esb_remove(struct pci_dev *pdev)
+static void esb_remove(struct pci_dev *pdev)
 {
 	/* Stop the timer before we leave */
 	if (!nowayout)
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index fb341df..6130321 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -364,7 +364,7 @@ static struct watchdog_device iTCO_wdt_watchdog_dev = {
  *	Init & exit routines
  */
 
-static void __devexit iTCO_wdt_cleanup(void)
+static void iTCO_wdt_cleanup(void)
 {
 	/* Stop the timer before we leave */
 	if (!nowayout)
@@ -533,7 +533,7 @@ out:
 	return ret;
 }
 
-static int __devexit iTCO_wdt_remove(struct platform_device *dev)
+static int iTCO_wdt_remove(struct platform_device *dev)
 {
 	if (iTCO_wdt_private.tco_res || iTCO_wdt_private.smi_res)
 		iTCO_wdt_cleanup();
diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index 5249596..eb6b5cc 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -319,7 +319,7 @@ out_nostopreg:
 	return res;
 }
 
-static int __devexit ibwdt_remove(struct platform_device *dev)
+static int ibwdt_remove(struct platform_device *dev)
 {
 	misc_deregister(&ibwdt_miscdev);
 	release_region(WDT_START, 1);
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 94eef6f..e24ef6a 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -295,7 +295,7 @@ misc_register_error:
 	return ret;
 }
 
-static int __devexit ie6xx_wdt_remove(struct platform_device *pdev)
+static int ie6xx_wdt_remove(struct platform_device *pdev)
 {
 	struct resource *res;
 
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index eb7008a..a61408f 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -197,7 +197,7 @@ err_out:
 	return ret;
 }
 
-static int __devexit jz4740_wdt_remove(struct platform_device *pdev)
+static int jz4740_wdt_remove(struct platform_device *pdev)
 {
 	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
 
diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index c305adb..dce9ecf 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -252,7 +252,7 @@ static int ks8695wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit ks8695wdt_remove(struct platform_device *pdev)
+static int ks8695wdt_remove(struct platform_device *pdev)
 {
 	int res;
 
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index fd9f43c..79fe01b 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -220,7 +220,7 @@ ltq_wdt_probe(struct platform_device *pdev)
 	return misc_register(&ltq_wdt_miscdev);
 }
 
-static int __devexit
+static int
 ltq_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&ltq_wdt_miscdev);
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index b572c75..773c661 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -209,7 +209,7 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 	return watchdog_register_device(&max63xx_wdt_dev);
 }
 
-static int __devexit max63xx_wdt_remove(struct platform_device *pdev)
+static int max63xx_wdt_remove(struct platform_device *pdev)
 {
 	watchdog_unregister_device(&max63xx_wdt_dev);
 	return 0;
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 5c23a6b..da27520 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -245,7 +245,7 @@ err_unmap:
 	return ret;
 }
 
-static int __devexit mpc8xxx_wdt_remove(struct platform_device *ofdev)
+static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
 {
 	mpc8xxx_wdt_pr_warn("watchdog removed");
 	del_timer_sync(&wdt_timer);
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 4f90ac5..a84eb55 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -378,7 +378,7 @@ static int mpcore_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
+static int mpcore_wdt_remove(struct platform_device *pdev)
 {
 	platform_set_drvdata(pdev, NULL);
 
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index 8c64276..14dab6f 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -233,7 +233,7 @@ static int mtx1_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
+static int mtx1_wdt_remove(struct platform_device *pdev)
 {
 	/* FIXME: do we need to lock this test ? */
 	if (mtx1_wdt_device.queue) {
diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
index 2876027..c7fb878 100644
--- a/drivers/watchdog/mv64x60_wdt.c
+++ b/drivers/watchdog/mv64x60_wdt.c
@@ -287,7 +287,7 @@ static int mv64x60_wdt_probe(struct platform_device *dev)
 	return misc_register(&mv64x60_wdt_miscdev);
 }
 
-static int __devexit mv64x60_wdt_remove(struct platform_device *dev)
+static int mv64x60_wdt_remove(struct platform_device *dev)
 {
 	misc_deregister(&mv64x60_wdt_miscdev);
 
diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index d05daef..04c45a1 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -309,7 +309,7 @@ err_get:
 	return ret;
 }
 
-static int __devexit nuc900wdt_remove(struct platform_device *pdev)
+static int nuc900wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&nuc900wdt_miscdev);
 
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index 45452845..59cf19e 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -423,7 +423,7 @@ unreg_region:
 	return ret;
 }
 
-static void __devexit nv_tco_cleanup(void)
+static void nv_tco_cleanup(void)
 {
 	u32 val;
 
@@ -445,7 +445,7 @@ static void __devexit nv_tco_cleanup(void)
 	release_region(tcobase, 0x10);
 }
 
-static int __devexit nv_tco_remove(struct platform_device *dev)
+static int nv_tco_remove(struct platform_device *dev)
 {
 	if (tcobase)
 		nv_tco_cleanup();
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 3ddc4e9..2761ddb 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -383,7 +383,7 @@ err_out:
 	return rc;
 }
 
-static int __devexit xwdt_remove(struct platform_device *dev)
+static int xwdt_remove(struct platform_device *dev)
 {
 	misc_deregister(&xwdt_miscdev);
 	iounmap(xdev.base);
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 36a7246..d8da516 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -359,7 +359,7 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 	}
 }
 
-static int __devexit omap_wdt_remove(struct platform_device *pdev)
+static int omap_wdt_remove(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index f722635..0478b00 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -181,7 +181,7 @@ static int orion_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit orion_wdt_remove(struct platform_device *pdev)
+static int orion_wdt_remove(struct platform_device *pdev)
 {
 	watchdog_unregister_device(&orion_wdt);
 	clk_disable_unprepare(clk);
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index cef246a..33e49a7 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -949,7 +949,7 @@ error_request_region:
 	return ret;
 }
 
-static int __devexit pcwd_isa_remove(struct device *dev, unsigned int id)
+static int pcwd_isa_remove(struct device *dev, unsigned int id)
 {
 	if (debug >= DEBUG)
 		pr_debug("pcwd_isa_remove id=%d\n", id);
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index 6ec84b5..7890f84 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -785,7 +785,7 @@ err_out_disable_device:
 	return ret;
 }
 
-static void __devexit pcipcwd_card_exit(struct pci_dev *pdev)
+static void pcipcwd_card_exit(struct pci_dev *pdev)
 {
 	/* Stop the timer before we leave */
 	if (!nowayout)
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 4f7afea..dcba5da 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -192,7 +192,7 @@ out:
 	return ret;
 }
 
-static int __devexit pnx4008_wdt_remove(struct platform_device *pdev)
+static int pnx4008_wdt_remove(struct platform_device *pdev)
 {
 	watchdog_unregister_device(&pnx4008_wdd);
 
diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index 2266280..f78bc00 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -306,7 +306,7 @@ unmap:
 	return ret;
 }
 
-static int __devexit rc32434_wdt_remove(struct platform_device *pdev)
+static int rc32434_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&rc32434_wdt_miscdev);
 	iounmap(wdt_reg);
diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index 9466706..b0f116c 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -272,7 +272,7 @@ static int rdc321x_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit rdc321x_wdt_remove(struct platform_device *pdev)
+static int rdc321x_wdt_remove(struct platform_device *pdev)
 {
 	if (rdc321x_wdt_device.queue) {
 		rdc321x_wdt_device.queue = 0;
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 84f5233..0040451 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -220,7 +220,7 @@ out:
 	return err;
 }
 
-static int __devexit riowd_remove(struct platform_device *op)
+static int riowd_remove(struct platform_device *op)
 {
 	struct riowd *p = dev_get_drvdata(&op->dev);
 
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 2e28c14..b0dab10 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -437,7 +437,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit s3c2410wdt_remove(struct platform_device *dev)
+static int s3c2410wdt_remove(struct platform_device *dev)
 {
 	watchdog_unregister_device(&s3c2410_wdd);
 
diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index 8ecec29..af7b136 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -429,7 +429,7 @@ exit:
 	return err;
 }
 
-static int __devexit sch311x_wdt_remove(struct platform_device *pdev)
+static int sch311x_wdt_remove(struct platform_device *pdev)
 {
 	/* Stop the timer before we leave */
 	if (!nowayout)
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index 9c57af9..6a89e40 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -298,7 +298,7 @@ err:
 	return rc;
 }
 
-static int __devexit sh_wdt_remove(struct platform_device *pdev)
+static int sh_wdt_remove(struct platform_device *pdev)
 {
 	struct sh_wdt *wdt = platform_get_drvdata(pdev);
 
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 7ee39a7..b387681 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -412,7 +412,7 @@ exit:
 	return ret;
 }
 
-static void __devexit sp5100_tco_cleanup(void)
+static void sp5100_tco_cleanup(void)
 {
 	/* Stop the timer before we leave */
 	if (!nowayout)
@@ -425,7 +425,7 @@ static void __devexit sp5100_tco_cleanup(void)
 	release_region(pm_iobase, SP5100_PM_IOPORTS_SIZE);
 }
 
-static int __devexit sp5100_tco_remove(struct platform_device *dev)
+static int sp5100_tco_remove(struct platform_device *dev)
 {
 	if (tcobase)
 		sp5100_tco_cleanup();
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 05bfde4..76c73cb 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -272,7 +272,7 @@ err:
 	return ret;
 }
 
-static int __devexit sp805_wdt_remove(struct amba_device *adev)
+static int sp805_wdt_remove(struct amba_device *adev)
 {
 	struct sp805_wdt *wdt = amba_get_drvdata(adev);
 
diff --git a/drivers/watchdog/stmp3xxx_wdt.c b/drivers/watchdog/stmp3xxx_wdt.c
index 254cce3..1f4f697 100644
--- a/drivers/watchdog/stmp3xxx_wdt.c
+++ b/drivers/watchdog/stmp3xxx_wdt.c
@@ -229,7 +229,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __devexit stmp3xxx_wdt_remove(struct platform_device *pdev)
+static int stmp3xxx_wdt_remove(struct platform_device *pdev)
 {
 	misc_deregister(&stmp3xxx_wdt_miscdev);
 	return 0;
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index d6e94b4..b8a9245 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -476,7 +476,7 @@ fail:
 	return error;
 }
 
-static __devexit int ts72xx_wdt_remove(struct platform_device *pdev)
+static int ts72xx_wdt_remove(struct platform_device *pdev)
 {
 	struct ts72xx_wdt *wdt = platform_get_drvdata(pdev);
 	struct resource *res;
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 6dab509..9f54b1d 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -204,7 +204,7 @@ static int twl4030_wdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit twl4030_wdt_remove(struct platform_device *pdev)
+static int twl4030_wdt_remove(struct platform_device *pdev)
 {
 	struct twl4030_wdt *wdt = platform_get_drvdata(pdev);
 
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index 098dfab..1a68f76 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -229,7 +229,7 @@ err_out_disable_device:
 	return ret;
 }
 
-static void __devexit wdt_remove(struct pci_dev *pdev)
+static void wdt_remove(struct pci_dev *pdev)
 {
 	watchdog_unregister_device(&wdt_dev);
 	del_timer(&timer);
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index 13d27c8..36a54c0 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -705,7 +705,7 @@ out_pci:
 }
 
 
-static void __devexit wdtpci_remove_one(struct pci_dev *pdev)
+static void wdtpci_remove_one(struct pci_dev *pdev)
 {
 	/* here we assume only one device will ever have
 	 * been picked up and registered by probe function */
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 170c82e..9dcb6d0 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -292,7 +292,7 @@ err:
 	return ret;
 }
 
-static int __devexit wm831x_wdt_remove(struct platform_device *pdev)
+static int wm831x_wdt_remove(struct platform_device *pdev)
 {
 	struct wm831x_wdt_drvdata *driver_data = dev_get_drvdata(&pdev->dev);
 
diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index 4530fa0..34d272a 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -158,7 +158,7 @@ static int wm8350_wdt_probe(struct platform_device *pdev)
 	return watchdog_register_device(&wm8350_wdt);
 }
 
-static int __devexit wm8350_wdt_remove(struct platform_device *pdev)
+static int wm8350_wdt_remove(struct platform_device *pdev)
 {
 	watchdog_unregister_device(&wm8350_wdt);
 	return 0;
diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index 1eb6bdc..92ad33d 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -280,7 +280,7 @@ static int xen_wdt_probe(struct platform_device *dev)
 	return ret;
 }
 
-static int __devexit xen_wdt_remove(struct platform_device *dev)
+static int xen_wdt_remove(struct platform_device *dev)
 {
 	/* Stop the timer before we leave */
 	if (!nowayout)
-- 
1.8.0

