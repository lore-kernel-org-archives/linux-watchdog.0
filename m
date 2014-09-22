Return-path: <j.uzycki@elproma.com.pl>
From: Janusz Uzycki <j.uzycki@elproma.com.pl>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Janusz Uzycki <j.uzycki@elproma.com.pl>
Subject: [PATCH 6/6] stmp3xxx_rtc_wdt: use watchdog's PM helper
Date: Mon, 22 Sep 2014 22:55:50 +0200
Message-Id: <1411419350-1297-6-git-send-email-j.uzycki@elproma.com.pl>
In-Reply-To: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
References: <1411419350-1297-1-git-send-email-j.uzycki@elproma.com.pl>
List-ID: <linux-watchdog@vger.kernel.org>

It also fixes PM race for WATCHDOG_KEEP_ON enabled.

Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>
---
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index 7e753b9..0ba9edc 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -99,8 +99,7 @@ static int __maybe_unused stmp3xxx_wdt_suspend(struct device *dev)
 {
 	struct watchdog_device *wdd = &stmp3xxx_wdd;
 
-	if (watchdog_active(wdd))
-		return wdt_stop(wdd);
+	watchdog_suspend(wdd);
 
 	return 0;
 }
@@ -109,8 +108,7 @@ static int __maybe_unused stmp3xxx_wdt_resume(struct device *dev)
 {
 	struct watchdog_device *wdd = &stmp3xxx_wdd;
 
-	if (watchdog_active(wdd))
-		return wdt_start(wdd);
+	watchdog_resume(wdd);
 
 	return 0;
 }
-- 
1.7.11.3
