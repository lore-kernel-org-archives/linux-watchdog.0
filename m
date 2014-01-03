Return-Path: <markus.mayer@linaro.org>
From: Markus Mayer <markus.mayer@linaro.org>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
	Christian Daudt <bcm@fixthebug.org>
CC: Linaro Patches <patches@linaro.org>, Linux Watchdog List
	<linux-watchdog@vger.kernel.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>, Markus Mayer <markus.mayer@linaro.org>
Subject: [PATCH] watchdog: bcm281xx: Fix Kconfig help section
Date: Fri, 3 Jan 2014 12:57:16 -0800
Message-ID: <1388782636-10042-1-git-send-email-markus.mayer@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: markus.mayer@linaro.org
List-ID: <linux-watchdog@vger.kernel.org>

Fix the debugfs path name mentioned in the Kconfig help section.

Signed-off-by: Markus Mayer <markus.mayer@linaro.org>
---

This patch fixes an oversight in my previous series from Dec 31.
http://www.spinics.net/lists/linux-watchdog/msg03538.html

 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 9b8b96d..af8f7c7 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1156,7 +1156,7 @@ config BCM_KONA_WDT_DEBUG
 	bool "DEBUGFS support for BCM Kona Watchdog"
 	depends on BCM_KONA_WDT
 	help
-	  If enabled, adds /sys/kernel/debug/bcm-kona-wdt/info which provides
+	  If enabled, adds /sys/kernel/debug/bcm_kona_wdt/info which provides
 	  access to the driver's internal data structures as well as watchdog
 	  timer hardware registres.
 
-- 
1.7.9.5
