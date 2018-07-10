Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from inva021.nxp.com ([92.121.34.21]:56000 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933345AbeGJOUg (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 10:20:36 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        festevam@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH v2 1/2] watchdog: imx2_wdt: Switch to SPDX identifier
Date: Tue, 10 Jul 2018 11:21:22 -0300
Message-Id: <1531232483-28950-1-git-send-email-fabio.estevam@nxp.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 drivers/watchdog/imx2_wdt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index f07850d..2b52514 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for IMX2 and later processors
  *
@@ -7,10 +8,6 @@
  * some parts adapted by similar drivers from Darius Augulis and Vladimir
  * Zapolskiy, additional improvements by Wim Van Sebroeck.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  * NOTE: MX1 has a slightly different Watchdog than MX2 and later:
  *
  *			MX1:		MX2+:
-- 
2.7.4

