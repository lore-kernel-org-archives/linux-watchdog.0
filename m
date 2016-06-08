Return-path: <Vladimir_Zapolskiy@mentor.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
To: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: drop redundant 'default n' option for WATCHDOG_SYSFS
Date: Wed, 8 Jun 2016 18:16:15 +0300
Message-ID: <1465398975-11207-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

The option 'default n' and its absence are equal for kbuild,
which makes explicit 'default n' redundant.

Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 drivers/watchdog/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index b54f26c..8d38cb8 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -48,7 +48,6 @@ config WATCHDOG_NOWAYOUT
 
 config WATCHDOG_SYSFS
 	bool "Read different watchdog information through sysfs"
-	default n
 	help
 	  Say Y here if you want to enable watchdog device status read through
 	  sysfs attributes.
-- 
2.5.0
