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
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v5 3/4] iio: stx104: Allow build for X86_64
Date: Fri, 27 May 2016 18:09:08 -0400
Message-Id: <26bbe8f7c46b2504068f11c1f6219e1df6879822.1464380034.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1464380034.git.vilhelm.gray@gmail.com>
References: <cover.1464380034.git.vilhelm.gray@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

With the introduction of the ISA_BUS_API Kconfig option, ISA-style
drivers may be built for X86_64 architectures. This patch changes the
ISA Kconfig option dependency of the Apex Embedded Systems STX104 DAC
driver to ISA_BUS_API, thus allowing it to build for X86_64 as it is
expected to.

Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/dac/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index e63b957..f7c71da 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -247,7 +247,7 @@ config MCP4922
 
 config STX104
 	tristate "Apex Embedded Systems STX104 DAC driver"
-	depends on X86 && ISA
+	depends on X86 && ISA_BUS_API
 	help
 	  Say yes here to build support for the 2-channel DAC on the Apex
 	  Embedded Systems STX104 integrated analog PC/104 card. The base port
-- 
2.7.3
