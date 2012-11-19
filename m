Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41698 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754161Ab2KSSiQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 19 Nov 2012 13:38:16 -0500
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
Subject: [PATCH 123/493] watchdog: remove use of __devexit_p
Date: Mon, 19 Nov 2012 13:21:12 -0500
Message-Id: <1353349642-3677-123-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
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
 drivers/watchdog/acquirewdt.c     | 2 +-
 drivers/watchdog/advantechwdt.c   | 2 +-
 drivers/watchdog/ar7_wdt.c        | 2 +-
 drivers/watchdog/at91rm9200_wdt.c | 2 +-
 drivers/watchdog/ath79_wdt.c      | 2 +-
 drivers/watchdog/bcm63xx_wdt.c    | 2 +-
 drivers/watchdog/bfin_wdt.c       | 2 +-
 drivers/watchdog/cpwd.c           | 2 +-
 drivers/watchdog/da9052_wdt.c     | 2 +-
 drivers/watchdog/davinci_wdt.c    | 2 +-
 drivers/watchdog/dw_wdt.c         | 2 +-
 drivers/watchdog/ep93xx_wdt.c     | 2 +-
 drivers/watchdog/geodewdt.c       | 2 +-
 drivers/watchdog/hpwdt.c          | 2 +-
 drivers/watchdog/i6300esb.c       | 2 +-
 drivers/watchdog/iTCO_wdt.c       | 2 +-
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
 drivers/watchdog/nv_tco.c         | 2 +-
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
 drivers/watchdog/sp5100_tco.c     | 2 +-
 drivers/watchdog/sp805_wdt.c      | 2 +-
 drivers/watchdog/stmp3xxx_wdt.c   | 2 +-
 drivers/watchdog/ts72xx_wdt.c     | 2 +-
 drivers/watchdog/twl4030_wdt.c    | 2 +-
 drivers/watchdog/via_wdt.c        | 2 +-
 drivers/watchdog/wdt_pci.c        | 2 +-
 drivers/watchdog/wm831x_wdt.c     | 2 +-
 drivers/watchdog/wm8350_wdt.c     | 2 +-
 drivers/watchdog/xen_wdt.c        | 2 +-
 50 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index 4397881..49e0b89 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -293,7 +293,7 @@ static void acq_shutdown(struct platform_device *dev)
 
 static struct platform_driver acquirewdt_driver = {
 	.probe		= acq_probe,
-	.remove		= __devexit_p(acq_remove),
+	.remove		= acq_remove,
 	.shutdown	= acq_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index 64ae9e9..9a74156 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -300,7 +300,7 @@ static void advwdt_shutdown(struct platform_device *dev)
 
 static struct platform_driver advwdt_driver = {
 	.probe		= advwdt_probe,
-	.remove		= __devexit_p(advwdt_remove),
+	.remove		= advwdt_remove,
 	.shutdown	= advwdt_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index dc30dbd..eb633d9 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -330,7 +330,7 @@ static void ar7_wdt_shutdown(struct platform_device *pdev)
 
 static struct platform_driver ar7_wdt_driver = {
 	.probe = ar7_wdt_probe,
-	.remove = __devexit_p(ar7_wdt_remove),
+	.remove = ar7_wdt_remove,
 	.shutdown = ar7_wdt_shutdown,
 	.driver = {
 		.owner = THIS_MODULE,
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index 7ef99a1..75f3a6b 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -254,7 +254,7 @@ static int at91wdt_resume(struct platform_device *pdev)
 
 static struct platform_driver at91wdt_driver = {
 	.probe		= at91wdt_probe,
-	.remove		= __devexit_p(at91wdt_remove),
+	.remove		= at91wdt_remove,
 	.shutdown	= at91wdt_shutdown,
 	.suspend	= at91wdt_suspend,
 	.resume		= at91wdt_resume,
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index 1f9371f..367ef5e 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -284,7 +284,7 @@ static void ath97_wdt_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver ath79_wdt_driver = {
-	.remove		= __devexit_p(ath79_wdt_remove),
+	.remove		= ath79_wdt_remove,
 	.shutdown	= ath97_wdt_shutdown,
 	.driver		= {
 		.name	= DRIVER_NAME,
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 551880b..e81b784 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -304,7 +304,7 @@ static void bcm63xx_wdt_shutdown(struct platform_device *pdev)
 
 static struct platform_driver bcm63xx_wdt_driver = {
 	.probe	= bcm63xx_wdt_probe,
-	.remove = __devexit_p(bcm63xx_wdt_remove),
+	.remove = bcm63xx_wdt_remove,
 	.shutdown = bcm63xx_wdt_shutdown,
 	.driver = {
 		.owner = THIS_MODULE,
diff --git a/drivers/watchdog/bfin_wdt.c b/drivers/watchdog/bfin_wdt.c
index 38bc383..4a85dbf 100644
--- a/drivers/watchdog/bfin_wdt.c
+++ b/drivers/watchdog/bfin_wdt.c
@@ -401,7 +401,7 @@ static struct platform_device *bfin_wdt_device;
 
 static struct platform_driver bfin_wdt_driver = {
 	.probe     = bfin_wdt_probe,
-	.remove    = __devexit_p(bfin_wdt_remove),
+	.remove    = bfin_wdt_remove,
 	.shutdown  = bfin_wdt_shutdown,
 	.suspend   = bfin_wdt_suspend,
 	.resume    = bfin_wdt_resume,
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index 95b1b95..ed7f434 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -684,7 +684,7 @@ static struct platform_driver cpwd_driver = {
 		.of_match_table = cpwd_match,
 	},
 	.probe		= cpwd_probe,
-	.remove		= __devexit_p(cpwd_remove),
+	.remove		= cpwd_remove,
 };
 
 module_platform_driver(cpwd_driver);
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index f7abbae..463e9e5 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -236,7 +236,7 @@ static int __devexit da9052_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver da9052_wdt_driver = {
 	.probe = da9052_wdt_probe,
-	.remove = __devexit_p(da9052_wdt_remove),
+	.remove = da9052_wdt_remove,
 	.driver = {
 		.name	= "da9052-watchdog",
 	},
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index eb44b03..00b509c 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -268,7 +268,7 @@ static struct platform_driver platform_wdt_driver = {
 		.owner	= THIS_MODULE,
 	},
 	.probe = davinci_wdt_probe,
-	.remove = __devexit_p(davinci_wdt_remove),
+	.remove = davinci_wdt_remove,
 };
 
 module_platform_driver(platform_wdt_driver);
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index 06de121..6a8448d 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -345,7 +345,7 @@ static int __devexit dw_wdt_drv_remove(struct platform_device *pdev)
 
 static struct platform_driver dw_wdt_driver = {
 	.probe		= dw_wdt_drv_probe,
-	.remove		= __devexit_p(dw_wdt_drv_remove),
+	.remove		= dw_wdt_drv_remove,
 	.driver		= {
 		.name	= "dw_wdt",
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index 7705003..91703a5 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -168,7 +168,7 @@ static struct platform_driver ep93xx_wdt_driver = {
 		.name	= "ep93xx-wdt",
 	},
 	.probe		= ep93xx_wdt_probe,
-	.remove		= __devexit_p(ep93xx_wdt_remove),
+	.remove		= ep93xx_wdt_remove,
 };
 
 module_platform_driver(ep93xx_wdt_driver);
diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index dc563b6..a340e04 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -256,7 +256,7 @@ static void geodewdt_shutdown(struct platform_device *dev)
 
 static struct platform_driver geodewdt_driver = {
 	.probe		= geodewdt_probe,
-	.remove		= __devexit_p(geodewdt_remove),
+	.remove		= geodewdt_remove,
 	.shutdown	= geodewdt_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index ae60406..03687bc 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -863,7 +863,7 @@ static struct pci_driver hpwdt_driver = {
 	.name = "hpwdt",
 	.id_table = hpwdt_devices,
 	.probe = hpwdt_init_one,
-	.remove = __devexit_p(hpwdt_exit),
+	.remove = hpwdt_exit,
 };
 
 MODULE_AUTHOR("Tom Mingarelli");
diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 276877d..2574066 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -488,7 +488,7 @@ static struct pci_driver esb_driver = {
 	.name		= ESB_MODULE_NAME,
 	.id_table	= esb_pci_tbl,
 	.probe          = esb_probe,
-	.remove         = __devexit_p(esb_remove),
+	.remove         = esb_remove,
 	.shutdown       = esb_shutdown,
 };
 
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 545d387..b83f935 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -548,7 +548,7 @@ static void iTCO_wdt_shutdown(struct platform_device *dev)
 
 static struct platform_driver iTCO_wdt_driver = {
 	.probe          = iTCO_wdt_probe,
-	.remove         = __devexit_p(iTCO_wdt_remove),
+	.remove         = iTCO_wdt_remove,
 	.shutdown       = iTCO_wdt_shutdown,
 	.driver         = {
 		.owner  = THIS_MODULE,
diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index 184c0bf..4e992c8 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -337,7 +337,7 @@ static void ibwdt_shutdown(struct platform_device *dev)
 
 static struct platform_driver ibwdt_driver = {
 	.probe		= ibwdt_probe,
-	.remove		= __devexit_p(ibwdt_remove),
+	.remove		= ibwdt_remove,
 	.shutdown	= ibwdt_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 8f541b9..93b2cda 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -311,7 +311,7 @@ static int __devexit ie6xx_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver ie6xx_wdt_driver = {
 	.probe		= ie6xx_wdt_probe,
-	.remove		= __devexit_p(ie6xx_wdt_remove),
+	.remove		= ie6xx_wdt_remove,
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index 978615e..331a613 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -210,7 +210,7 @@ static int __devexit jz4740_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver jz4740_wdt_driver = {
 	.probe = jz4740_wdt_probe,
-	.remove = __devexit_p(jz4740_wdt_remove),
+	.remove = jz4740_wdt_remove,
 	.driver = {
 		.name = "jz4740-wdt",
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index c1a4d3b..6ac9ff2 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -290,7 +290,7 @@ static int ks8695wdt_resume(struct platform_device *pdev)
 
 static struct platform_driver ks8695wdt_driver = {
 	.probe		= ks8695wdt_probe,
-	.remove		= __devexit_p(ks8695wdt_remove),
+	.remove		= ks8695wdt_remove,
 	.shutdown	= ks8695wdt_shutdown,
 	.suspend	= ks8695wdt_suspend,
 	.resume		= ks8695wdt_resume,
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 2e74c3a..ce4df08 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -236,7 +236,7 @@ MODULE_DEVICE_TABLE(of, ltq_wdt_match);
 
 static struct platform_driver ltq_wdt_driver = {
 	.probe = ltq_wdt_probe,
-	.remove = __devexit_p(ltq_wdt_remove),
+	.remove = ltq_wdt_remove,
 	.driver = {
 		.name = "wdt",
 		.owner = THIS_MODULE,
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 8f4a74e..7e95221 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -228,7 +228,7 @@ MODULE_DEVICE_TABLE(platform, max63xx_id_table);
 
 static struct platform_driver max63xx_wdt_driver = {
 	.probe		= max63xx_wdt_probe,
-	.remove		= __devexit_p(max63xx_wdt_remove),
+	.remove		= max63xx_wdt_remove,
 	.id_table	= max63xx_id_table,
 	.driver		= {
 		.name	= "max63xx_wdt",
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index e6a038a..e44d6d9 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -281,7 +281,7 @@ MODULE_DEVICE_TABLE(of, mpc8xxx_wdt_match);
 
 static struct platform_driver mpc8xxx_wdt_driver = {
 	.probe		= mpc8xxx_wdt_probe,
-	.remove		= __devexit_p(mpc8xxx_wdt_remove),
+	.remove		= mpc8xxx_wdt_remove,
 	.driver = {
 		.name = "mpc8xxx_wdt",
 		.owner = THIS_MODULE,
diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 7c741dc..cf66cee 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -415,7 +415,7 @@ MODULE_ALIAS("platform:mpcore_wdt");
 
 static struct platform_driver mpcore_wdt_driver = {
 	.probe		= mpcore_wdt_probe,
-	.remove		= __devexit_p(mpcore_wdt_remove),
+	.remove		= mpcore_wdt_remove,
 	.suspend	= mpcore_wdt_suspend,
 	.resume		= mpcore_wdt_resume,
 	.shutdown	= mpcore_wdt_shutdown,
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index c29e31d..5474a06 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -248,7 +248,7 @@ static int __devexit mtx1_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver mtx1_wdt_driver = {
 	.probe = mtx1_wdt_probe,
-	.remove = __devexit_p(mtx1_wdt_remove),
+	.remove = mtx1_wdt_remove,
 	.driver.name = "mtx1-wdt",
 	.driver.owner = THIS_MODULE,
 };
diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
index c53d025..7d37da5 100644
--- a/drivers/watchdog/mv64x60_wdt.c
+++ b/drivers/watchdog/mv64x60_wdt.c
@@ -300,7 +300,7 @@ static int __devexit mv64x60_wdt_remove(struct platform_device *dev)
 
 static struct platform_driver mv64x60_wdt_driver = {
 	.probe = mv64x60_wdt_probe,
-	.remove = __devexit_p(mv64x60_wdt_remove),
+	.remove = mv64x60_wdt_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = MV64x60_WDT_NAME,
diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index ea4c744..a77f690 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -328,7 +328,7 @@ static int __devexit nuc900wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver nuc900wdt_driver = {
 	.probe		= nuc900wdt_probe,
-	.remove		= __devexit_p(nuc900wdt_remove),
+	.remove		= nuc900wdt_remove,
 	.driver		= {
 		.name	= "nuc900-wdt",
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index 6bbb9ef..e0d4496 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -468,7 +468,7 @@ static void nv_tco_shutdown(struct platform_device *dev)
 
 static struct platform_driver nv_tco_driver = {
 	.probe		= nv_tco_init,
-	.remove		= __devexit_p(nv_tco_remove),
+	.remove		= nv_tco_remove,
 	.shutdown	= nv_tco_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 294fb4e..df8c5f3 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -401,7 +401,7 @@ MODULE_DEVICE_TABLE(of, xwdt_of_match);
 
 static struct platform_driver xwdt_driver = {
 	.probe       = xwdt_probe,
-	.remove      = __devexit_p(xwdt_remove),
+	.remove      = xwdt_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name  = WATCHDOG_NAME,
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index f5db18db..1596a5d 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -426,7 +426,7 @@ MODULE_DEVICE_TABLE(of, omap_wdt_of_match);
 
 static struct platform_driver omap_wdt_driver = {
 	.probe		= omap_wdt_probe,
-	.remove		= __devexit_p(omap_wdt_remove),
+	.remove		= omap_wdt_remove,
 	.shutdown	= omap_wdt_shutdown,
 	.suspend	= omap_wdt_suspend,
 	.resume		= omap_wdt_resume,
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index c20f96b..33a0872 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -201,7 +201,7 @@ MODULE_DEVICE_TABLE(of, orion_wdt_of_match_table);
 
 static struct platform_driver orion_wdt_driver = {
 	.probe		= orion_wdt_probe,
-	.remove		= __devexit_p(orion_wdt_remove),
+	.remove		= orion_wdt_remove,
 	.shutdown	= orion_wdt_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index 75694cf..df454c9 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -984,7 +984,7 @@ static void pcwd_isa_shutdown(struct device *dev, unsigned int id)
 static struct isa_driver pcwd_isa_driver = {
 	.match		= pcwd_isa_match,
 	.probe		= pcwd_isa_probe,
-	.remove		= __devexit_p(pcwd_isa_remove),
+	.remove		= pcwd_isa_remove,
 	.shutdown	= pcwd_isa_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index ee6900d..1407a6f 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -812,7 +812,7 @@ static struct pci_driver pcipcwd_driver = {
 	.name		= WATCHDOG_NAME,
 	.id_table	= pcipcwd_pci_tbl,
 	.probe		= pcipcwd_card_init,
-	.remove		= __devexit_p(pcipcwd_card_exit),
+	.remove		= pcipcwd_card_exit,
 };
 
 module_pci_driver(pcipcwd_driver);
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 87722e1..5c07fa4 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -217,7 +217,7 @@ static struct platform_driver platform_wdt_driver = {
 		.of_match_table = of_match_ptr(pnx4008_wdt_match),
 	},
 	.probe = pnx4008_wdt_probe,
-	.remove = __devexit_p(pnx4008_wdt_remove),
+	.remove = pnx4008_wdt_remove,
 };
 
 module_platform_driver(platform_wdt_driver);
diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
index 547353a..cf983d3 100644
--- a/drivers/watchdog/rc32434_wdt.c
+++ b/drivers/watchdog/rc32434_wdt.c
@@ -320,7 +320,7 @@ static void rc32434_wdt_shutdown(struct platform_device *pdev)
 
 static struct platform_driver rc32434_wdt_driver = {
 	.probe		= rc32434_wdt_probe,
-	.remove		= __devexit_p(rc32434_wdt_remove),
+	.remove		= rc32434_wdt_remove,
 	.shutdown	= rc32434_wdt_shutdown,
 	.driver		= {
 			.name = "rc32434_wdt",
diff --git a/drivers/watchdog/rdc321x_wdt.c b/drivers/watchdog/rdc321x_wdt.c
index 042ccc5..2768214 100644
--- a/drivers/watchdog/rdc321x_wdt.c
+++ b/drivers/watchdog/rdc321x_wdt.c
@@ -286,7 +286,7 @@ static int __devexit rdc321x_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver rdc321x_wdt_driver = {
 	.probe = rdc321x_wdt_probe,
-	.remove = __devexit_p(rdc321x_wdt_remove),
+	.remove = rdc321x_wdt_remove,
 	.driver = {
 		.owner = THIS_MODULE,
 		.name = "rdc321x-wdt",
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index 49e1b1c..65851f4 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -246,7 +246,7 @@ static struct platform_driver riowd_driver = {
 		.of_match_table = riowd_match,
 	},
 	.probe		= riowd_probe,
-	.remove		= __devexit_p(riowd_remove),
+	.remove		= riowd_remove,
 };
 
 module_platform_driver(riowd_driver);
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index 9245b4d..c317420 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -508,7 +508,7 @@ MODULE_DEVICE_TABLE(of, s3c2410_wdt_match);
 
 static struct platform_driver s3c2410wdt_driver = {
 	.probe		= s3c2410wdt_probe,
-	.remove		= __devexit_p(s3c2410wdt_remove),
+	.remove		= s3c2410wdt_remove,
 	.shutdown	= s3c2410wdt_shutdown,
 	.suspend	= s3c2410wdt_suspend,
 	.resume		= s3c2410wdt_resume,
diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index 9681ada..766b132 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -451,7 +451,7 @@ static void sch311x_wdt_shutdown(struct platform_device *dev)
 
 static struct platform_driver sch311x_wdt_driver = {
 	.probe		= sch311x_wdt_probe,
-	.remove		= __devexit_p(sch311x_wdt_remove),
+	.remove		= sch311x_wdt_remove,
 	.shutdown	= sch311x_wdt_shutdown,
 	.driver		= {
 		.owner = THIS_MODULE,
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index e5b59be..ce1be6e 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -324,7 +324,7 @@ static struct platform_driver sh_wdt_driver = {
 	},
 
 	.probe		= sh_wdt_probe,
-	.remove		= __devexit_p(sh_wdt_remove),
+	.remove		= sh_wdt_remove,
 	.shutdown	= sh_wdt_shutdown,
 };
 
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index ae5e82c..066901b 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -439,7 +439,7 @@ static void sp5100_tco_shutdown(struct platform_device *dev)
 
 static struct platform_driver sp5100_tco_driver = {
 	.probe		= sp5100_tco_init,
-	.remove		= __devexit_p(sp5100_tco_remove),
+	.remove		= sp5100_tco_remove,
 	.shutdown	= sp5100_tco_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index dfddfbf..cd5812f 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -324,7 +324,7 @@ static struct amba_driver sp805_wdt_driver = {
 	},
 	.id_table	= sp805_wdt_ids,
 	.probe		= sp805_wdt_probe,
-	.remove = __devexit_p(sp805_wdt_remove),
+	.remove = sp805_wdt_remove,
 };
 
 module_amba_driver(sp805_wdt_driver);
diff --git a/drivers/watchdog/stmp3xxx_wdt.c b/drivers/watchdog/stmp3xxx_wdt.c
index 21d96b9..4226250 100644
--- a/drivers/watchdog/stmp3xxx_wdt.c
+++ b/drivers/watchdog/stmp3xxx_wdt.c
@@ -269,7 +269,7 @@ static struct platform_driver platform_wdt_driver = {
 		.name = "stmp3xxx_wdt",
 	},
 	.probe = stmp3xxx_wdt_probe,
-	.remove = __devexit_p(stmp3xxx_wdt_remove),
+	.remove = stmp3xxx_wdt_remove,
 	.suspend = stmp3xxx_wdt_suspend,
 	.resume = stmp3xxx_wdt_resume,
 };
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 8df050d..2acc1fe 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -499,7 +499,7 @@ static __devexit int ts72xx_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver ts72xx_wdt_driver = {
 	.probe		= ts72xx_wdt_probe,
-	.remove		= __devexit_p(ts72xx_wdt_remove),
+	.remove		= ts72xx_wdt_remove,
 	.driver		= {
 		.name	= "ts72xx-wdt",
 		.owner	= THIS_MODULE,
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 249f113..cf59a38 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -247,7 +247,7 @@ static int twl4030_wdt_resume(struct platform_device *pdev)
 
 static struct platform_driver twl4030_wdt_driver = {
 	.probe		= twl4030_wdt_probe,
-	.remove		= __devexit_p(twl4030_wdt_remove),
+	.remove		= twl4030_wdt_remove,
 	.suspend	= twl4030_wdt_suspend,
 	.resume		= twl4030_wdt_resume,
 	.driver		= {
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index aa50da3..a9af1dd 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -250,7 +250,7 @@ static struct pci_driver wdt_driver = {
 	.name		= "via_wdt",
 	.id_table	= wdt_pci_table,
 	.probe		= wdt_probe,
-	.remove		= __devexit_p(wdt_remove),
+	.remove		= wdt_remove,
 };
 
 module_pci_driver(wdt_driver);
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index e32654e..05c14e4 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -736,7 +736,7 @@ static struct pci_driver wdtpci_driver = {
 	.name		= "wdt_pci",
 	.id_table	= wdtpci_pci_tbl,
 	.probe		= wdtpci_init_one,
-	.remove		= __devexit_p(wdtpci_remove_one),
+	.remove		= wdtpci_remove_one,
 };
 
 module_pci_driver(wdtpci_driver);
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 87d66d2..f9c54fe 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -306,7 +306,7 @@ static int __devexit wm831x_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver wm831x_wdt_driver = {
 	.probe = wm831x_wdt_probe,
-	.remove = __devexit_p(wm831x_wdt_remove),
+	.remove = wm831x_wdt_remove,
 	.driver = {
 		.name = "wm831x-watchdog",
 	},
diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index 3c76693..770b6da 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -166,7 +166,7 @@ static int __devexit wm8350_wdt_remove(struct platform_device *pdev)
 
 static struct platform_driver wm8350_wdt_driver = {
 	.probe = wm8350_wdt_probe,
-	.remove = __devexit_p(wm8350_wdt_remove),
+	.remove = wm8350_wdt_remove,
 	.driver = {
 		.name = "wm8350-wdt",
 	},
diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index e4a25b5..99b956f 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -315,7 +315,7 @@ static int xen_wdt_resume(struct platform_device *dev)
 
 static struct platform_driver xen_wdt_driver = {
 	.probe          = xen_wdt_probe,
-	.remove         = __devexit_p(xen_wdt_remove),
+	.remove         = xen_wdt_remove,
 	.shutdown       = xen_wdt_shutdown,
 	.suspend        = xen_wdt_suspend,
 	.resume         = xen_wdt_resume,
-- 
1.8.0

