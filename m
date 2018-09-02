Return-Path: <hauke@hauke-m.de>
Return-path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	john@phrozen.org,
	dev@kresin.me,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v2 3/3] wdt: lantiq: add get_timeleft callback
Date: Sun,  2 Sep 2018 13:32:33 +0200
Message-Id: <20180902113233.29113-4-hauke@hauke-m.de>
In-Reply-To: <20180902113233.29113-1-hauke@hauke-m.de>
References: <20180902113233.29113-1-hauke@hauke-m.de>
List-ID: <linux-watchdog@vger.kernel.org>

This callback will provide the current time left.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/lantiq_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 666db382b824..3aac61ef855a 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -46,6 +46,8 @@
 #define  LTQ_WDT_CR_CLKDIV	(0x3 << 24)	/* set clock divider to 0x40000 */
 #define  LTQ_WDT_CR_PW_MASK	GENMASK(23, 16)	/* Password field */
 #define  LTQ_WDT_CR_RELOAD_MASK	GENMASK(15, 0)	/* Reload value */
+#define LTQ_WDT_SR		0x8		/* watchdog status register */
+#define  LTQ_WDT_SR_VALUE_MASK	GENMASK(15, 0)	/* Timer value */
 
 #define LTQ_WDT_DIVIDER		0x40000
 
@@ -135,11 +137,21 @@ static int ltq_wdt_ping(struct watchdog_device *wdt)
 	return 0;
 }
 
+static unsigned int ltq_wdt_get_timeleft(struct watchdog_device *wdt)
+{
+	struct ltq_wdt_priv *priv = ltq_wdt_get_priv(wdt);
+	u64 timeout;
+
+	timeout = ltq_wdt_r32(priv, LTQ_WDT_SR) & LTQ_WDT_SR_VALUE_MASK;
+	return do_div(timeout, priv->clk_rate);
+}
+
 static const struct watchdog_ops ltq_wdt_ops = {
 	.owner		= THIS_MODULE,
 	.start		= ltq_wdt_start,
 	.stop		= ltq_wdt_stop,
 	.ping		= ltq_wdt_ping,
+	.get_timeleft	= ltq_wdt_get_timeleft,
 };
 
 static int ltq_wdt_bootstatus_xrx(struct device *dev)
-- 
2.11.0
