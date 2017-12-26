Return-Path: <groeck7@gmail.com>
Return-path: <groeck7@gmail.com>
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH] MAINTAINERS: Add Guenter Roeck as co-maintainer of watchdog subsystem
Date: Tue, 26 Dec 2017 09:48:12 -0800
Message-Id: <1514310492-26098-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Having a co-maintainer will enable us to be more flexible with
pull requests.

Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57e034d4e270..5d2c97ca16c7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14722,7 +14722,7 @@ F:	drivers/input/tablet/wacom_serial4.c
 
 WATCHDOG DEVICE DRIVERS
 M:	Wim Van Sebroeck <wim@iguana.be>
-R:	Guenter Roeck <linux@roeck-us.net>
+M:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-watchdog@vger.kernel.org
 W:	http://www.linux-watchdog.org/
 T:	git git://www.linux-watchdog.org/linux-watchdog.git
-- 
2.7.4
