Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:45734 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343AbaGJVlm (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 10 Jul 2014 17:41:42 -0400
From: Andrew Lunn <andrew@lunn.ch>
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux ARM <linux-arm-kernel@lists.infradead.org>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v2 12/12] watchdog: Remove ARCH_KIRKWOOD dependency
Date: Thu, 10 Jul 2014 23:36:32 +0200
Message-Id: <1405028192-9623-13-git-send-email-andrew@lunn.ch>
In-Reply-To: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
References: <1405028192-9623-1-git-send-email-andrew@lunn.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index c845527b503a..a0bfb48a6747 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -301,7 +301,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU
+	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
-- 
2.0.1

