Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Patrice Chotard <patrice.chotard@st.com>,
	kernel@stlinux.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 53/62] watchdog: st_lpc_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 18:09:07 -0800
Message-Id: <1484100561-17638-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484100561-17638-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Use devm_watchdog_register_driver() to register watchdog device

Cc: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/st_lpc_wdt.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index e6100e447dd8..d561fbf1df85 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -215,6 +215,11 @@ static int st_wdog_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Unable to enable clock\n");
 		return ret;
 	}
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       clk);
+	if (ret)
+		return ret;
 
 	watchdog_set_drvdata(&st_wdog_dev, st_wdog);
 	watchdog_set_nowayout(&st_wdog_dev, WATCHDOG_NOWAYOUT);
@@ -223,14 +228,12 @@ static int st_wdog_probe(struct platform_device *pdev)
 	ret = watchdog_init_timeout(&st_wdog_dev, 0, &pdev->dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to initialise watchdog timeout\n");
-		clk_disable_unprepare(clk);
 		return ret;
 	}
 
-	ret = watchdog_register_device(&st_wdog_dev);
+	ret = devm_watchdog_register_device(&pdev->dev, &st_wdog_dev);
 	if (ret) {
 		dev_err(&pdev->dev, "Unable to register watchdog\n");
-		clk_disable_unprepare(clk);
 		return ret;
 	}
 
@@ -247,8 +250,6 @@ static int st_wdog_remove(struct platform_device *pdev)
 	struct st_wdog *st_wdog = watchdog_get_drvdata(&st_wdog_dev);
 
 	st_wdog_setup(st_wdog, false);
-	watchdog_unregister_device(&st_wdog_dev);
-	clk_disable_unprepare(st_wdog->clk);
 
 	return 0;
 }
-- 
2.7.4
