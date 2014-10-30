Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51196 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933563AbaJ3OPx (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Oct 2014 10:15:53 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] watchdog: at91rm9200: allow building when using device tree
Date: Thu, 30 Oct 2014 15:15:34 +0100
Message-Id: <1414678534-2677-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

When building with device tree, ARCH_AT91RM9200 may not be selected. Allow
building that driver by also depending on ARCH_AT91.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index e3d5bf0a5021..5445343ff2a1 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -144,7 +144,7 @@ config ARM_SP805_WATCHDOG
 
 config AT91RM9200_WATCHDOG
 	tristate "AT91RM9200 watchdog"
-	depends on ARCH_AT91RM9200
+	depends on ARCH_AT91RM9200 || ARCH_AT91
 	help
 	  Watchdog timer embedded into AT91RM9200 chips. This will reboot your
 	  system when the timeout is reached.
-- 
2.1.0

