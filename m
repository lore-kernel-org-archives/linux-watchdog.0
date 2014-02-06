Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42339 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756496AbaBFRVm (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 6 Feb 2014 12:21:42 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>,
	Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v6 17/19] watchdog: orion: Enable the build on ARCH_MVEBU
Date: Thu,  6 Feb 2014 14:20:24 -0300
Message-Id: <1391707226-18258-18-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1391707226-18258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

After adding support for Armada 370/XP SoC let's enable the build on
these platforms.

Tested-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 4c4c566..2dda6c0 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -291,7 +291,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
+	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
-- 
1.8.1.5

