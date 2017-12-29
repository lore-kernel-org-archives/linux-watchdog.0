Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44831 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751304AbdL2UPI (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 29 Dec 2017 15:15:08 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: mail@maciej.szmigiero.name, linux@roeck-us.net,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 5/5] pc104: Add EXPERT dependency for PC104 Kconfig option
Date: Fri, 29 Dec 2017 15:14:59 -0500
Message-Id: <5c573c758e07ee9539045c1b062b9bab1ad1669c.1514578085.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1514578085.git.vilhelm.gray@gmail.com>
References: <cover.1514578085.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

PC/104 device driver Kconfig options previously had an implicit EXPERT
dependency by way of an explicit ISA_BUS_API dependency. Now that these
driver Kconfig options select ISA_BUS_API rather than depend on it, the
PC104 Kconfig option should have an explicit EXPERT dependency.

The PC/104 form factor and bus architecture are common in embedded
and specialized systems, but uncommon in typical desktop setups. For
this reason, it is best to mask these devices and configurations via the
EXPERT Kconfig option because the majority of users will never need to
concern themselves with PC/104.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 2934249fba46..227ca1300d1b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1420,7 +1420,7 @@ config PERF_USE_VMALLOC
 	  See tools/perf/design.txt for details
 
 config PC104
-	bool "PC/104 support"
+	bool "PC/104 support" if EXPERT
 	help
 	  Expose PC/104 form factor device drivers and options available for
 	  selection and configuration. Enable this option if your target
-- 
2.15.1

