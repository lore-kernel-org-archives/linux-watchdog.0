Return-path: <weiyj_lk@163.com>
From: weiyj_lk@163.com
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: pic32-dmt: Fix return value check in pic32_dmt_probe()
Date: Fri, 17 Jun 2016 17:12:05 +0000
Message-Id: <1466183525-24685-1-git-send-email-weiyj_lk@163.com>
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
 drivers/watchdog/pic32-dmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
index 962f58c..5e8890e 100644
--- a/drivers/watchdog/pic32-dmt.c
+++ b/drivers/watchdog/pic32-dmt.c
@@ -176,8 +176,8 @@ static int pic32_dmt_probe(struct platform_device *pdev)
 	struct watchdog_device *wdd = &pic32_dmt_wdd;
 
 	dmt = devm_kzalloc(&pdev->dev, sizeof(*dmt), GFP_KERNEL);
-	if (IS_ERR(dmt))
-		return PTR_ERR(dmt);
+	if (!dmt)
+		return -ENOMEM;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	dmt->regs = devm_ioremap_resource(&pdev->dev, mem);
