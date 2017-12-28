Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33884 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751905AbdL1QCN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 11:02:13 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: mail@maciej.szmigiero.name, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/3] watchdog: Change ISA_BUS_API dependency to selection
Date: Thu, 28 Dec 2017 11:02:06 -0500
Message-Id: <4035bdd9c6ff2b9686e69c27e5eb887fd8f9a2bf.1514475654.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1514475654.git.vilhelm.gray@gmail.com>
References: <cover.1514475654.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
driver. The ISA bus driver does not perform any hardware interaction,
and is instead just a thin layer of software abstraction to eliminate
boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
has no dependencies and does not jeopardize the integrity of the system
when enabled, drivers should select it when the ISA bus driver
functionality is needed.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/watchdog/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index ca200d1f310a..c05d5d20eebf 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -864,7 +864,8 @@ config ALIM7101_WDT
 
 config EBC_C384_WDT
 	tristate "WinSystems EBC-C384 Watchdog Timer"
-	depends on X86 && ISA_BUS_API
+	depends on X86
+	select ISA_BUS_API
 	select WATCHDOG_CORE
 	help
 	  Enables watchdog timer support for the watchdog timer on the
-- 
2.15.1

