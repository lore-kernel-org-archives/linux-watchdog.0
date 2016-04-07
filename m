Return-path: <vilhelm.gray@gmail.com>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	wim@iguana.be,
	linux@roeck-us.net,
	linus.walleij@linaro.org,
	gnurou@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH 04/10] iio: stx104: Change STX104 dependency to ISA_BUS
Date: Thu,  7 Apr 2016 10:47:25 -0400
Message-Id: <783be62acf68b35f3fe4785a2cedfe017624688b.1460040201.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

The Apex Embedded Systems STX104 may be used on 64-bit X86 systems. This
patch allows the Apex Embedded Systems STX104 DAC driver to be compiled
for both 32-bit and 64-bit X86 systems.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/dac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index a995139..df4b55d 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -210,7 +210,7 @@ config MCP4922
 
 config STX104
 	tristate "Apex Embedded Systems STX104 DAC driver"
-	depends on ISA
+	depends on X86 && ISA_BUS
 	help
 	  Say yes here to build support for the 2-channel DAC on the Apex
 	  Embedded Systems STX104 integrated analog PC/104 card. The base port
-- 
2.7.3
