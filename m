Return-Path: <khoroshilov@ispras.ru>
Return-path: <khoroshilov@ispras.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ldv-project@linuxtesting.org
Subject: [PATCH] watchdog: asm9260_wdt: fix error handling in asm9260_wdt_probe()
Date: Sat, 10 Feb 2018 00:56:29 +0300
Message-Id: <1518213389-19246-1-git-send-email-khoroshilov@ispras.ru>
List-ID: <linux-watchdog@vger.kernel.org>

If devm_reset_control_get_exclusive() fails, asm9260_wdt_probe()
returns immediately. But clks has been already enabled at that point,
so it is required to disable them.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/watchdog/asm9260_wdt.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 7dd0da644a7f..de9e538a5fa8 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -297,8 +297,10 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 		return ret;
 
 	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, "wdt_rst");
-	if (IS_ERR(priv->rst))
-		return PTR_ERR(priv->rst);
+	if (IS_ERR(priv->rst)) {
+		ret = PTR_ERR(priv->rst);
+		goto clk_off;
+	}
 
 	wdd = &priv->wdd;
 	wdd->info = &asm9260_wdt_ident;
-- 
2.7.4
