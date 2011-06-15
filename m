Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39911 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab1FOUSd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 15 Jun 2011 16:18:33 -0400
Received: by bwz15 with SMTP id 15so771094bwz.19
        for <linux-watchdog@vger.kernel.org>; Wed, 15 Jun 2011 13:18:32 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 15 Jun 2011 13:18:32 -0700
Message-ID: <BANLkTimy_X3EmefqtLRNy_NswzekXVXj6A@mail.gmail.com>
Subject: [MPCore Watchdog]: Add suspend/resume support.
From: Peter Fordham <peter.fordham@gmail.com>
To: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Add support for suspend and resume to the MPCore watchdog driver.

---
 drivers/watchdog/mpcore_wdt.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/watchdog/mpcore_wdt.c b/drivers/watchdog/mpcore_wdt.c
index 2b4af22..5f63a74 100644
--- a/drivers/watchdog/mpcore_wdt.c
+++ b/drivers/watchdog/mpcore_wdt.c
@@ -407,12 +407,36 @@ static int __devexit mpcore_wdt_remove(struct
platform_device *dev)
 	return 0;
 }

+#ifdef CONFIG_PM
+static int mpcore_wdt_suspend(struct platform_device *dev, pm_message_t msg)
+{
+        struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+        mpcore_wdt_stop(wdt);		/* Turn the WDT off */
+        return 0;
+}
+
+static int mpcore_wdt_resume(struct platform_device *dev)
+{
+        struct mpcore_wdt *wdt = platform_get_drvdata(dev);
+        /* re-activate timer */
+        if (test_bit(0, &wdt->timer_alive)) {
+                mpcore_wdt_start(wdt);
+        }
+        return 0;
+}
+#else
+#define mpcore_wdt_suspend    NULL
+#define mpcore_wdt_resume     NULL
+#endif
+
 /* work with hotplug and coldplug */
 MODULE_ALIAS("platform:mpcore_wdt");

 static struct platform_driver mpcore_wdt_driver = {
 	.probe		= mpcore_wdt_probe,
 	.remove		= __devexit_p(mpcore_wdt_remove),
+        .suspend        = mpcore_wdt_suspend,
+        .resume         = mpcore_wdt_resume,
 	.shutdown	= mpcore_wdt_shutdown,
 	.driver		= {
 		.owner	= THIS_MODULE,
-- 
1.7.0.4
