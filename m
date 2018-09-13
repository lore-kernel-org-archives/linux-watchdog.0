Return-Path: <hauke@hauke-m.de>
Return-path: <hauke@hauke-m.de>
From: Hauke Mehrtens <hauke@hauke-m.de>
To: wim@linux-watchdog.org,
	linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org,
	john@phrozen.org,
	dev@kresin.me,
	Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 3/3] wdt: lantiq: add get_timeleft callback
Date: Thu, 13 Sep 2018 23:32:11 +0200
Message-Id: <20180913213211.16781-4-hauke@hauke-m.de>
In-Reply-To: <20180913213211.16781-1-hauke@hauke-m.de>
References: <20180913213211.16781-1-hauke@hauke-m.de>
List-ID: <linux-watchdog@vger.kernel.org>

This callback will provide the current time left.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/watchdog/lantiq_wdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index c2f14d2bd695..83da84d6074b 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -50,6 +50,7 @@
 #define  LTQ_WDT_CR_MAX_TIMEOUT	((1 << 16) - 1)	/* The reload field is 16 bit */
 #define LTQ_WDT_SR		0x8		/* watchdog status register */
 #define  LTQ_WDT_SR_EN		BIT(31)		/* Enable */
+#define  LTQ_WDT_SR_VALUE_MASK	GENMASK(15, 0)	/* Timer value */
 
 #define LTQ_WDT_DIVIDER		0x40000
 
@@ -139,11 +140,21 @@ static int ltq_wdt_ping(struct watchdog_device *wdt)
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
 
 static int ltq_wdt_xrx_bootstatus_get(struct device *dev)
-- 
2.11.0
