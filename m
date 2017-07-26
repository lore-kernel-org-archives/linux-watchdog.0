Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:34851 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbdGZVy7 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 26 Jul 2017 17:54:59 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 3/3] watchdog: renesas_wdt: update copyright dates
Date: Wed, 26 Jul 2017 23:54:39 +0200
Message-Id: <20170726215439.9623-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
References: <20170726215439.9623-1-wsa+renesas@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/watchdog/renesas_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 2927b5086e156e..831ef83f6de15b 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -1,8 +1,8 @@
 /*
  * Watchdog driver for Renesas WDT watchdog
  *
- * Copyright (C) 2015-16 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
- * Copyright (C) 2015-16 Renesas Electronics Corporation
+ * Copyright (C) 2015-17 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
+ * Copyright (C) 2015-17 Renesas Electronics Corporation
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
-- 
2.11.0

