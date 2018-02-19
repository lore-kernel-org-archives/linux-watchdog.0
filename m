Return-Path: <radu.rendec@gmail.com>
Return-path: <radu.rendec@gmail.com>
From: Radu Rendec <radu.rendec@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 1/1] watchdog: xen_wdt: fix potential build failure
Date: Mon, 19 Feb 2018 14:38:51 +0000
Message-Id: <20180219143851.13983-2-radu.rendec@gmail.com>
In-Reply-To: <20180219143851.13983-1-radu.rendec@gmail.com>
References: <20180219143851.13983-1-radu.rendec@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

xen_wdt uses watchdog core functions (from watchdog_core.c) and, when
compiled without CONFIG_WATCHDOG_CORE being set, it produces the
following build error:

ERROR: "devm_watchdog_register_device" [drivers/watchdog/xen_wdt.ko] undefined!
ERROR: "watchdog_init_timeout" [drivers/watchdog/xen_wdt.ko] undefined!

Fix this by selecting CONFIG_WATCHDOG_CORE when CONFIG_XEN_WDT is set.

Fixes: 18cffd68e0c4 ("watchdog: xen_wdt: use the watchdog subsystem")
Signed-off-by: Radu Rendec <radu.rendec@gmail.com>
---
 drivers/watchdog/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index a16bad78679b..2953e9fbb818 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1838,6 +1838,7 @@ config WATCHDOG_SUN4V
 config XEN_WDT
 	tristate "Xen Watchdog support"
 	depends on XEN
+	select WATCHDOG_CORE
 	help
 	  Say Y here to support the hypervisor watchdog capability provided
 	  by Xen 4.0 and newer.  The watchdog timeout period is normally one
-- 
2.13.6
