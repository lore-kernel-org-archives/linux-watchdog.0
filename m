Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 34/62] watchdog: moxart_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 16:44:43 -0800
Message-Id: <1484095516-12720-4-git-send-email-linux@roeck-us.net>
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

- Drop assignments to otherwise unused variables
- Replace 'of_clk_get(np, 0)' with 'devm_clk_get(dev, NULL)'
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/moxart_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 2c4a73d1e214..4e91c326e316 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -90,7 +90,6 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 {
 	struct moxart_wdt_dev *moxart_wdt;
 	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->of_node;
 	struct resource *res;
 	struct clk *clk;
 	int err;
@@ -108,7 +107,7 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(moxart_wdt->base))
 		return PTR_ERR(moxart_wdt->base);
 
-	clk = of_clk_get(node, 0);
+	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
 		pr_err("%s: of_clk_get failed\n", __func__);
 		return PTR_ERR(clk);
@@ -135,7 +134,7 @@ static int moxart_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&moxart_wdt->dev, moxart_wdt);
 
-	err = watchdog_register_device(&moxart_wdt->dev);
+	err = devm_watchdog_register_device(dev, &moxart_wdt->dev);
 	if (err)
 		return err;
 
-- 
2.7.4
