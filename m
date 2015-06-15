Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:58673 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbbFOUJF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jun 2015 16:09:05 -0400
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: [RESEND PATCH 3/3] watchdog: max63xx: add heartbeat to platform data
Date: Mon, 15 Jun 2015 15:58:41 -0400
Message-Id: <1434398321-16035-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1434398321-16035-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Actually, there is no way but the module parameter to set the desired
heartbeat. This patch allows a platform code to set it in the device
platform data. This is convenient for platforms and built-in drivers.

To do so, initialize heartbeat to zero to allow the module parameter to
takes precedence over the platform setting. If not set, it will still
default to DEFAULT_HEARTBEAT.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/max63xx_wdt.c            | 8 ++++++--
 include/linux/platform_data/max63xx_wdt.h | 2 ++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index 9ab9fd1..dc522ed 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -30,10 +30,10 @@
 
 #define MAX63XX_DISABLED	3
 
-static unsigned int heartbeat = DEFAULT_HEARTBEAT;
+static unsigned int heartbeat;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat period in seconds from 1 to "
-		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
+		 __MODULE_STRING(MAX_HEARTBEAT) ", default will be "
 		 __MODULE_STRING(DEFAULT_HEARTBEAT));
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -239,6 +239,10 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
 
 	data->pdata = dev_get_platdata(&pdev->dev);
 
+	/* The module parameter takes precedence over the platform setting */
+	if (!heartbeat && data->pdata && data->pdata->heartbeat)
+		heartbeat = data->pdata->heartbeat;
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
2.4.2

