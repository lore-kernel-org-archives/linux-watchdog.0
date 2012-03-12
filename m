Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:47480 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751803Ab2CLEXx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 12 Mar 2012 00:23:53 -0400
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, <w.sang@pengutronix.de>,
	<sshtylyov@mvista.com>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH V2 12/22] watchdog/mpcore_wdt: Add support for dev_pm_ops interface
Date: Mon, 12 Mar 2012 09:52:07 +0530
Message-ID: <70350419aeda6aa96081b6d81407efeb17b2d87c.1331524811.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331524811.git.viresh.kumar@st.com>
References: <cover.1331524811.git.viresh.kumar@st.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds dev_pm_ops support for standby/slepp/hibernate.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 drivers/watchdog/mpcore_wdt.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 6902580..3f47b7e 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -256,40 +257,39 @@ static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int mpcore_wdt_suspend(struct platform_device *pdev, pm_message_t msg)
+static int mpcore_wdt_suspend(struct device *dev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
+	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 	mpcore_wdt_stop(&wdt->wdd);	/* Turn the WDT off */
 
 	return 0;
 }
 
-static int mpcore_wdt_resume(struct platform_device *pdev)
+static int mpcore_wdt_resume(struct device *dev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
+	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	if (is_wdd_active(&wdt->wdd))
 		mpcore_wdt_start(&wdt->wdd);
 
 	return 0;
 }
-#else
-#define mpcore_wdt_suspend	NULL
-#define mpcore_wdt_resume	NULL
 #endif
 
+static SIMPLE_DEV_PM_OPS(mpcore_wdt_dev_pm_ops, mpcore_wdt_suspend,
+		mpcore_wdt_resume);
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:mpcore_wdt");
 
 static struct platform_driver mpcore_wdt_driver = {
 	.probe		= mpcore_wdt_probe,
 	.remove		= __devexit_p(mpcore_wdt_remove),
-	.suspend	= mpcore_wdt_suspend,
-	.resume		= mpcore_wdt_resume,
 	.shutdown	= mpcore_wdt_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
 		.name	= "mpcore_wdt",
+		.pm	= &mpcore_wdt_dev_pm_ops,
 	},
 };
 
-- 
1.7.8.110.g4cb5d

