Return-Path: <jerry.hoemann@hpe.com>
Return-path: <jerry.hoemann@hpe.com>
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rwright@hpe.com,
	maurice.a.saldivar@hpe.com,
	Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 02/10] watchdog/hpwdt: remove include files no longer needed.
Date: Tue,  6 Feb 2018 15:58:47 -0700
Message-Id: <20180206225855.30582-3-jerry.hoemann@hpe.com>
In-Reply-To: <20180206225855.30582-1-jerry.hoemann@hpe.com>
References: <20180206225855.30582-1-jerry.hoemann@hpe.com>
List-ID: <linux-watchdog@vger.kernel.org>

remove header files used by NMI sourcing and DMI decoding.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 01ef52c13209..260740051084 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -28,16 +28,7 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/watchdog.h>
-#ifdef CONFIG_HPWDT_NMI_DECODING
-#include <linux/dmi.h>
-#include <linux/spinlock.h>
-#include <linux/nmi.h>
-#include <linux/kdebug.h>
-#include <linux/notifier.h>
-#include <asm/set_memory.h>
-#endif /* CONFIG_HPWDT_NMI_DECODING */
 #include <asm/nmi.h>
-#include <asm/frame.h>
 
 #define HPWDT_VERSION			"1.4.0"
 #define SECS_TO_TICKS(secs)		((secs) * 1000 / 128)
-- 
2.13.6
