Return-path: <bhumirks@gmail.com>
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr,
	wim@iguana.be,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: keescook@chromium.org,
	Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] drivers: watchdog: booke_wdt: add __ro_after_init to booke_wdt_info
Date: Sat, 24 Dec 2016 21:37:32 +0530
Message-Id: <1482595652-29029-1-git-send-email-bhumirks@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

The object booke_wdt_info of watchdog_info structure is not
modified after getting initialized by booke_wdt_init. Apart from getting
referenced in init it is also stored in the info field of watchdog_device
structure which is of type const struct watchdog_info *info. So, it
becomes read only after init and therefore add __ro_after_init to it's
declaration.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/watchdog/booke_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 04da4b6..ae034bb 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -192,7 +192,7 @@ static int booke_wdt_set_timeout(struct watchdog_device *wdt_dev,
 	return 0;
 }
 
-static struct watchdog_info booke_wdt_info = {
+static struct watchdog_info booke_wdt_info __ro_after_init = {
 	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
 	.identity = "PowerPC Book-E Watchdog",
 };
-- 
1.9.1
