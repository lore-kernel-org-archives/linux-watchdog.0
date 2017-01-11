Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 54/62] watchdog: stmp3xxx_rtc_wdt: Convert to use device managed functions
Date: Tue, 10 Jan 2017 18:09:08 -0800
Message-Id: <1484100561-17638-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1484100561-17638-1-git-send-email-linux@roeck-us.net>
References: <1484091325-9199-1-git-send-email-linux@roeck-us.net>
 <1484100561-17638-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Use device managed functions to simplify error handling, reduce
source code size, improve readability, and reduce the likelyhood of bugs.

The conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts used
to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use devm_watchdog_register_driver() to register watchdog device

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index d8b11eb269ad..c67f48fba8e1 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -99,7 +99,7 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 	stmp3xxx_wdd.timeout = clamp_t(unsigned, heartbeat, 1, STMP3XXX_MAX_TIMEOUT);
 	stmp3xxx_wdd.parent = &pdev->dev;
 
-	ret = watchdog_register_device(&stmp3xxx_wdd);
+	ret = devm_watchdog_register_device(&pdev->dev, &stmp3xxx_wdd);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cannot register watchdog device\n");
 		return ret;
@@ -116,7 +116,6 @@ static int stmp3xxx_wdt_probe(struct platform_device *pdev)
 static int stmp3xxx_wdt_remove(struct platform_device *pdev)
 {
 	unregister_reboot_notifier(&wdt_notifier);
-	watchdog_unregister_device(&stmp3xxx_wdd);
 	return 0;
 }
 
-- 
2.7.4
