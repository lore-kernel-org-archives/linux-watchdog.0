Return-path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org,
	akpm@linux-foundation.org
Cc: x86@kernel.org,
	linux-next@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	sfr@canb.auug.org.au,
	linux@roeck-us.net,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v5 2/4] gpio: Allow PC/104 devices on X86_64
Date: Fri, 27 May 2016 18:08:56 -0400
Message-Id: <61880bededb77bbc3ea3422e48ce717d2a2ff489.1464380034.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1464380034.git.vilhelm.gray@gmail.com>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

With the introduction of the ISA_BUS_API Kconfig option, ISA-style
drivers may be built for X86_64 architectures. This patch changes the
ISA Kconfig option dependency of the PC/104 drivers to ISA_BUS_API, thus
allowing them to build for X86_64 as they are expected to.

Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
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
