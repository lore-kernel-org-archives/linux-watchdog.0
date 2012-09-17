Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:48593 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab2IQFgV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Sep 2012 01:36:21 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so658736dad.19
        for <linux-watchdog@vger.kernel.org>; Sun, 16 Sep 2012 22:36:20 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 19/34] watchdog: imx2_wdt: remove unneeded mach/hardware.h inclusion
Date: Mon, 17 Sep 2012 13:34:48 +0800
Message-Id: <1347860103-4141-20-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The inclusion of mach/hardware.h is not used by the driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/imx2_wdt.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index bcfab2b..9a45d029 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -33,7 +33,6 @@
 #include <linux/uaccess.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
-#include <mach/hardware.h>
 
 #define DRIVER_NAME "imx2-wdt"
 
-- 
1.7.9.5

