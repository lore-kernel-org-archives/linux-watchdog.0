Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8660 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932466Ab2F1KSS (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 28 Jun 2012 06:18:18 -0400
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: iTCO_wdt depends on watchdog core
Date: Thu, 28 Jun 2012 13:19:49 +0300
Message-Id: <1340878789-23759-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Since the iTCO_wdt watchdog driver now uses the generic
watchdog framework, it needs to select it.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/watchdog/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index fe819b7..277ecbc 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -578,6 +578,7 @@ config INTEL_SCU_WATCHDOG
 config ITCO_WDT
 	tristate "Intel TCO Timer/Watchdog"
 	depends on (X86 || IA64) && PCI
+	select WATCHDOG_CORE
 	select LPC_ICH
 	---help---
 	  Hardware driver for the intel TCO timer based watchdog devices.
-- 
1.7.10

