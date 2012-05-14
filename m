From: John Crispin <blogic@openwrt.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-watchdog@vger.kernel.org
Subject: [RESEND PATCH V2 11/17] watchdog: MIPS: lantiq: implement OF support and minor fixes
Date: Mon, 14 May 2012 19:42:37 +0200
Message-Id: <1337017363-14424-11-git-send-email-blogic@openwrt.org>
In-Reply-To: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Add support for OF. We also apply the following small fixes
* reduce boiler plate by using devm_request_and_ioremap
* sane error path for the clock
* move LTQ_RST_CAUSE_WDTRST to a soc specific header file
* add a message to show that the driver loaded

Signed-off-by: John Crispin <blogic@openwrt.org>
Acked-by: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
This patch is part of a series moving the mips/lantiq target to OF and clkdev
support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Changes in V2
* use io clk instead of fpi to make sure the driver also works on falcon socs

 arch/mips/include/asm/mach-lantiq/lantiq.h         |    1 -
 .../mips/include/asm/mach-lantiq/xway/lantiq_soc.h |    2 +
 drivers/watchdog/lantiq_wdt.c                      |   56 +++++++++-----------
 3 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/arch/mips/include/asm/mach-lantiq/lantiq.h b/arch/mips/include/asm/mach-lantiq/lantiq.h
index 6775d24..64fbc3f 100644
--- a/arch/mips/include/asm/mach-lantiq/lantiq.h
+++ b/arch/mips/include/asm/mach-lantiq/lantiq.h
@@ -49,7 +49,6 @@ extern struct clk *clk_get_io(void);
 extern unsigned char ltq_boot_select(void);
 /* find out what caused the last cpu reset */
 extern int ltq_reset_cause(void);
-#define LTQ_RST_CAUSE_WDTRST	0x20
 
 #define IOPORT_RESOURCE_START	0x10000000
 #define IOPORT_RESOURCE_END	0xffffffff
diff --git a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
index b5a2acf..d0d40a4 100644
--- a/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
+++ b/arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
@@ -133,6 +133,8 @@ extern __iomem void *ltq_cgu_membase;
 #define LTQ_WDT_BASE_ADDR	0x1F8803F0
 #define LTQ_WDT_SIZE		0x10
 
+#define LTQ_RST_CAUSE_WDTRST	0x20
+
 /* STP - serial to parallel conversion unit */
 #define LTQ_STP_BASE_ADDR	0x1E100BB0
 #define LTQ_STP_SIZE		0x40
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index a9593a3..2e74c3a 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -13,14 +13,15 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 #include <linux/watchdog.h>
-#include <linux/platform_device.h>
+#include <linux/of_platform.h>
 #include <linux/uaccess.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <lantiq.h>
+#include <lantiq_soc.h>
 
-/* Section 3.4 of the datasheet
+/*
+ * Section 3.4 of the datasheet
  * The password sequence protects the WDT control register from unintended
  * write actions, which might cause malfunction of the WDT.
  *
@@ -70,7 +71,8 @@ ltq_wdt_disable(void)
 {
 	/* write the first password magic */
 	ltq_w32(LTQ_WDT_PW1, ltq_wdt_membase + LTQ_WDT_CR);
-	/* write the second password magic with no config
+	/*
+	 * write the second password magic with no config
 	 * this turns the watchdog off
 	 */
 	ltq_w32(LTQ_WDT_PW2, ltq_wdt_membase + LTQ_WDT_CR);
@@ -184,7 +186,7 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
-static int __init
+static int __devinit
 ltq_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -194,28 +196,27 @@ ltq_wdt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "cannot obtain I/O memory region");
 		return -ENOENT;
 	}
-	res = devm_request_mem_region(&pdev->dev, res->start,
-		resource_size(res), dev_name(&pdev->dev));
-	if (!res) {
-		dev_err(&pdev->dev, "cannot request I/O memory region");
-		return -EBUSY;
-	}
-	ltq_wdt_membase = devm_ioremap_nocache(&pdev->dev, res->start,
-		resource_size(res));
+
+	ltq_wdt_membase = devm_request_and_ioremap(&pdev->dev, res);
 	if (!ltq_wdt_membase) {
 		dev_err(&pdev->dev, "cannot remap I/O memory region\n");
 		return -ENOMEM;
 	}
 
 	/* we do not need to enable the clock as it is always running */
-	clk = clk_get(&pdev->dev, "io");
-	WARN_ON(!clk);
+	clk = clk_get_io();
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "Failed to get clock\n");
+		return -ENOENT;
+	}
 	ltq_io_region_clk_rate = clk_get_rate(clk);
 	clk_put(clk);
 
+	/* find out if the watchdog caused the last reboot */
 	if (ltq_reset_cause() == LTQ_RST_CAUSE_WDTRST)
 		ltq_wdt_bootstatus = WDIOF_CARDRESET;
 
+	dev_info(&pdev->dev, "Init done\n");
 	return misc_register(&ltq_wdt_miscdev);
 }
 
@@ -227,33 +228,26 @@ ltq_wdt_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id ltq_wdt_match[] = {
+	{ .compatible = "lantiq,wdt" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ltq_wdt_match);
 
 static struct platform_driver ltq_wdt_driver = {
+	.probe = ltq_wdt_probe,
 	.remove = __devexit_p(ltq_wdt_remove),
 	.driver = {
-		.name = "ltq_wdt",
+		.name = "wdt",
 		.owner = THIS_MODULE,
+		.of_match_table = ltq_wdt_match,
 	},
 };
 
-static int __init
-init_ltq_wdt(void)
-{
-	return platform_driver_probe(&ltq_wdt_driver, ltq_wdt_probe);
-}
-
-static void __exit
-exit_ltq_wdt(void)
-{
-	return platform_driver_unregister(&ltq_wdt_driver);
-}
-
-module_init(init_ltq_wdt);
-module_exit(exit_ltq_wdt);
+module_platform_driver(ltq_wdt_driver);
 
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
-
 MODULE_AUTHOR("John Crispin <blogic@openwrt.org>");
 MODULE_DESCRIPTION("Lantiq SoC Watchdog");
 MODULE_LICENSE("GPL");
-- 
1.7.9.1
