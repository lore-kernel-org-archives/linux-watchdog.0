Return-Path: <rrendec@arista.com>
Return-path: <rrendec@arista.com>
From: Radu Rendec <rrendec@arista.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v3 2/2] watchdog: xen_wdt: remove info message and version number
Date: Tue, 14 Nov 2017 16:23:50 +0000
Message-Id: <20171114162350.24283-3-rrendec@arista.com>
In-Reply-To: <20171114162350.24283-1-rrendec@arista.com>
References: <20171114162350.24283-1-rrendec@arista.com>
List-ID: <linux-watchdog@vger.kernel.org>

The initial info message (early in the xen_wdt_init_module() function)
is not very useful and we already have a message on successful probe. If
the probe fails, additional messages are printed anyway.

The version number serves no useful purpose and it ran out of favor
upstream anyway.

Signed-off-by: Radu Rendec <rrendec@arista.com>
---
 drivers/watchdog/xen_wdt.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index 4e00419bd47d..1a40721716ef 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -11,7 +11,6 @@
 
 #define DRV_NAME	"xen_wdt"
 #define DEV_NAME	"watchdog"
-#define DRV_VERSION	"0.01"
 
 #include <linux/bug.h>
 #include <linux/errno.h>
@@ -196,8 +195,6 @@ static int __init xen_wdt_init_module(void)
 	if (!xen_domain())
 		return -ENODEV;
 
-	pr_info("Xen WatchDog Timer Driver v%s\n", DRV_VERSION);
-
 	err = platform_driver_register(&xen_wdt_driver);
 	if (err)
 		return err;
@@ -223,5 +220,4 @@ module_exit(xen_wdt_cleanup_module);
 
 MODULE_AUTHOR("Jan Beulich <jbeulich@novell.com>");
 MODULE_DESCRIPTION("Xen WatchDog Timer Driver");
-MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL");
-- 
2.13.6
