Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34279 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751859AbbEGNjL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 7 May 2015 09:39:11 -0400
Received: by wgic8 with SMTP id c8so17348865wgi.1
        for <linux-watchdog@vger.kernel.org>; Thu, 07 May 2015 06:39:10 -0700 (PDT)
From: Lee Jones <lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, devicetree@vger.kernel.org,
	daniel.lezcano@linaro.org, tglx@linutronix.de, wim@iguana.be,
	a.zummo@towertech.it, linux-watchdog@vger.kernel.org,
	rtc-linux@googlegroups.com, linux@roeck-us.net,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 12/12] ARM: STi: Update platform level menuconfig 'help'
Date: Thu,  7 May 2015 14:38:44 +0100
Message-Id: <1431005924-21777-13-git-send-email-lee.jones@linaro.org>
In-Reply-To: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Encompass newer STiH4{07,10} SoC based platforms.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-sti/Kconfig | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index cb886de..59928d9 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -16,11 +16,9 @@ menuconfig ARCH_STI
 	select PL310_ERRATA_769419 if CACHE_L2X0
 	select RESET_CONTROLLER
 	help
-	  Include support for STiH41x SOCs like STiH415/416 using the device tree
-	  for discovery
-	  More information at Documentation/arm/STiH41x and
-	  at Documentation/devicetree
-
+	  Include support for STMicroelectronics' STiH415/416 and stih407/10
+	  family SoCs using the Device Tree for discovery.  More information
+	  can be found in Documentation/arm/sti/ & Documentation/devicetree.
 
 if ARCH_STI
 
-- 
1.9.1

