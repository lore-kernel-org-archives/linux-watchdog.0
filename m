Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 1/4] watchdog: at91sam9: get and use slow clock
Date: Tue, 11 Aug 2015 11:38:01 +0200
Message-Id: <1439285884-16051-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1439285884-16051-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439285884-16051-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

Commit dca1a4b5ff6e ("clk: at91: keep slow clk enabled to prevent system
hang") added a workaround for the slow clock as it is not properly handled
by its users.

Get and use the slow clock as it is necessary for the at91sam9 watchdog.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
 drivers/watchdog/at91sam9_wdt.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index e4698f7c5f93..7e6acaf3ece4 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -17,6 +17,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk.h>
 #include <linux/errno.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -90,6 +91,7 @@ struct at91wdt {
 	unsigned long heartbeat;	/* WDT heartbeat in jiffies */
 	bool nowayout;
 	unsigned int irq;
+	struct clk *sclk;
 };
 
 /* ......................................................................... */
@@ -352,15 +354,25 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 	if (IS_ERR(wdt->base))
 		return PTR_ERR(wdt->base);
 
+	wdt->sclk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(wdt->sclk))
+		return PTR_ERR(wdt->sclk);
+
+	err = clk_prepare_enable(wdt->sclk);
+	if (err) {
+		dev_err(&pdev->dev, "Could not enable slow clock\n");
+		return err;
+	}
+
 	if (pdev->dev.of_node) {
 		err = of_at91wdt_init(pdev->dev.of_node, wdt);
 		if (err)
-			return err;
+			goto err_clk;
 	}
 
 	err = at91_wdt_init(pdev, wdt);
 	if (err)
-		return err;
+		goto err_clk;
 
 	platform_set_drvdata(pdev, wdt);
 
@@ -368,6 +380,11 @@ static int __init at91wdt_probe(struct platform_device *pdev)
 		wdt->wdd.timeout, wdt->nowayout);
 
 	return 0;
+
+err_clk:
+	clk_disable_unprepare(wdt->sclk);
+
+	return err;
 }
 
 static int __exit at91wdt_remove(struct platform_device *pdev)
@@ -377,6 +394,7 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 
 	pr_warn("I quit now, hardware will probably reboot!\n");
 	del_timer(&wdt->timer);
+	clk_disable_unprepare(wdt->sclk);
 
 	return 0;
 }
-- 
2.1.4
