Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:41478 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbeH1XHg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 28 Aug 2018 19:07:36 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 2/4] watchdog: renesas_wdt: avoid removing if NOWAYOUT
Date: Tue, 28 Aug 2018 21:14:14 +0200
Message-Id: <20180828191416.7781-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
References: <20180828191416.7781-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Use the new macro to prevent removing the driver if NOWAYOUT.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index f45cb183fa75..92339c744cce 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -302,7 +302,7 @@ static struct platform_driver rwdt_driver = {
 	.probe = rwdt_probe,
 	.remove = rwdt_remove,
 };
-module_platform_driver(rwdt_driver);
+module_watchdog_platform_driver(rwdt_driver, nowayout);
 
 MODULE_DESCRIPTION("Renesas WDT Watchdog Driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0
