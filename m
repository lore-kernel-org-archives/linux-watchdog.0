Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:54811 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387436AbeKFBkP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 5 Nov 2018 20:40:15 -0500
From: Tomer Maimon <tmaimon77@gmail.com>
To: wim@linux-watchdog.org, linux@roeck-us.net, yuenn@google.com,
        venture@google.com, benjaminfair@google.com,
        brendanhiggins@google.com, avifishman70@gmail.com, joel@jms.id.au
Cc: linux-watchdog@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1] watchdog: npcm: Modify npcm watchdog kconfig arch parameter
Date: Mon,  5 Nov 2018 18:11:52 +0200
Message-Id: <20181105161152.205524-1-tmaimon77@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Modify Nuvoton watchdog Kconfig default supported architecture
name to ARCH_NPCM7XX because ARCH_NPCM750 architecture name
is not supported.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 2d64333f4782..746759ec8960 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -538,7 +538,7 @@ config COH901327_WATCHDOG
 config NPCM7XX_WATCHDOG
 	bool "Nuvoton NPCM750 watchdog"
 	depends on ARCH_NPCM || COMPILE_TEST
-	default y if ARCH_NPCM750
+	default y if ARCH_NPCM7XX
 	select WATCHDOG_CORE
 	help
 	  Say Y here to include Watchdog timer support for the
-- 
2.14.1
