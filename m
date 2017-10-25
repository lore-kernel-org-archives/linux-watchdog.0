Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 4/4] watchdog: i6300esb: bump version to 0.6
Date: Wed, 25 Oct 2017 16:39:14 +0100
Message-Id: <20171025153914.3467-4-rrendec@arista.com>
In-Reply-To: <20171022170947.GA6997@roeck-us.net>
References: <20171022170947.GA6997@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

The new version incorporates two major changes:
* Watchdog subsystem support - allows the driver to coexist with other
  watchdog drivers; simplifies the code base
* Multiple device support - supports multiple 6300ESB timer devices and
  and exposes them as separate watchdogs

Signed-off-by: Radu Rendec <rrendec@arista.com>
---
 drivers/watchdog/i6300esb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 3f7f66513dfa..fba81fa2f1c1 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -45,7 +45,7 @@
 #include <linux/io.h>
 
 /* Module and version information */
-#define ESB_VERSION "0.05"
+#define ESB_VERSION "0.06"
 #define ESB_MODULE_NAME "i6300ESB timer"
 
 /* PCI configuration registers */
-- 
2.13.6
