Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62566 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933815Ab2EXUTU (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 May 2012 16:19:20 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>,
	LM Sensors <lm-sensors@lm-sensors.org>,
	linux-next@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] hwmon/sch56xx: Depend on watchdog for watchdog core functions
Date: Thu, 24 May 2012 22:18:58 +0200
Message-Id: <1337890738-26533-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since the watchdog code in sch56xx-common now uses the watchdog core, the
Kconfig entires for the sch5627 and sch5636 should depend on WATCHDOG
being set.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 8deedc1..3d16d66 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1036,7 +1036,7 @@ config SENSORS_SCH56XX_COMMON
 
 config SENSORS_SCH5627
 	tristate "SMSC SCH5627"
-	depends on !PPC
+	depends on !PPC && WATCHDOG
 	select SENSORS_SCH56XX_COMMON
 	help
 	  If you say yes here you get support for the hardware monitoring
@@ -1048,7 +1048,7 @@ config SENSORS_SCH5627
 
 config SENSORS_SCH5636
 	tristate "SMSC SCH5636"
-	depends on !PPC
+	depends on !PPC && WATCHDOG
 	select SENSORS_SCH56XX_COMMON
 	help
 	  SMSC SCH5636 Super I/O chips include an embedded microcontroller for
-- 
1.7.10

