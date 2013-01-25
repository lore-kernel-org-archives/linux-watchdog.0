Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@list.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Fabio Porcedda <fabio.porcedda@gmail.com>
Subject: [PATCH 10/19] watchdog: at91sam9: at91_wdt_dt_ids cannot be __init
Date: Fri, 25 Jan 2013 14:14:27 +0000
Message-Id: <1359123276-15833-11-git-send-email-arnd@arndb.de>
In-Reply-To: <1359123276-15833-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

The device IDs are referenced by the driver and potentially
used beyond the init time, as kbuild correctly warns
about. Remove the __initconst annotation.

Without this patch, building at91_dt_defconfig results in:

WARNING: drivers/watchdog/built-in.o(.data+0x28): Section mismatch in reference from the variable at91wdt_driver to the (unknown reference) .init.rodata:(unknown)
The variable at91wdt_driver references
the (unknown reference) __initconst (unknown)

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/watchdog/at91sam9_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index dc42e44..6dad954 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -304,7 +304,7 @@ static int __exit at91wdt_remove(struct platform_device *pdev)
 }
 
 #if defined(CONFIG_OF)
-static const struct of_device_id at91_wdt_dt_ids[] __initconst = {
+static const struct of_device_id at91_wdt_dt_ids[] = {
 	{ .compatible = "atmel,at91sam9260-wdt" },
 	{ /* sentinel */ }
 };
-- 
1.8.0
