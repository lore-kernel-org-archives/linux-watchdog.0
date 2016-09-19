Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:48195 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752648AbcISTUC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 15:20:02 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 3/4] watchdog: sa11x0/pxa: get rid of get_clock_tick_rate
Date: Mon, 19 Sep 2016 21:12:14 +0200
Message-Id: <1474312335-20997-4-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The OS timer rate used for the watchdog can now be fetched from the
standard clock API. This will remove the last user of
get_clock_tick_rate() in both pxa and sa11x0 architectures.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/watchdog/sa1100_wdt.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index e1d39a1e9628..8965e3f536c3 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -22,6 +22,7 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/clk.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/fs.h>
@@ -155,12 +156,27 @@ static struct miscdevice sa1100dog_miscdev = {
 };
 
 static int margin __initdata = 60;		/* (secs) Default is 1 minute */
+static struct clk *clk;
 
 static int __init sa1100dog_init(void)
 {
 	int ret;
 
-	oscr_freq = get_clock_tick_rate();
+	clk = clk_get(NULL, "OSTIMER0");
+	if (IS_ERR(clk)) {
+		pr_err("SA1100/PXA2xx Watchdog Timer: clock not found: %d\n",
+		       (int) PTR_ERR(clk));
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		pr_err("SA1100/PXA2xx Watchdog Timer: clock failed to prepare+enable: %d\n",
+		       ret);
+		goto err;
+	}
+
+	oscr_freq = clk_get_rate(clk);
 
 	/*
 	 * Read the reset status, and save it for later.  If
@@ -176,11 +192,17 @@ static int __init sa1100dog_init(void)
 		pr_info("SA1100/PXA2xx Watchdog Timer: timer margin %d sec\n",
 			margin);
 	return ret;
+err:
+	clk_disable_unprepare(clk);
+	clk_put(clk);
+	return ret;
 }
 
 static void __exit sa1100dog_exit(void)
 {
 	misc_deregister(&sa1100dog_miscdev);
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 }
 
 module_init(sa1100dog_init);
-- 
2.1.4

