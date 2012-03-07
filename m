Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121]:43191 "EHLO
	eu1sys200aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753205Ab2CGK31 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 7 Mar 2012 05:29:27 -0500
From: Viresh Kumar <viresh.kumar@st.com>
To: <wim@iguana.be>
Cc: <linux-watchdog@vger.kernel.org>, <spear-devel@list.st.com>,
	<viresh.linux@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<srinidhi.kasagar@stericsson.com>, <linus.walleij@stericsson.com>,
	<alan@lxorguk.ukuu.org.uk>, Viresh Kumar <viresh.kumar@st.com>
Subject: [PATCH 10/15] watchdog/mpcore_wdt: Add support for dev_pm_ops interface
Date: Wed, 7 Mar 2012 15:57:51 +0530
Message-ID: <b50542be97df8b90d3e7c696a8d13be707f581f9.1331115752.git.viresh.kumar@st.com>
In-Reply-To: <cover.1331115751.git.viresh.kumar@st.com>
References: <cover.1331115751.git.viresh.kumar@st.com>
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
index e02c02b..a099418 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -25,6 +25,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/reboot.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -384,40 +385,39 @@ static int __devexit mpcore_wdt_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM
-static int mpcore_wdt_suspend(struct platform_device *pdev, pm_message_t msg)
+static int mpcore_wdt_suspend(struct device *dev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
+	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	mpcore_wdt_stop(wdt);		/* Turn the WDT off */
 	return 0;
 }
 
-static int mpcore_wdt_resume(struct platform_device *pdev)
+static int mpcore_wdt_resume(struct device *dev)
 {
-	struct mpcore_wdt *wdt = platform_get_drvdata(pdev);
+	struct mpcore_wdt *wdt = dev_get_drvdata(dev);
 
 	/* re-activate timer */
 	if (test_bit(0, &wdt->timer_alive))
 		mpcore_wdt_start(wdt);
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
+		.pm = &mpcore_wdt_dev_pm_ops,
 	},
 };
 
-- 
1.7.8.110.g4cb5d

