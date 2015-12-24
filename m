Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 5/5] watchdog: qcom-wdt: Do not set 'dev' in struct watchdog_device
Date: Thu, 24 Dec 2015 14:22:04 -0800
Message-Id: <1450995724-17758-6-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
References: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The 'dev' pointer in struct watchdog_device is set by the watchdog core
when registering the watchdog device and not by the driver. It points to
the watchdog device, not its parent.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No change

 drivers/watchdog/qcom-wdt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index aa7105d32c02..424f9a952fee 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -164,7 +164,6 @@ static int qcom_wdt_probe(struct platform_device *pdev)
 		goto err_clk_unprepare;
 	}
 
-	wdt->wdd.dev = &pdev->dev;
 	wdt->wdd.info = &qcom_wdt_info;
 	wdt->wdd.ops = &qcom_wdt_ops;
 	wdt->wdd.min_timeout = 1;
-- 
2.1.4
