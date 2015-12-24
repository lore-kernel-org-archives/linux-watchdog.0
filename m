Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/5] watchdog: gpio: Do not use device pointer from struct watchdog_device
Date: Wed, 23 Dec 2015 21:11:31 -0800
Message-Id: <1450933893-7761-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
References: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The device pointer in struct watchdog_device has a different lifetime
than the driver code and should not be used in drivers. Use pr_crit
instead of dev_crit.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/gpio_wdt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 035c2387b846..44df983a1232 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -9,6 +9,8 @@
  * (at your option) any later version.
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/module.h>
@@ -54,7 +56,8 @@ static void gpio_wdt_hwping(unsigned long data)
 
 	if (priv->armed && time_after(jiffies, priv->last_jiffies +
 				      msecs_to_jiffies(wdd->timeout * 1000))) {
-		dev_crit(wdd->dev, "Timer expired. System will reboot soon!\n");
+		pr_crit("watchdog%d: Timer expired. System will reboot soon!\n",
+			wdd->id);
 		return;
 	}
 
-- 
2.1.4
