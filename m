Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:40457 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964803AbbLOKhx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 15 Dec 2015 05:37:53 -0500
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: kernel@pengutronix.de, linux-watchdog@vger.kernel.org,
	Lars Poeschel <poeschel@lemonage.de>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/2] watchdog: omap: don't disable the timer when it should be enabled early
Date: Tue, 15 Dec 2015 11:37:41 +0100
Message-Id: <1450175861-16801-2-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1450175861-16801-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

With the early_enable module parameter the watchdog can be started
during driver probe time. If this is requested the bets are good that
the timer is already running, so to narrow the gap where the timer is
disabled only call the disable function when the timer shouldn't be
started.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/watchdog/omap_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index af8947429c91..ae673cd06aa1 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -270,7 +270,8 @@ static int omap_wdt_probe(struct platform_device *pdev)
 			wdev->wdog.bootstatus = WDIOF_CARDRESET;
 	}
 
-	omap_wdt_disable(wdev);
+	if (!early_enable)
+		omap_wdt_disable(wdev);
 
 	ret = watchdog_register_device(&wdev->wdog);
 	if (ret) {
-- 
2.6.2

