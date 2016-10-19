Return-path: <javier@osg.samsung.com>
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org,
	Kevin Hilman <khilman@baylibre.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Carlo Caione <carlo@caione.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] watchdog: meson: Remove unneeded platform MODULE_ALIAS
Date: Wed, 19 Oct 2016 16:49:42 -0300
Message-Id: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
List-ID: <linux-watchdog@vger.kernel.org>

The Amlogic Meson is a DT-only platform, which means the devices are
registered via OF and not using the legacy platform devices support.

So there's no need to have a MODULE_ALIAS("platform:meson-gxbb-wdt")
since the reported uevent MODALIAS to user-space will be the OF one.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/watchdog/meson_gxbb_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 44d180a2c5e5..45d47664a00a 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -264,7 +264,6 @@ static struct platform_driver meson_gxbb_wdt_driver = {
 
 module_platform_driver(meson_gxbb_wdt_driver);
 
-MODULE_ALIAS("platform:meson-gxbb-wdt");
 MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
 MODULE_DESCRIPTION("Amlogic Meson GXBB Watchdog timer driver");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.7.4
