Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Zabel <p.zabel@pengutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 093/102] watchdog: asm9260: explicitly request exclusive reset control
Date: Wed, 19 Jul 2017 17:26:37 +0200
Message-Id: <20170719152646.25903-94-p.zabel@pengutronix.de>
In-Reply-To: <20170719152646.25903-1-p.zabel@pengutronix.de>
References: <20170719152646.25903-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Commit a53e35db70d1 ("reset: Ensure drivers are explicit when requesting
reset lines") started to transition the reset control request API calls
to explicitly state whether the driver needs exclusive or shared reset
control behavior. Convert all drivers requesting exclusive resets to the
explicit API call so the temporary transition helpers can be removed.

No functional changes.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/watchdog/asm9260_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 53da001f0838e..186fac4cccf5a 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -296,7 +296,7 @@ static int asm9260_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->rst = devm_reset_control_get(&pdev->dev, "wdt_rst");
+	priv->rst = devm_reset_control_get_exclusive(&pdev->dev, "wdt_rst");
 	if (IS_ERR(priv->rst))
 		return PTR_ERR(priv->rst);
 
-- 
2.11.0
