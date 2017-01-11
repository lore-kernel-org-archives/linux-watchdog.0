Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42574 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935059AbdAKArW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jan 2017 19:47:22 -0500
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 50/62] watchdog: sbsa_gwdt: Convert to use device managed functions and other improvements
Date: Tue, 10 Jan 2017 16:44:59 -0800
Message-Id: <1484095516-12720-20-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484095516-12720-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484095516-12720-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.
Other improvements as listed below.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Drop assignments to otherwise unused variables
- Drop remove function
- Replace &pdev->dev with dev if 'struct device *dev' is a declared
  variable
- Use devm_watchdog_register_driver() to register watchdog device
- Replace shutdown function with call to watchdog_stop_on_reboot()

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/sbsa_gwdt.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index e9966bc8c23e..2285d1403b44 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -312,7 +312,8 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	 */
 	sbsa_gwdt_set_timeout(wdd, wdd->timeout);
 
-	ret = watchdog_register_device(wdd);
+	watchdog_stop_on_reboot(wdd);
+	ret = devm_watchdog_register_device(dev, wdd);
 	if (ret)
 		return ret;
 
@@ -323,22 +324,6 @@ static int sbsa_gwdt_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void sbsa_gwdt_shutdown(struct platform_device *pdev)
-{
-	struct sbsa_gwdt *gwdt = platform_get_drvdata(pdev);
-
-	sbsa_gwdt_stop(&gwdt->wdd);
-}
-
-static int sbsa_gwdt_remove(struct platform_device *pdev)
-{
-	struct sbsa_gwdt *gwdt = platform_get_drvdata(pdev);
-
-	watchdog_unregister_device(&gwdt->wdd);
-
-	return 0;
-}
-
 /* Disable watchdog if it is active during suspend */
 static int __maybe_unused sbsa_gwdt_suspend(struct device *dev)
 {
@@ -384,8 +369,6 @@ static struct platform_driver sbsa_gwdt_driver = {
 		.of_match_table = sbsa_gwdt_of_match,
 	},
 	.probe = sbsa_gwdt_probe,
-	.remove = sbsa_gwdt_remove,
-	.shutdown = sbsa_gwdt_shutdown,
 	.id_table = sbsa_gwdt_pdev_match,
 };
 
-- 
2.7.4

