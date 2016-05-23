Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36165 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbcEWO7A (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 May 2016 10:59:00 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org, akpm@linux-foundation.org
Cc: x86@kernel.org, linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/4] gpio: Allow PC/104 devices on X86_64
Date: Mon, 23 May 2016 10:58:52 -0400
Message-Id: <76d69814db6ad4191588a43bacce360d934c4e52.1464014576.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1464014576.git.vilhelm.gray@gmail.com>
References: <cover.1464014576.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

With the introduction of the ISA_BUS_API Kconfig option, ISA-style
drivers may be built for X86_64 architectures. This patch changes the
ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API, thus
allowing them to build for X86_64 as they are expected to.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/gpio/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 48da857..dc6da77 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -530,7 +530,7 @@ menu "Port-mapped I/O GPIO drivers"
 
 config GPIO_104_DIO_48E
 	tristate "ACCES 104-DIO-48E GPIO support"
-	depends on ISA
+	depends on ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-DIO-48E series (104-DIO-48E,
@@ -540,7 +540,7 @@ config GPIO_104_DIO_48E
 
 config GPIO_104_IDIO_16
 	tristate "ACCES 104-IDIO-16 GPIO support"
-	depends on ISA
+	depends on ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-IDIO-16 family (104-IDIO-16,
@@ -551,7 +551,7 @@ config GPIO_104_IDIO_16
 
 config GPIO_104_IDI_48
 	tristate "ACCES 104-IDI-48 GPIO support"
-	depends on ISA
+	depends on ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the ACCES 104-IDI-48 family (104-IDI-48A,
@@ -627,7 +627,7 @@ config GPIO_TS5500
 
 config GPIO_WS16C48
 	tristate "WinSystems WS16C48 GPIO support"
-	depends on ISA
+	depends on ISA_BUS_API
 	select GPIOLIB_IRQCHIP
 	help
 	  Enables GPIO support for the WinSystems WS16C48. The base port
-- 
2.7.3

