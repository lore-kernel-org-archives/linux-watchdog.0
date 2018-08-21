Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from outils.crapouillou.net ([89.234.176.41]:33106 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbeHUUiP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 21 Aug 2018 16:38:15 -0400
From: Paul Cercueil <paul@crapouillou.net>
To: Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: od@zcrc.me, Mathieu Malaterre <malat@debian.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v7 15/24] pwm: jz4740: Remove unused devicetree compatible strings
Date: Tue, 21 Aug 2018 19:16:26 +0200
Message-Id: <20180821171635.22740-16-paul@crapouillou.net>
In-Reply-To: <20180821171635.22740-1-paul@crapouillou.net>
References: <20180821171635.22740-1-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Right now none of the Ingenic-based boards probe this driver from
devicetree. This driver defined three compatible strings for the exact
same behaviour. Before these strings are used, we can remove two of
them.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
     v5: New patch
    
     v6: No change
    
     v7: No change

 drivers/pwm/pwm-jz4740.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index d08274ec007f..5814825d9bed 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -235,8 +235,6 @@ static int jz4740_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_pwm_dt_ids[] = {
 	{ .compatible = "ingenic,jz4740-pwm", },
-	{ .compatible = "ingenic,jz4770-pwm", },
-	{ .compatible = "ingenic,jz4780-pwm", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, jz4740_pwm_dt_ids);
-- 
2.11.0
