Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 33/62] watchdog: meson_wdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 16:44:42 -0800
Message-Id: <1484095516-12720-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop remove function
- Drop platform_set_drvdata()
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/meson_wdt.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 56ea1caf71c3..491b9bf13d84 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -201,38 +201,19 @@ static int meson_wdt_probe(struct platform_device *pdev)
 
 	meson_wdt_stop(&meson_wdt->wdt_dev);
 
-	err = watchdog_register_device(&meson_wdt->wdt_dev);
+	watchdog_stop_on_reboot(&meson_wdt->wdt_dev);
+	err = devm_watchdog_register_device(&pdev->dev, &meson_wdt->wdt_dev);
 	if (err)
 		return err;
 
-	platform_set_drvdata(pdev, meson_wdt);
-
 	dev_info(&pdev->dev, "Watchdog enabled (timeout=%d sec, nowayout=%d)",
 		 meson_wdt->wdt_dev.timeout, nowayout);
 
 	return 0;
 }
 
-static int meson_wdt_remove(struct platform_device *pdev)
-{
-	struct meson_wdt_dev *meson_wdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&meson_wdt->wdt_dev);
-
-	return 0;
-}
-
-static void meson_wdt_shutdown(struct platform_device *pdev)
-{
-	struct meson_wdt_dev *meson_wdt = platform_get_drvdata(pdev);
-
-	meson_wdt_stop(&meson_wdt->wdt_dev);
-}
-
 static struct platform_driver meson_wdt_driver = {
 	.probe		= meson_wdt_probe,
-	.remove		= meson_wdt_remove,
-	.shutdown	= meson_wdt_shutdown,
 	.driver		= {
 		.name		= DRV_NAME,
 		.of_match_table	= meson_wdt_dt_ids,
-- 
2.7.4
