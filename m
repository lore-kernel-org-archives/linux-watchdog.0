Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 03/62] watchdog: at91sam9_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 15:34:20 -0800
Message-Id: <1484091325-9199-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_add_action_or_reset() for calls to clk_disable_unprepare
- Replace 'goto l; ... l: return e;' with 'return e;'
- Drop assignments to otherwise unused variables
- Drop remove function
- Replace request_irq, request_threaded_irq, and request_any_context_irq
  with their device managed equivalent
- Drop platform_set_drvdata()
- Call del_timer() using devm_add_action()
- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/at91sam9_wdt.c | 48 ++++++++++++++---------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 7e6acaf3ece4..7c3c3554348d 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -209,10 +209,9 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 			 "min heartbeat and max heartbeat might be too close for the system to handle it correctly\n");
 
 	if ((tmp & AT91_WDT_WDFIEN) && wdt->irq) {
-		err = request_irq(wdt->irq, wdt_interrupt,
-				  IRQF_SHARED | IRQF_IRQPOLL |
-				  IRQF_NO_SUSPEND,
-				  pdev->name, wdt);
+		err = devm_request_irq(&pdev->dev, wdt->irq, wdt_interrupt,
+				IRQF_SHARED | IRQF_IRQPOLL | IRQF_NO_SUSPEND,
+				pdev->name, wdt);
 		if (err)
 			return err;
 	}
@@ -223,6 +222,10 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 			 tmp & wdt->mr_mask, wdt->mr & wdt->mr_mask);
 
 	setup_timer(&wdt->timer, at91_ping, (unsigned long)wdt);
+	err = devm_add_action(&pdev->dev, (void(*)(void *))del_timer,
+			       &wdt->timer);
+	if (err)
+		return err;
 
 	/*
 	 * Use min_heartbeat the first time to avoid spurious watchdog reset:
@@ -237,17 +240,13 @@ static int at91_wdt_init(struct platform_device *pdev, struct at91wdt *wdt)
 	if (watchdog_init_timeout(&wdt->wdd, 0, dev))
 		watchdog_init_timeout(&wdt->wdd, heartbeat, dev);
 	watchdog_set_nowayout(&wdt->wdd, wdt->nowayout);
-	err = watchdog_register_device(&wdt->wdd);
+	err = devm_watchdog_register_device(&pdev->dev, &wdt->wdd);
 	if (err)
-		goto out_stop_timer;
+		return err;
 
 	wdt->next_heartbeat = jiffies + wdt->wdd.timeout * HZ;
 
 	return 0;
-
-out_stop_timer:
-	del_timer(&wdt->timer);
-	return err;
 }
 
 /* ......................................................................... */
@@ -363,40 +362,26 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Could not enable slow clock\n");
 		return err;
 	}
+	err = devm_add_action_or_reset(&pdev->dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       wdt->sclk);
+	if (err)
+		return err;
 
 	if (pdev->dev.of_node) {
 		err = of_at91wdt_init(pdev->dev.of_node, wdt);
 		if (err)
-			goto err_clk;
+			return err;
 	}
 
 	err = at91_wdt_init(pdev, wdt);
 	if (err)
-		goto err_clk;
-
-	platform_set_drvdata(pdev, wdt);
+		return err;
 
 	pr_info("enabled (heartbeat=%d sec, nowayout=%d)\n",
 		wdt->wdd.timeout, wdt->nowayout);
 
 	return 0;
-
-err_clk:
-	clk_disable_unprepare(wdt->sclk);
-
-	return err;
-}
-
-static int __exit at91wdt_remove(struct platform_device *pdev)
-{
-	struct at91wdt *wdt = platform_get_drvdata(pdev);
-	watchdog_unregister_device(&wdt->wdd);
-
-	pr_warn("I quit now, hardware will probably reboot!\n");
-	del_timer(&wdt->timer);
-	clk_disable_unprepare(wdt->sclk);
-
-	return 0;
 }
 
 #if defined(CONFIG_OF)
@@ -409,7 +394,6 @@ MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
 #endif
 
 static struct platform_driver at91wdt_driver = {
-	.remove		= __exit_p(at91wdt_remove),
 	.driver		= {
 		.name	= "at91_wdt",
 		.of_match_table = of_match_ptr(at91_wdt_dt_ids),
-- 
2.7.4
