Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from guitar.tcltek.co.il ([192.115.133.116]:41680 "EHLO
	mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755736Ab3L3M1T (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 30 Dec 2013 07:27:19 -0500
From: Baruch Siach <baruch@tkos.co.il>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
	Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH v2] watchdog: dw_wdt: remove build dependencies
Date: Mon, 30 Dec 2013 14:25:54 +0200
Message-Id: <a41f433ac50ef0da9e9eae0e793119cb4e88b9e3.1388406354.git.baruch@tkos.co.il>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

There is nothing ARM specific in this driver, and we intend to use it on the
Xtensa architecture. Also, clk.h now includes stubs for !CONFIG_HAVE_CLK, so
the driver should build anyway.

Cc: Jamie Iles <jamie@jamieiles.com>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
    Don't mention ARM in the Kconfig help text, and source comment

    Mention in the commit log message that this driver is used on Xtensa
---
 drivers/watchdog/Kconfig  | 3 +--
 drivers/watchdog/dw_wdt.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 5be6e91..d3bcad0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -214,10 +214,9 @@ config SA1100_WATCHDOG
 
 config DW_WATCHDOG
 	tristate "Synopsys DesignWare watchdog"
-	depends on ARM && HAVE_CLK
 	help
 	  Say Y here if to include support for the Synopsys DesignWare
-	  watchdog timer found in many ARM chips.
+	  watchdog timer found in many chips.
 	  To compile this driver as a module, choose M here: the
 	  module will be called dw_wdt.
 
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index a46f5c7..ee4f86b 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -8,7 +8,7 @@
  * 2 of the License, or (at your option) any later version.
  *
  * This file implements a driver for the Synopsys DesignWare watchdog device
- * in the many ARM subsystems. The watchdog has 16 different timeout periods
+ * in the many subsystems. The watchdog has 16 different timeout periods
  * and these are a function of the input clock frequency.
  *
  * The DesignWare watchdog cannot be stopped once it has been started so we
-- 
1.8.5.2

