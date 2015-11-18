Return-path: <damien.riegel@savoirfairelinux.com>
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	kernel@savoirfairelinux.com,
	Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH 4/7] watchdog: gpio_wdt: stop on SYS_DOWN instead of SYS_POWER_OFF
Date: Wed, 18 Nov 2015 16:02:19 -0500
Message-Id: <1447880542-19320-5-git-send-email-damien.riegel@savoirfairelinux.com>
In-Reply-To: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1447880542-19320-1-git-send-email-damien.riegel@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

gpio_wdt is one the very few drivers that do not stop the device on
SYS_HALT and SYS_DOWN, but on SYS_HALT and SYS_POWER_OFF.

As most of the drivers, it makes more sense to stop the watchdog on
SYS_DOWN instead of SYS_POWER_OFF.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
Reviewed-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/watchdog/gpio_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 90d59d3..1a3c6e8 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -136,7 +136,7 @@ static int gpio_wdt_notify_sys(struct notifier_block *nb, unsigned long code,
 
 	switch (code) {
 	case SYS_HALT:
-	case SYS_POWER_OFF:
+	case SYS_DOWN:
 		gpio_wdt_disable(priv);
 		break;
 	default:
-- 
2.5.0
