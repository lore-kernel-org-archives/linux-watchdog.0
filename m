Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46544 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdK3IsN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 30 Nov 2017 03:48:13 -0500
Received: by mail-wr0-f195.google.com with SMTP id x49so5772049wrb.13
        for <linux-watchdog@vger.kernel.org>; Thu, 30 Nov 2017 00:48:13 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: wim@iguana.be, linux@roeck-us.net, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc: linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>
Subject: [PATCH v2] watchdog: stm32: Fix copyright
Date: Thu, 30 Nov 2017 09:48:04 +0100
Message-Id: <20171130084804.23693-1-benjamin.gaignard@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Uniformize STMicroelectronics copyrights header
Add SPDX identifier

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>
CC: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/watchdog/stm32_iwdg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index be64a8699de3..c97ad5619cb0 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -1,12 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for STM32 Independent Watchdog
  *
- * Copyright (C) Yannick Fertre 2017
- * Author: Yannick Fertre <yannick.fertre@st.com>
+ * Copyright (C) STMicroelectronics 2017
+ * Author: Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
  *
  * This driver is based on tegra_wdt.c
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/clk.h>
-- 
2.15.0

