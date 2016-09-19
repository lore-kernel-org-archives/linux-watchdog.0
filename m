Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:53489 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbcISTUC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 15:20:02 -0400
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 1/4] clk: pxa25x: OSTIMER0 clocks from the main oscillator
Date: Mon, 19 Sep 2016 21:12:12 +0200
Message-Id: <1474312335-20997-2-git-send-email-robert.jarzmik@free.fr>
In-Reply-To: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
References: <1474312335-20997-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Russell King - ARM Linux <linux@armlinux.org.uk>

The OSTIMER0 clock ticks at the main oscillator rate, not the 32kHz
oscillator rate.  Ensure that it is parented to the main oscillator.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa25x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index a98b98e2a9e4..56b0a6027e38 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -230,7 +230,7 @@ static struct dummy_clk dummy_clks[] __initdata = {
 	DUMMY_CLK("GPIO11_CLK", NULL, "osc_3_6864mhz"),
 	DUMMY_CLK("GPIO12_CLK", NULL, "osc_32_768khz"),
 	DUMMY_CLK(NULL, "sa1100-rtc", "osc_32_768khz"),
-	DUMMY_CLK("OSTIMER0", NULL, "osc_32_768khz"),
+	DUMMY_CLK("OSTIMER0", NULL, "osc_3_6864mhz"),
 	DUMMY_CLK("UARTCLK", "pxa2xx-ir", "STUART"),
 };
 
-- 
2.1.4

