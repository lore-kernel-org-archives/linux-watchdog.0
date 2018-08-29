Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:44870 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727677AbeH2LiT (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Aug 2018 07:38:19 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v3 2/4] watchdog: renesas_wdt: avoid removing if NOWAYOUT
Date: Wed, 29 Aug 2018 09:42:39 +0200
Message-Id: <20180829074241.1943-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180829074241.1943-1-wsa+renesas@sang-engineering.com>
References: <20180829074241.1943-1-wsa+renesas@sang-engineering.com>
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
