Return-path: <weiyj.lk@gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH -next] watchdog: wdat_wdt: fix return value check in wdat_wdt_probe()
Date: Wed, 28 Sep 2016 14:51:26 +0000
Message-Id: <1475074286-13834-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

From: Wei Yongjun <weiyongjun1@huawei.com>

In case of error, the function devm_ioremap_resource() returns ERR_PTR()
and never returns NULL. The NULL test in the return value check should
be replaced with IS_ERR().

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/watchdog/wdat_wdt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 6b64645..4594723 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -351,16 +351,17 @@ static int wdat_wdt_probe(struct platform_device *pdev)
 		res = &pdev->resource[i];
 		if (resource_type(res) == IORESOURCE_MEM) {
 			reg = devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(reg))
+				return PTR_ERR(reg);
 		} else if (resource_type(res) == IORESOURCE_IO) {
 			reg = devm_ioport_map(&pdev->dev, res->start, 1);
+			if (!reg)
+				return -ENOMEM;
 		} else {
 			dev_err(&pdev->dev, "Unsupported resource\n");
 			return -EINVAL;
 		}
 
-		if (!reg)
-			return -ENOMEM;
-
 		regs[i] = reg;
 	}
