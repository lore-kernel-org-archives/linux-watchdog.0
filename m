Return-path: <weiyj.lk@gmail.com>
From: Wei Yongjun <weiyj.lk@gmail.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Wei Yongjun <weiyj.lk@gmail.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: gpio_wdt: Fix missing platform_set_drvdata() in gpio_wdt_probe()
Date: Tue, 26 Jul 2016 14:50:14 +0000
Message-Id: <1469544614-31842-1-git-send-email-weiyj.lk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Add missing platform_set_drvdata() in gpio_wdt_probe(), otherwise
calling platform_get_drvdata() in remove returns NULL.

This is detected by Coccinelle semantic patch.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/watchdog/gpio_wdt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index ba066e4..93457ca 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -151,6 +151,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	platform_set_drvdata(pdev, priv);
+
 	priv->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
 	if (!gpio_is_valid(priv->gpio))
 		return priv->gpio;
