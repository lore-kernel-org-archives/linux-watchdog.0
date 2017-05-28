Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:50748 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750798AbdE1Sk1 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 28 May 2017 14:40:27 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 01/16] MIPS: lantiq: Use of_platform_default_populate instead of __dt_register_buses
Date: Sun, 28 May 2017 20:39:51 +0200
Message-Id: <20170528184006.31668-2-hauke@hauke-m.de>
In-Reply-To: <20170528184006.31668-1-hauke@hauke-m.de>
References: <20170528184006.31668-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This allows populating syscon devices which are using "simple-mfd"
instead of "simple-bus".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/mips/lantiq/prom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 96773bed8a8a..9ff7ccde9de0 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -117,7 +117,7 @@ void __init prom_init(void)
 
 int __init plat_of_setup(void)
 {
-	return __dt_register_buses(soc_info.compatible, "simple-bus");
+	return of_platform_default_populate(NULL, NULL, NULL);
 }
 
 arch_initcall(plat_of_setup);
-- 
2.11.0

