Return-path: <javier@osg.samsung.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 2/2] watchdog: max77620_wdt: fix module autoload
Date: Fri, 14 Oct 2016 12:23:51 -0300
Message-Id: <1476458631-29685-2-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1476458631-29685-1-git-send-email-javier@osg.samsung.com>
References: <1476458631-29685-1-git-send-email-javier@osg.samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

If the driver is built as a module, autoload won't work because the module
alias information is not filled. So user-space can't match the registered
device with the corresponding module.

Export the module alias information using the MODULE_DEVICE_TABLE() macro.

Before this patch:

$ $ modinfo drivers/watchdog/max77620_wdt.ko | grep alias
$

After this patch:

modinfo drivers/watchdog/max77620_wdt.ko | grep alias
alias:          platform:max77620-watchdog

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/watchdog/max77620_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index 48b84df2afda..68c41fa2be27 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -205,6 +205,7 @@ static struct platform_device_id max77620_wdt_devtype[] = {
 	{ .name = "max77620-watchdog", },
 	{ },
 };
+MODULE_DEVICE_TABLE(platform, max77620_wdt_devtype);
 
 static struct platform_driver max77620_wdt_driver = {
 	.driver	= {
-- 
2.7.4
