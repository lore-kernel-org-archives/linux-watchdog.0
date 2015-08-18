Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37125 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbbHREtz (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:49:55 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 26/37] watchdog: gpio: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:59 +0530
Message-Id: <2beb98994d7ee8706b520c6149fa03e5f3fa39e1.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/gpio_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 1687cc2d7122..336bddd84809 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -217,6 +217,7 @@ static int gpio_wdt_probe(struct platform_device *pdev)
 	priv->wdd.ops		= &gpio_wdt_ops;
 	priv->wdd.min_timeout	= SOFT_TIMEOUT_MIN;
 	priv->wdd.max_timeout	= SOFT_TIMEOUT_MAX;
+	priv->wdd.parent	= &pdev->dev;
 
 	if (watchdog_init_timeout(&priv->wdd, 0, &pdev->dev) < 0)
 		priv->wdd.timeout = SOFT_TIMEOUT_DEF;
-- 
2.4.3

