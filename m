Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53996 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933105AbeGFNIN (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 6 Jul 2018 09:08:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so14868111wme.3
        for <linux-watchdog@vger.kernel.org>; Fri, 06 Jul 2018 06:08:13 -0700 (PDT)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: wim@linux-watchdog.org, linux@roeck-us.net,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com
Cc: linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] watchdog: stm32: replace "%p" with "%pK"
Date: Fri,  6 Jul 2018 15:08:08 +0200
Message-Id: <20180706130808.22466-1-benjamin.gaignard@st.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

The format specifier "%p" can leak kernel addresses.
Use "%pK" instead.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/watchdog/stm32_iwdg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/stm32_iwdg.c b/drivers/watchdog/stm32_iwdg.c
index c97ad5619cb0..740f74a98644 100644
--- a/drivers/watchdog/stm32_iwdg.c
+++ b/drivers/watchdog/stm32_iwdg.c
@@ -172,7 +172,7 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "Unable to prepare clock %p\n", clk);
+		dev_err(&pdev->dev, "Unable to prepare clock %pK\n", clk);
 		return ret;
 	}
 
-- 
2.15.0

