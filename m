Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from m50-134.163.com ([123.125.50.134]:49741 "EHLO m50-134.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbbL0NTf (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 08:19:35 -0500
From: Geliang Tang <geliangtang@163.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Geliang Tang <geliangtang@163.com>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/10] watchdog: cadence_wdt: use to_platform_device()
Date: Sun, 27 Dec 2015 21:15:47 +0800
Message-Id: <bfab2ac46e1ff47b86258cc38ff1d698edc6017b.1451221174.git.geliangtang@163.com>
In-Reply-To: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
In-Reply-To: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
References: <a554e6af3a3528c2206c94dab62b7800f96caa4b.1451221174.git.geliangtang@163.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/watchdog/cadence_wdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index abf64eb..4dda902 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -421,8 +421,7 @@ static void cdns_wdt_shutdown(struct platform_device *pdev)
  */
 static int __maybe_unused cdns_wdt_suspend(struct device *dev)
 {
-	struct platform_device *pdev = container_of(dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
 
 	cdns_wdt_stop(&wdt->cdns_wdt_device);
@@ -440,8 +439,7 @@ static int __maybe_unused cdns_wdt_suspend(struct device *dev)
 static int __maybe_unused cdns_wdt_resume(struct device *dev)
 {
 	int ret;
-	struct platform_device *pdev = container_of(dev,
-			struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cdns_wdt *wdt = platform_get_drvdata(pdev);
 
 	ret = clk_prepare_enable(wdt->clk);
-- 
2.5.0


