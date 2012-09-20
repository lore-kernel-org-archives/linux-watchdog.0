Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47825 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab2ITGrO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 20 Sep 2012 02:47:14 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so4370308pbb.19
        for <linux-watchdog@vger.kernel.org>; Wed, 19 Sep 2012 23:47:14 -0700 (PDT)
From: Shawn Guo <shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Javier Martin <javier.martin@vista-silicon.com>,
	Rob Herring <rob.herring@calxeda.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Shawn Guo <shawn.guo@linaro.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 18/34] watchdog: imx2_wdt: remove unneeded mach/hardware.h inclusion
Date: Thu, 20 Sep 2012 14:45:31 +0800
Message-Id: <1348123547-31082-19-git-send-email-shawn.guo@linaro.org>
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The inclusion of mach/hardware.h is not used by the driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
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

