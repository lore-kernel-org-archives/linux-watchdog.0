Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35067 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbbCIIuR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 9 Mar 2015 04:50:17 -0400
Received: by obbgq1 with SMTP id gq1so32079528obb.2
        for <linux-watchdog@vger.kernel.org>; Mon, 09 Mar 2015 01:50:16 -0700 (PDT)
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Zach Pfeffer <zachp@xilinx.com>, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: [PATCH] watchdog: cadence: Remove Kconfig dependency on ARCH
Date: Mon,  9 Mar 2015 09:50:12 +0100
Message-Id: <491e97be16decb4901fa2b0be4b530774501b5c1.1425891008.git.michal.simek@xilinx.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Remove Kconfig dependency and enable driver for
all ARCHs.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Test for all archs done by Kbuild test robot without any problem.
---
 drivers/watchdog/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 16f202350997..6442412377a4 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -169,7 +169,6 @@ config AT91SAM9X_WATCHDOG
 
 config CADENCE_WATCHDOG
 	tristate "Cadence Watchdog Timer"
-	depends on ARM
 	select WATCHDOG_CORE
 	help
 	  Say Y here if you want to include support for the watchdog
-- 
1.8.2.3

