Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/5] watchdog: mena21: Do not use device pointer from struct watchdog_device
Date: Wed, 23 Dec 2015 21:11:32 -0800
Message-Id: <1450933893-7761-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
References: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The device pointer in struct watchdog_device has a different lifetime
than the driver code and should not be used in drivers. Use pr_err
instead of dev_err.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/mena21_wdt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 098fa9c34d6d..f0dc794d0fda 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -7,6 +7,9 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation
  */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/types.h>
@@ -100,13 +103,14 @@ static int a21_wdt_set_timeout(struct watchdog_device *wdt,
 	struct a21_wdt_drv *drv = watchdog_get_drvdata(wdt);
 
 	if (timeout != 1 && timeout != 30) {
-		dev_err(wdt->dev, "Only 1 and 30 allowed as timeout\n");
+		pr_err("watchdog%d: Only 1 and 30 allowed as timeout\n",
+		       wdt->id);
 		return -EINVAL;
 	}
 
 	if (timeout == 30 && wdt->timeout == 1) {
-		dev_err(wdt->dev,
-			"Transition from fast to slow mode not allowed\n");
+		pr_err("watchdog%d: Transition from fast to slow mode not allowed\n",
+		       wdt->id);
 		return -EINVAL;
 	}
 
-- 
2.1.4
