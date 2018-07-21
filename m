Return-Path: <hauke@hauke-m.de>
Return-path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	john@phrozen.org,
	dev@kresin.me,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 3/3] wdt: lantiq: add get_timeleft callback
Date: Sun, 22 Jul 2018 01:26:35 +0200
Message-Id: <20180721232635.10523-3-hauke@hauke-m.de>
In-Reply-To: <20180721232635.10523-1-hauke@hauke-m.de>
References: <20180721232635.10523-1-hauke@hauke-m.de>
List-ID: <linux-watchdog@vger.kernel.org>

This callback will provide the current time left.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/lantiq_wdt.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 5cc02849f599..13eada1bbb68 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -135,11 +135,21 @@ static int ltq_wdt_ping(struct watchdog_device *wdt)
 	return 0;
 }
 
+unsigned int ltq_wdt_get_timeleft(struct watchdog_device *wdt)
+{
+	struct ltq_wdt_priv *priv = ltq_wdt_get_priv(wdt);
+	u64 timeout;
+
+	timeout = ltq_wdt_r32(priv, LTQ_WDT_SR) & LTQ_WDT_SR_VALUE_MASK;
+	return do_div(timeout, priv->clk_rate / LTQ_WDT_DIVIDER);
+}
+
 static const struct watchdog_ops ltq_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= ltq_wdt_start,
 	.stop		= ltq_wdt_stop,
 	.ping		= ltq_wdt_ping,
+	.get_timeleft	= ltq_wdt_get_timeleft,
 };
 
 typedef int (*ltq_wdt_bootstatus_get)(struct platform_device *pdev);
-- 
2.11.0
