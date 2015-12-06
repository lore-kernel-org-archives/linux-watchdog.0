Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] MAINTAINERS: Add Guenter Roeck as reviewer of watchdog drivers
Date: Sat,  5 Dec 2015 22:18:25 -0800
Message-Id: <1449382705-7033-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

I have been reviewing watchdog drivers for years, so we might
as well make it official.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cba790b42f23..b1e3da7dc393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11602,6 +11602,7 @@ F:	drivers/input/tablet/wacom_serial4.c
 
 WATCHDOG DEVICE DRIVERS
 M:	Wim Van Sebroeck <wim@iguana.be>
+R:	Guenter Roeck <linux@roeck-us.net>
 L:	linux-watchdog@vger.kernel.org
 W:	http://www.linux-watchdog.org/
 T:	git git://www.linux-watchdog.org/linux-watchdog.git
-- 
2.1.4
