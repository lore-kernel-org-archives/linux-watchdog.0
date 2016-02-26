Return-path: <martyn.welch@collabora.co.uk>
From: Martyn Welch <martyn.welch@collabora.co.uk>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH] Rename "trigger" reset reason "hw watchdog"
Date: Fri, 26 Feb 2016 16:05:12 +0000
Message-Id: <1456502712-25965-1-git-send-email-martyn.welch@collabora.co.uk>
List-ID: <linux-watchdog@vger.kernel.org>

The Zodiac watchdog is implemented on a microcontoller. The reset reason
currently labelled "trigger" is not to detect when the watchdog has
triggered (as had been initially understood and suggested by the naming),
but to inform the reader that the watchdog, which in fact has it's own
hardware watchdog, has been reset because the hardware watchdog has
triggered. Renaming to "hw watchdog".

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
---
 drivers/watchdog/ziirave_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index 0c7cb73..cbe373de 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -36,7 +36,7 @@
 #define ZIIRAVE_STATE_OFF	0x1
 #define ZIIRAVE_STATE_ON	0x2
 
-static char *ziirave_reasons[] = {"power cycle", "triggered", NULL, NULL,
+static char *ziirave_reasons[] = {"power cycle", "hw watchdog", NULL, NULL,
 				  "host request", NULL, "illegal configuration",
 				  "illegal instruction", "illegal trap",
 				  "unknown"};
-- 
2.1.4
