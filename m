Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46669 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756494Ab3KFLmd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Nov 2013 06:42:33 -0500
Message-ID: <527A28AF.9040308@ti.com>
Date: Wed, 6 Nov 2013 13:31:59 +0200
From: "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>
MIME-Version: 1.0
To: Santosh Shilimkar <santosh.shilimkar@ti.com>, <wim@iguana.be>,
	<nsekhar@ti.com>, <linux-watchdog@vger.kernel.org>,
	<devicetree@vger.kernel.org>
CC: <grant.likely@linaro.org>, <rob.herring@calxeda.com>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<swarren@wwwdotorg.org>, <galak@kernel.crashing.org>,
	<ijc+devicetree@hellion.org.uk>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Fwd: [PATCH 3/8] watchdog: davinci: add GET_TIMELEFT option support
References: <1383680783-12114-4-git-send-email-ivan.khoronzhuk@ti.com>
In-Reply-To: <1383680783-12114-4-git-send-email-ivan.khoronzhuk@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Currently, the davinci watchdog can be read while counting,
so we can add ability to report the remaining time before
the system will reboot.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
---
 drivers/watchdog/davinci_wdt.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 1fc2093..6cbf2e1 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -117,6 +117,33 @@ static int davinci_wdt_ping(struct watchdog_device *wdd)
 	return 0;
 }
 
+static unsigned int davinci_wdt_get_timeleft(struct watchdog_device *wdd)
+{
+	u64 timer_counter;
+	unsigned long freq;
+	u32 val;
+	struct davinci_wdt_device *davinci_wdt = watchdog_get_drvdata(wdd);
+
+	/* if timeout is occured then return 0 */
+	val = ioread32(davinci_wdt->base + WDTCR);
+	if (val & WDFLAG)
+		return 0;
+
+	freq = clk_get_rate(davinci_wdt->clk);
+
+	if (!freq) {
+		dev_err(wdd->dev, "clock freq is not set\n");
+		return 0;
+	}
+
+	timer_counter = ioread32(davinci_wdt->base + TIM12);
+	timer_counter |= ((u64)ioread32(davinci_wdt->base + TIM34) << 32);
+
+	do_div(timer_counter, freq);
+
+	return wdd->timeout - timer_counter;
+}
+
 static const struct watchdog_info davinci_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING,
 	.identity = "DaVinci Watchdog",
@@ -127,6 +154,7 @@ static const struct watchdog_ops davinci_wdt_ops = {
 	.start		= davinci_wdt_start,
 	.stop		= davinci_wdt_ping,
 	.ping		= davinci_wdt_ping,
+	.get_timeleft	= davinci_wdt_get_timeleft,
 };
 
 static int davinci_wdt_probe(struct platform_device *pdev)
-- 
1.7.9.5



