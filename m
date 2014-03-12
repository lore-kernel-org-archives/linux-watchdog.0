Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:62435 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbaCLWMD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 18:12:03 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so15551204igc.1
        for <linux-watchdog@vger.kernel.org>; Wed, 12 Mar 2014 15:12:02 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: wim@iguana.be
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: fix ARCH_BCM_MOBILE dependency
Date: Wed, 12 Mar 2014 17:12:02 -0500
Message-Id: <1394662322-12445-1-git-send-email-elder@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Starting with this commit:
    047ef2fa rename ARCH_BCM to ARCH_BCM_MOBILE (clocksource)
the meaning of the ARCH_BCM config option is changed to represent
all Broadcom chips with code in the mach-bcm directory.

Configuration options related to specific Broadcom platforms should
now use another symbol (currently ARCH_BCM_MOBILE, ARCH_BCM2835, or
ARCH_BCM_5301X).

The BCM_KONA_WDT config option indicates a dependency on ARCH_BCM,
but it should be ARCH_BCM_MOBILE instead.  Fix that.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/watchdog/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79d2589..47a6f10 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1160,7 +1160,7 @@ config BCM2835_WDT
 
 config BCM_KONA_WDT
 	tristate "BCM Kona Watchdog"
-	depends on ARCH_BCM
+	depends on ARCH_BCM_MOBILE
 	select WATCHDOG_CORE
 	help
 	  Support for the watchdog timer on the following Broadcom BCM281xx
-- 
1.7.9.5

