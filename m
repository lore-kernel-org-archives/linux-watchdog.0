Return-path: <linux@roeck-us.net>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/5] watchdog: tangox: Print info message using pointer to platform device
Date: Wed, 23 Dec 2015 21:11:30 -0800
Message-Id: <1450933893-7761-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
References: <1450933893-7761-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The device pointer in struct watchdog_device should not be used by drivers
and may be removed in the near future. Use the platform device pointer for
info messages instead.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/watchdog/tangox_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index b9ee6246e7c2..709c1ed6fd79 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -184,7 +184,7 @@ static int tangox_wdt_probe(struct platform_device *pdev)
 	if (err)
 		dev_warn(&pdev->dev, "failed to register restart handler\n");
 
-	dev_info(dev->wdt.dev, "SMP86xx/SMP87xx watchdog registered\n");
+	dev_info(&pdev->dev, "SMP86xx/SMP87xx watchdog registered\n");
 
 	return 0;
 }
-- 
2.1.4
