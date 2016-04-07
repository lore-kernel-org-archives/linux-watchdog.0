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
Subject: [PATCH 05/10] iio: stx104: Utilize the module_isa_driver and max_num_isa_dev macros
Date: Thu,  7 Apr 2016 10:47:26 -0400
Message-Id: <2c597eeaec79f91560654cb4959709bb2dcfaeab.1460040201.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1460040201.git.vilhelm.gray@gmail.com>
References: <cover.1460040201.git.vilhelm.gray@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

The Apex Embedded Systems STX104 DAC drivers does not do anything
special in module init/exit. This patch eliminates the module init/exit
boilerplate code by utilizing the module_isa_driver macro.

Additionally, the max_num_isa_dev macro is utilized to simplify the
determination of maximum possible STX104 devices in the system.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/dac/stx104.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
index 174f4b7..2794122 100644
--- a/drivers/iio/dac/stx104.c
+++ b/drivers/iio/dac/stx104.c
@@ -33,16 +33,9 @@
 }
 
 #define STX104_EXTENT 16
-/**
- * The highest base address possible for an ISA device is 0x3FF; this results in
- * 1024 possible base addresses. Dividing the number of possible base addresses
- * by the address extent taken by each device results in the maximum number of
- * devices on a system.
- */
-#define MAX_NUM_STX104 (1024 / STX104_EXTENT)
 
-static unsigned base[MAX_NUM_STX104];
-static unsigned num_stx104;
+static unsigned int base[max_num_isa_dev(STX104_EXTENT)];
+static unsigned int num_stx104;
 module_param_array(base, uint, &num_stx104, 0);
 MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
@@ -134,18 +127,7 @@ static struct isa_driver stx104_driver = {
 	}
 };
 
-static void __exit stx104_exit(void)
-{
-	isa_unregister_driver(&stx104_driver);
-}
-
-static int __init stx104_init(void)
-{
-	return isa_register_driver(&stx104_driver, num_stx104);
-}
-
-module_init(stx104_init);
-module_exit(stx104_exit);
+module_isa_driver(stx104_driver, num_stx104);
 
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("Apex Embedded Systems STX104 DAC driver");
-- 
2.7.3
