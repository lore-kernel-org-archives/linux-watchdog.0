Return-Path: <t.jag587@gmail.com>
Return-path: <t.jag587@gmail.com>
From: Jagdish Tirumala <t.jag587@gmail.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	yamada.masahiro@socionext.com
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] WATCHDOG: DIAG288_WDT: Fixed error POINTER_LOCATION
Date: Wed, 12 Sep 2018 08:56:32 -0700
Message-Id: <20180912155632.8060-1-t.jag587@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Fixed ERROR:POINTER_LOCATION: "foo * bar" should be "foo *bar" in
file drivers/watchdog/diag288_wdt.c

Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>
---
 drivers/watchdog/diag288_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 806a04a676b7..046333d1beb2 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -199,7 +199,7 @@ static int wdt_ping(struct watchdog_device *dev)
 	return ret;
 }
 
-static int wdt_set_timeout(struct watchdog_device * dev, unsigned int new_to)
+static int wdt_set_timeout(struct watchdog_device *dev, unsigned int new_to)
 {
 	dev->timeout = new_to;
 	return wdt_ping(dev);
-- 
2.17.1
