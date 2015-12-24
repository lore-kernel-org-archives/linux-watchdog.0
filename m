Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/5] watchdog: gpio: Do not use device pointer from struct watchdog_device
Date: Thu, 24 Dec 2015 14:22:02 -0800
Message-Id: <1450995724-17758-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
References: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The device pointer in struct watchdog_device has a different lifetime
than the driver code and should not be used in drivers. Use the pointer
to the parent device instead.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Print messages using parent device

 drivers/watchdog/gpio_wdt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 035c2387b846..ba066e4a707b 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -54,7 +54,8 @@ static void gpio_wdt_hwping(unsigned long data)
 
 	if (priv->armed && time_after(jiffies, priv->last_jiffies +
 				      msecs_to_jiffies(wdd->timeout * 1000))) {
-		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
+		dev_crit(wdd->parent,
+			 "Timer expired. System will reboot soon!\n");
 		return;
 	}
 
-- 
2.1.4
