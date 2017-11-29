Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39753 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753544AbdK2O2C (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 29 Nov 2017 09:28:02 -0500
Received: by mail-wm0-f68.google.com with SMTP id i11so6300737wmf.4
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Nov 2017 06:28:02 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: wim@iguana.be, linux@roeck-us.net, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com
Cc: linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Yannick Fertre <yannick.fertre@st.com>
Subject: [PATCH] watchdog: stm32: Fix copyright
Date: Wed, 29 Nov 2017 15:27:53 +0100
Message-Id: <20171129142753.23681-1-benjamin.gaignard@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Uniformize STMicroelectronics copyrights header

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
CC: Yannick Fertre <yannick.fertre@st.com>
---
 drivers/watchdog/stm32_iwdg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index be64a8699de3..c6c8351f1598 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -1,8 +1,8 @@
 /*
  * Driver for STM32 Independent Watchdog
  *
- * Copyright (C) Yannick Fertre 2017
- * Author: Yannick Fertre <yannick.fertre@st.com>
+ * Copyright (C) STMicroelectronics SA 2017
+ * Author: Yannick Fertre <yannick.fertre@st.com> for STMicroelectronics.
  *
  * This driver is based on tegra_wdt.c
  *
-- 
2.15.0

