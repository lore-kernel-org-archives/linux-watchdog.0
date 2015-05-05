Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: [PATCH 26/27] watchdog: Allow compile test of GPIO consumers if !GPIOLIB
Date: Tue,  5 May 2015 18:32:42 +0200
Message-Id: <1430843563-18615-26-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
References: <1430836404-15513-1-git-send-email-geert@linux-m68k.org>
 <1430843563-18615-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is
not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consumer
functionality only, can still be compiled if GPIOLIB is not enabled.

Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
appropriate.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e5e7c5505de7dc8f..d0f03ee22425011f 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1343,7 +1343,7 @@ config BOOKE_WDT_DEFAULT_TIMEOUT
 config MEN_A21_WDT
        tristate "MEN A21 VME CPU Carrier Board Watchdog Timer"
        select WATCHDOG_CORE
-       depends on GPIOLIB
+       depends on GPIOLIB || COMPILE_TEST
        help
         Watchdog driver for MEN A21 VMEbus CPU Carrier Boards.
 
-- 
1.9.1
