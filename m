Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from hauke-m.de ([5.39.93.123]:49213 "EHLO mail.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753679AbdDQT3x (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 17 Apr 2017 15:29:53 -0400
From: Hauke Mehrtens <hauke@hauke-m.de>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 01/13] MIPS: lantiq: Use of_platform_populate instead of __dt_register_buses
Date: Mon, 17 Apr 2017 21:29:30 +0200
Message-Id: <20170417192942.32219-2-hauke@hauke-m.de>
In-Reply-To: <20170417192942.32219-1-hauke@hauke-m.de>
References: <20170417192942.32219-1-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

This allows populating syscon devices which are using "simple-mfd"
instead of "simple-bus".

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/lantiq/prom.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/prom.c b/arch/mips/lantiq/prom.c
index 96773bed8a8a..72cc12f1b6a5 100644
--- a/arch/mips/lantiq/prom.c
+++ b/arch/mips/lantiq/prom.c
@@ -117,7 +117,8 @@ void __init prom_init(void)
 
 int __init plat_of_setup(void)
 {
-	return __dt_register_buses(soc_info.compatible, "simple-bus");
+	return of_platform_populate(NULL, of_default_bus_match_table, NULL,
+				    NULL);
 }
 
 arch_initcall(plat_of_setup);
-- 
2.11.0

