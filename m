Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:50021 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbdHNQez (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 12:34:55 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v2 1/3] mfd: dm355evm_msp: move header file out of I2C realm
Date: Mon, 14 Aug 2017 18:34:22 +0200
Message-Id: <20170814163424.2197-2-wsa@the-dreams.de>
In-Reply-To: <20170814163424.2197-1-wsa@the-dreams.de>
References: <20170814163424.2197-1-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Change since V1:

* rebased to v4.13-rc5, no changes needed
* acks added. I think none are missing.

 drivers/input/misc/dm355evm_keys.c        | 2 +-
 drivers/mfd/dm355evm_msp.c                | 2 +-
 drivers/rtc/rtc-dm355evm.c                | 2 +-
 include/linux/{i2c => mfd}/dm355evm_msp.h | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename include/linux/{i2c => mfd}/dm355evm_msp.h (100%)

diff --git a/drivers/input/misc/dm355evm_keys.c b/drivers/input/misc/dm355evm_keys.c
index bab256ef32b9b3..c803db64a3760d 100644
--- a/drivers/input/misc/dm355evm_keys.c
+++ b/drivers/input/misc/dm355evm_keys.c
@@ -15,7 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 
-#include <linux/i2c/dm355evm_msp.h>
+#include <linux/mfd/dm355evm_msp.h>
 #include <linux/module.h>
 
 
diff --git a/drivers/mfd/dm355evm_msp.c b/drivers/mfd/dm355evm_msp.c
index 86eca614507bd8..2a2756709f22f0 100644
--- a/drivers/mfd/dm355evm_msp.c
+++ b/drivers/mfd/dm355evm_msp.c
@@ -18,7 +18,7 @@
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/i2c.h>
-#include <linux/i2c/dm355evm_msp.h>
+#include <linux/mfd/dm355evm_msp.h>
 
 
 /*
diff --git a/drivers/rtc/rtc-dm355evm.c b/drivers/rtc/rtc-dm355evm.c
index f225cd873ff6c2..97d8259b94940f 100644
--- a/drivers/rtc/rtc-dm355evm.c
+++ b/drivers/rtc/rtc-dm355evm.c
@@ -13,7 +13,7 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/dm355evm_msp.h>
+#include <linux/mfd/dm355evm_msp.h>
 #include <linux/module.h>
 
 
diff --git a/include/linux/i2c/dm355evm_msp.h b/include/linux/mfd/dm355evm_msp.h
similarity index 100%
rename from include/linux/i2c/dm355evm_msp.h
rename to include/linux/mfd/dm355evm_msp.h
-- 
2.11.0

