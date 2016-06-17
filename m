Return-path: <weiyj_lk@163.com>
From: weiyj_lk@163.com
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pic32-wdt: Fix return value check in pic32_wdt_drv_probe()
Date: Fri, 17 Jun 2016 17:11:35 +0000
Message-Id: <1466183495-23885-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_kzalloc() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check should
be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/watchdog/pic32-wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index 6047aa8..2b7a2b2 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -174,8 +174,8 @@ static int pic32_wdt_drv_probe(struct platform_device *pdev)
 	struct resource *mem;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
-	if (IS_ERR(wdt))
-		return PTR_ERR(wdt);
+	if (!wdt)
+		return -ENOMEM;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	wdt->regs = devm_ioremap_resource(&pdev->dev, mem);
