Return-Path: <khoroshilov@ispras.ru>
Return-path: <khoroshilov@ispras.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ldv-project@linuxtesting.org
Subject: [PATCH v2] watchdog: asm9260_wdt: fix error handling in asm9260_wdt_probe()
Date: Sat, 10 Feb 2018 13:17:27 +0300
Message-Id: <1518257847-28796-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <20180209223209.GA19627@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

If devm_reset_control_get_exclusive() fails, asm9260_wdt_probe()
returns immediately. But clks has been already enabled at that point,
so it is required to disable them or to move the code around.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
v2: Move the code around instead of disabling clks as Guenter Roeck suggested.

 drivers/watchdog/asm9260_wdt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 7dd0da644a7f..2cf56b459d84 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -292,14 +292,14 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iobase))
 		return PTR_ERR(priv->iobase);
 
-	ret = asm9260_wdt_get_dt_clks(priv);
-	if (ret)
-		return ret;
-
 	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, "wdt_rst");
 	if (IS_ERR(priv->rst))
 		return PTR_ERR(priv->rst);
 
+	ret = asm9260_wdt_get_dt_clks(priv);
+	if (ret)
+		return ret;
+
 	wdd = &priv->wdd;
 	wdd->info = &asm9260_wdt_ident;
 	wdd->ops = &asm9260_wdt_ops;
-- 
2.7.4
