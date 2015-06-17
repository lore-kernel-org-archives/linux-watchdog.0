Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:56397 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755592AbbFQW7S (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 17 Jun 2015 18:59:18 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [PATCH v2 3/3] watchdog: max63xx: add heartbeat to platform data
Date: Wed, 17 Jun 2015 18:59:00 -0400
Message-Id: <1434581940-15086-3-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1434581940-15086-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1434581940-15086-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Actually, there is no way but the module parameter to set the desired
heartbeat. This patch allows a platform code to set it in the device
platform data. This is convenient for platforms and built-in drivers.

To do so, initialize heartbeat to zero to allow the module parameter to
take precedence over the platform setting. If not set, it will still
default to DEFAULT_HEARTBEAT.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/max63xx_wdt.c            | 6 +++++-
 include/linux/platform_data/max63xx_wdt.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index cce2b12..e49ecd9 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -31,7 +31,7 @@
 #define DEFAULT_HEARTBEAT 60
 #define MAX_HEARTBEAT     60
 
-static unsigned int heartbeat = DEFAULT_HEARTBEAT;
+static unsigned int heartbeat;
 static bool nowayout  = WATCHDOG_NOWAYOUT;
 
 /*
@@ -260,6 +260,10 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 
 	wdt->pdata = dev_get_platdata(&pdev->dev);
 
+	/* The module parameter takes precedence over the platform data */
+	if (!heartbeat && wdt->pdata && wdt->pdata->heartbeat)
+		heartbeat = wdt->pdata->heartbeat;
+
 	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
 		heartbeat = DEFAULT_HEARTBEAT;
 
diff --git a/include/linux/platform_data/max63xx_wdt.h b/include/linux/platform_data/max63xx_wdt.h
index ae28024..8127b1a 100644
--- a/include/linux/platform_data/max63xx_wdt.h
+++ b/include/linux/platform_data/max63xx_wdt.h
@@ -14,12 +14,14 @@
 
 /**
  * struct max63xx_platform_data - MAX63xx connectivity info
+ * @heartbeat:	Watchdog heartbeat period in seconds.
  * @wdi:	Watchdog Input GPIO number.
  * @set0:	Watchdog SET0 GPIO number.
  * @set1:	Watchdog SET1 GPIO number.
  * @set2:	Watchdog SET2 GPIO number.
  */
 struct max63xx_platform_data {
+	unsigned int heartbeat;
 	unsigned int wdi;
 	unsigned int set0, set1, set2;
 };
-- 
2.4.3

