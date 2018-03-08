Return-Path: <khoroshilov@ispras.ru>
Return-path: <khoroshilov@ispras.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Eric Long <eric.long@spreadtrum.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ldv-project@linuxtesting.org
Subject: [PATCH] watchdog: sprd_wdt: Fix error handling in sprd_wdt_enable()
Date: Fri,  9 Mar 2018 00:21:48 +0300
Message-Id: <1520544108-11145-1-git-send-email-khoroshilov@ispras.ru>
List-ID: <linux-watchdog@vger.kernel.org>

If clk_prepare_enable(wdt->rtc_enable) fails,
wdt->enable clock is left enabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/watchdog/sprd_wdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index a8b280ff33e0..b4d484a42b70 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -154,8 +154,10 @@ static int sprd_wdt_enable(struct sprd_wdt *wdt)
 	if (ret)
 		return ret;
 	ret = clk_prepare_enable(wdt->rtc_enable);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(wdt->enable);
 		return ret;
+	}
 
 	sprd_wdt_unlock(wdt->base);
 	val = readl_relaxed(wdt->base + SPRD_WDT_CTRL);
-- 
2.7.4
