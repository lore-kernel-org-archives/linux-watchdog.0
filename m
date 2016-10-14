Return-path: <javier@osg.samsung.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 1/2] watchdog: bcm7038_wdt: fix module autoload
Date: Fri, 14 Oct 2016 12:23:50 -0300
Message-Id: <1476458631-29685-1-git-send-email-javier@osg.samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
$

After this patch:

$ modinfo drivers/watchdog/bcm7038_wdt.ko | grep alias
alias:          of:N*T*Cbrcm,bcm7038-wdtC*
alias:          of:N*T*Cbrcm,bcm7038-wdt

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/watchdog/bcm7038_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index e238df4d75a2..4814c00b32f6 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -216,6 +216,7 @@ static const struct of_device_id bcm7038_wdt_match[] = {
 	{ .compatible = "brcm,bcm7038-wdt" },
 	{},
 };
+MODULE_DEVICE_TABLE(of, bcm7038_wdt_match);
 
 static struct platform_driver bcm7038_wdt_driver = {
 	.probe		= bcm7038_wdt_probe,
-- 
2.7.4
