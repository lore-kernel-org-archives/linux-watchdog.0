Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yb0-f193.google.com ([209.85.213.193]:37090 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbdL1QC0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 11:02:26 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: linus.walleij@linaro.org
Cc: mail@maciej.szmigiero.name, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 3/3] gpio: Change ISA_BUS_API dependency to selection
Date: Thu, 28 Dec 2017 11:02:19 -0500
Message-Id: <ff1871fe837aa3a520fefe2602f8f1e13e1db244.1514475654.git.vilhelm.gray@gmail.com>
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

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/Kconfig | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 395669bfcc26..36ad9ce3dc58 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -590,7 +590,8 @@ menu "Port-mapped I/O GPIO drivers"
 
 config GPIO_104_DIO_48E
 	tristate "ACCES 104-DIO-48E GPIO support"
-	depends on PC104 && ISA_BUS_API
+	depends on PC104
+	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
@@ -600,7 +601,8 @@ config GPIO_104_DIO_48E
 
 config GPIO_104_IDIO_16
 	tristate "ACCES 104-IDIO-16 GPIO support"
-	depends on PC104 && ISA_BUS_API
+	depends on PC104
+	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-IDIO-16 family (104-IDIO-16,
@@ -611,7 +613,8 @@ config GPIO_104_IDIO_16
 
 config GPIO_104_IDI_48
 	tristate "ACCES 104-IDI-48 GPIO support"
-	depends on PC104 && ISA_BUS_API
+	depends on PC104
+	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
@@ -631,7 +634,8 @@ config GPIO_F7188X
 
 config GPIO_GPIO_MM
 	tristate "Diamond Systems GPIO-MM GPIO support"
-	depends on PC104 && ISA_BUS_API
+	depends on PC104
+	select ISA_BUS_API
 	help
 	  Enables GPIO support for the Diamond Systems GPIO-MM and GPIO-MM-12.
 
@@ -700,7 +704,7 @@ config GPIO_TS5500
 
 config GPIO_WS16C48
 	tristate "WinSystems WS16C48 GPIO support"
-	depends on ISA_BUS_API
+	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the WinSystems WS16C48. The base port
-- 
2.15.1

