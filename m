Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 1/5] watchdog: bcm2835_wdt: Drop log message if watchdog is stopped
Date: Thu, 24 Dec 2015 14:22:00 -0800
Message-Id: <1450995724-17758-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
References: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Stopping a watchdog is a normal operation and does not warrant a log
message.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 drivers/watchdog/bcm2835_wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index 8a5ce5b5a0b6..2e6164c4abc0 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -79,7 +79,6 @@ static int bcm2835_wdt_stop(struct watchdog_device *wdog)
 	struct bcm2835_wdt *wdt = watchdog_get_drvdata(wdog);
 
 	writel_relaxed(PM_PASSWORD | PM_RSTC_RESET, wdt->base + PM_RSTC);
-	dev_info(wdog->dev, "Watchdog timer stopped");
 	return 0;
 }
 
-- 
2.1.4
