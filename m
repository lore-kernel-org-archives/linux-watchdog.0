Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 4/5] watchdog: mena21: Do not use device pointer from struct watchdog_device
Date: Thu, 24 Dec 2015 14:22:03 -0800
Message-Id: <1450995724-17758-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
References: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The device pointer in struct watchdog_device has a different lifetime
than the driver code and should not be used in drivers. Use the pointer
to the parent device instead.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Print messages using parent device

 drivers/watchdog/mena21_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 098fa9c34d6d..af6a7c489f08 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -100,12 +100,12 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
 	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
 
 	if (timeout != 1 && timeout != 30) {
-		dev_err(wdt->dev, "Only 1 and 30 allowed as timeout\n");
+		dev_err(wdt->parent, "Only 1 and 30 allowed as timeout\n");
 		return -EINVAL;
 	}
 
 	if (timeout == 30 && wdt->timeout == 1) {
-		dev_err(wdt->dev,
+		dev_err(wdt->parent,
 			"Transition from fast to slow mode not allowed\n");
 		return -EINVAL;
 	}
-- 
2.1.4
