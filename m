Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:34788 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750985AbaKDNXO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Nov 2014 08:23:14 -0500
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Wim Van Sebroeck <wim@iguana.be>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: <linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Jason Cooper <jason@lakedaemon.net>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Nadav Haklai <nadavh@marvell.com>,
	Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH v3 1/3] clocksource: armada-370-xp: Add missing clock enable
Date: Tue,  4 Nov 2014 10:21:31 -0300
Message-Id: <1415107293-19258-2-git-send-email-ezequiel.garcia@free-electrons.com>
In-Reply-To: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1415107293-19258-1-git-send-email-ezequiel.garcia@free-electrons.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This commit makes sure the timer clock is prepared and enabled
before retrieving its rate.

Acked-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/clocksource/time-armada-370-xp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 0451e62..d8555f9 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -293,6 +293,7 @@ static void __init armada_xp_timer_init(struct device_node *np)
 
 	/* The 25Mhz fixed clock is mandatory, and must always be available */
 	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
 	timer_clk = clk_get_rate(clk);
 
 	armada_370_xp_timer_common_init(np);
@@ -305,6 +306,7 @@ static void __init armada_370_timer_init(struct device_node *np)
 	struct clk *clk = of_clk_get(np, 0);
 
 	BUG_ON(IS_ERR(clk));
+	clk_prepare_enable(clk);
 	timer_clk = clk_get_rate(clk) / TIMER_DIVIDER;
 	timer25Mhz = false;
 
-- 
2.1.0

