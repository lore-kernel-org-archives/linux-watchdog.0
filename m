Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from inva021.nxp.com ([92.121.34.21]:54642 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbeGJOT3 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 10 Jul 2018 10:19:29 -0400
From: Fabio Estevam <fabio.estevam@nxp.com>
To: wim@linux-watchdog.org
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
        festevam@gmail.com, Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 2/2] watchdog: imx2_wdt: Switch to SPDX identifier
Date: Tue, 10 Jul 2018 11:20:12 -0300
Message-Id: <1531232412-28889-2-git-send-email-fabio.estevam@nxp.com>
In-Reply-To: <1531232412-28889-1-git-send-email-fabio.estevam@nxp.com>
References: <1531232412-28889-1-git-send-email-fabio.estevam@nxp.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/watchdog/stmp3xxx_rtc_wdt.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index d8b11eb..994c54c 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for the RTC based watchdog in STMP3xxx and i.MX23/28
  *
  * Author: Wolfram Sang <kernel@pengutronix.de>
  *
  * Copyright (C) 2011-12 Wolfram Sang, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
-- 
2.7.4

