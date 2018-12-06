Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 3/3] watchdog/hpwdt: Update driver version.
Date: Wed,  5 Dec 2018 17:42:23 -0700
Message-Id: <1544056943-79958-4-git-send-email-jerry.hoemann@hpe.com>
In-Reply-To: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

Bump version number to reflect recent minor changes.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index c8e8055..ef30c7e 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -26,7 +26,7 @@
 #include <linux/watchdog.h>
 #include <asm/nmi.h>
 
-#define HPWDT_VERSION			"2.0.1"
+#define HPWDT_VERSION			"2.0.2"
 #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
 #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
 #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
-- 
1.8.3.1
