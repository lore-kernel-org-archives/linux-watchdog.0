Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:58468 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752961Ab2L0Oia (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Dec 2012 09:38:30 -0500
From: Gabor Juhos <juhosg@openwrt.org>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
	linux-mips@linux-mips.org, Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH 2/3] MIPS: ath79: use dynamically allocated watchdog device
Date: Thu, 27 Dec 2012 15:38:25 +0100
Message-Id: <1356619106-13403-2-git-send-email-juhosg@openwrt.org>
In-Reply-To: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
References: <1356619106-13403-1-git-send-email-juhosg@openwrt.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Remove the static watchdog device variable and use
the 'platform_device_register_simple' helper to
allocate and register the device in one step.

This allows us to save a few bytes in the kernel image.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Ralf,

The next patch in the series depends on patch, so this
 should be merged via the watchdog tree.

-Gabor
---
 arch/mips/ath79/dev-common.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/mips/ath79/dev-common.c b/arch/mips/ath79/dev-common.c
index 45efc63..2093b1b 100644
--- a/arch/mips/ath79/dev-common.c
+++ b/arch/mips/ath79/dev-common.c
@@ -101,12 +101,7 @@ void __init ath79_register_uart(void)
 	}
 }
 
-static struct platform_device ath79_wdt_device = {
-	.name		= "ath79-wdt",
-	.id		= -1,
-};
-
 void __init ath79_register_wdt(void)
 {
-	platform_device_register(&ath79_wdt_device);
+	platform_device_register_simple("ath79-wdt", -1, NULL, 0);
 }
-- 
1.7.10

