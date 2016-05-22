Return-path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 52/54] MAINTAINERS: Add file patterns for watchdog device tree bindings
Date: Sun, 22 May 2016 11:06:29 +0200
Message-Id: <1463907991-7916-53-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
List-ID: <linux-watchdog@vger.kernel.org>

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f54762f002e16de..7202b6565dd98d50 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12400,6 +12400,7 @@ L:	linux-watchdog@vger.kernel.org
 W:	http://www.linux-watchdog.org/
 T:	git git://www.linux-watchdog.org/linux-watchdog.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/watchdog/
 F:	Documentation/watchdog/
 F:	drivers/watchdog/
 F:	include/linux/watchdog.h
-- 
1.9.1
