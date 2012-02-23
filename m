From: John Crispin <blogic@openwrt.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH V2 3/3] WDT: MIPS: lantiq: use module_platform_driver inside lantiq watchdog driver
Date: Thu, 23 Feb 2012 17:03:44 +0100
Message-Id: <1330013024-13622-3-git-send-email-blogic@openwrt.org>
In-Reply-To: <1330013024-13622-1-git-send-email-blogic@openwrt.org>
References: <1330013024-13622-1-git-send-email-blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
Return-Path: <linux-mips-bounce@linux-mips.org>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Reduce boilerplate code by converting driver to module_platform_driver.

Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/lantiq_wdt.c |   19 +++----------------
 1 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index fa4866b..70127b3 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -182,7 +182,7 @@ static struct miscdevice ltq_wdt_miscdev = {
 	.fops	= &ltq_wdt_fops,
 };
 
-static int __init
+static int __devinit
 ltq_wdt_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -227,6 +227,7 @@ ltq_wdt_remove(struct platform_device *pdev)
 
 
 static struct platform_driver ltq_wdt_driver = {
+	.probe = ltq_wdt_probe,
 	.remove = __devexit_p(ltq_wdt_remove),
 	.driver = {
 		.name = "ltq_wdt",
@@ -234,21 +235,7 @@ static struct platform_driver ltq_wdt_driver = {
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
-
+module_platform_driver(ltq_wdt_driver);
 module_param(nowayout, int, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
 
-- 
1.7.7.1
