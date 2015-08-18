Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57181 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbbHREsc (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 18 Aug 2015 00:48:32 -0400
From: Pratyush Anand <panand@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: dyoung@redhat.com, dzickus@redhat.com,
	Pratyush Anand <panand@redhat.com>,
	Wolfson Microelectronics <linux@wolfsonmicro.com>
Subject: [PATCH 02/37] watchdog: wm8350: Fix parent of watchdog_device
Date: Tue, 18 Aug 2015 10:17:35 +0530
Message-Id: <dffd6f14c9698177425e4d0277aeb35be2e615ba.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
In-Reply-To: <cover.1439524806.git.panand@redhat.com>
References: <cover.1439524806.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Fix parent of watchdog_device so that /sys/class/watchdog/watchdogn/device
is populated.

cc: Wolfson Microelectronics <linux@wolfsonmicro.com>
Signed-off-by: Pratyush Anand <panand@redhat.com>
---
 drivers/watchdog/wm8350_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index 34d272ada23d..4ab4b8347d45 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -151,6 +151,7 @@ static int wm8350_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_nowayout(&wm8350_wdt, nowayout);
 	watchdog_set_drvdata(&wm8350_wdt, wm8350);
+	wm8350_wdt.parent = &pdev->dev;
 
 	/* Default to 4s timeout */
 	wm8350_wdt_set_timeout(&wm8350_wdt, 4);
-- 
2.4.3

