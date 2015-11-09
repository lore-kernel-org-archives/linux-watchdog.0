Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:38946 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751546AbbKIJzv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Nov 2015 04:55:51 -0500
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/2] watchdog: gpio-wdt: Rename notifier to reboot_notifier
Date: Mon,  9 Nov 2015 10:55:43 +0100
Message-Id: <1447062944-12296-1-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is a preparation before adding a panic notifier.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/watchdog/gpio_wdt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 90d59d3f..c7b8a06 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -36,7 +36,7 @@ struct gpio_wdt_priv {
 	unsigned int		hw_algo;
 	unsigned int		hw_margin;
 	unsigned long		last_jiffies;
-	struct notifier_block	notifier;
+	struct notifier_block	reboot_notifier;
 	struct timer_list	timer;
 	struct watchdog_device	wdd;
 };
@@ -130,7 +130,7 @@ static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
 			       void *unused)
 {
 	struct gpio_wdt_priv *priv = container_of(nb, struct gpio_wdt_priv,
-						  notifier);
+						  reboot_notifier);
 
 	mod_timer(&priv->timer, 0);
 
@@ -228,8 +228,8 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->notifier.notifier_call = gpio_wdt_notify_sys;
-	ret = register_reboot_notifier(&priv->notifier);
+	priv->reboot_notifier.notifier_call = gpio_wdt_notify_sys;
+	ret = register_reboot_notifier(&priv->reboot_notifier);
 	if (ret)
 		goto error_unregister;
 
@@ -248,7 +248,7 @@ static int gpio_wdt_remove(struct platform_device *pdev)
 	struct gpio_wdt_priv *priv = platform_get_drvdata(pdev);
 
 	del_timer_sync(&priv->timer);
-	unregister_reboot_notifier(&priv->notifier);
+	unregister_reboot_notifier(&priv->reboot_notifier);
 	watchdog_unregister_device(&priv->wdd);
 
 	return 0;
-- 
2.4.10

