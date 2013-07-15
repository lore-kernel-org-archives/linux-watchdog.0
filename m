Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:60563 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758391Ab3GOXeD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 15 Jul 2013 19:34:03 -0400
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <linux-arm-kernel@lists.infradead.org>,
	<devicetree-discuss@lists.ozlabs.org>,
	<linux-watchdog@vger.kernel.org>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 08/10] watchdog: orion: Remove mach-specific unneeded header
Date: Mon, 15 Jul 2013 20:32:41 -0300
Message-Id: <1373931163-12670-9-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The mach/bridge-regs.h header is not needed anymore, so we can remove it.
This commit allows to use this driver on multiplatforms builds.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/orion_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index 4a0ab47..4ed7a74 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -26,12 +26,12 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/time-orion.h>
-#include <mach/bridge-regs.h>
 
 /*
  * Watchdog timer block registers.
  */
 #define WDT_EN			0x0010
+#define WDT_RESET_OUT_EN	0x0002
 
 #define WDT_MAX_CYCLE_COUNT	0xffffffff
 #define WDT_IN_USE		0
-- 
1.8.1.5

