Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 38/62] watchdog: nic7018_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:47 -0800
Message-Id: <1484095516-12720-8-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/nic7018_wdt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/watchdog/nic7018_wdt.c b/drivers/watchdog/nic7018_wdt.c
index dcd265685837..27b7c7737149 100644
--- a/drivers/watchdog/nic7018_wdt.c
+++ b/drivers/watchdog/nic7018_wdt.c
@@ -219,7 +219,7 @@ static int nic7018_probe(struct platform_device *pdev)
 	/* Unlock WDT register */
 	outb(UNLOCK, wdt->io_base + WDT_REG_LOCK);
 
-	ret = watchdog_register_device(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret) {
 		outb(LOCK, wdt->io_base + WDT_REG_LOCK);
 		dev_err(dev, "failed to register watchdog\n");
@@ -235,8 +235,6 @@ static int nic7018_remove(struct platform_device *pdev)
 {
 	struct nic7018_wdt *wdt = platform_get_drvdata(pdev);
 
-	watchdog_unregister_device(&wdt->wdd);
-
 	/* Lock WDT register */
 	outb(LOCK, wdt->io_base + WDT_REG_LOCK);
 
-- 
2.7.4
