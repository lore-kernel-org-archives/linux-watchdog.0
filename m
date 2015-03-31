Return-path: <abrestic@google.com>
From: Andrew Bresticker <abrestic@chromium.org>
To: Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Naidu Tellapati <naidu.tellapati@imgtec.com>,
	Andrew Bresticker <abrestic@chromium.org>,
	Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 2/4] watchdog: imgpdc: Intialize timeout to default value
Date: Tue, 31 Mar 2015 11:49:09 -0700
Message-Id: <1427827751-19705-2-git-send-email-abrestic@chromium.org>
In-Reply-To: <1427827751-19705-1-git-send-email-abrestic@chromium.org>
References: <1427827751-19705-1-git-send-email-abrestic@chromium.org>
List-ID: <linux-watchdog@vger.kernel.org>

From: Naidu Tellapati <naidu.tellapati@imgtec.com>

Currently the watchdog timeout is initialized to 0.  Initialize it to
its default value instead.

Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/watchdog/imgpdc_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index c4151cd..f3f65ac 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -42,7 +42,7 @@
 #define PDC_WDT_MIN_TIMEOUT		1
 #define PDC_WDT_DEF_TIMEOUT		64
 
-static int heartbeat;
+static int heartbeat = PDC_WDT_DEF_TIMEOUT;
 module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeats in seconds. "
 	"(default = " __MODULE_STRING(PDC_WDT_DEF_TIMEOUT) ")");
-- 
2.2.0.rc0.207.ga3a616c
