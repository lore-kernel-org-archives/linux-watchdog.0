Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34646 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752323AbcEAWoT (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 1 May 2016 18:44:19 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 05/10] iio: stx104: Utilize the module_isa_driver and max_num_isa_dev macros
Date: Sun,  1 May 2016 18:44:11 -0400
Message-Id: <fbf47c2fecb0dbaee717fc7f863cee1a903c8ae0.1462141338.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1462141338.git.vilhelm.gray@gmail.com>
References: <cover.1462141338.git.vilhelm.gray@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The Apex Embedded Systems STX104 DAC drivers does not do anything
special in module init/exit. This patch eliminates the module init/exit
boilerplate code by utilizing the module_isa_driver macro.

Additionally, the max_num_isa_dev macro is utilized to simplify the
determination of maximum possible STX104 devices in the system.

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
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

