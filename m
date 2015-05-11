Return-path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-watchdog@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Wim
 Van Sebroeck <wim@iguana.be>
CC: Andrew Bresticker <abrestic@chromium.org>, James Hogan
	<james.hogan@imgtec.com>, James Hartley <james.hartley@imgtec.com>, "Naidu
 Tellapati" <naidu.tellapati@imgtec.com>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH 1/2] watchdog: imgpdc: Fix max timeout
Date: Mon, 11 May 2015 14:41:04 -0300
Message-ID: <1431366065-16281-2-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1431366065-16281-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-watchdog@vger.kernel.org>

Maximum timeout is currently set in clock cycles, but the watchdog
core expects it to be in seconds. Fix it.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/watchdog/imgpdc_wdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 28c10e2..56b8ebc 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -152,6 +152,7 @@ static int pdc_wdt_restart(struct notifier_block *this, unsigned long mode,
 
 static int pdc_wdt_probe(struct platform_device *pdev)
 {
+	u64 div;
 	int ret, val;
 	unsigned long clk_rate;
 	struct resource *res;
@@ -211,7 +212,10 @@ static int pdc_wdt_probe(struct platform_device *pdev)
 
 	pdc_wdt->wdt_dev.info = &pdc_wdt_info;
 	pdc_wdt->wdt_dev.ops = &pdc_wdt_ops;
-	pdc_wdt->wdt_dev.max_timeout = 1 << PDC_WDT_CONFIG_DELAY_MASK;
+
+	div = 1ULL << (PDC_WDT_CONFIG_DELAY_MASK + 1);
+	do_div(div, clk_rate);
+	pdc_wdt->wdt_dev.max_timeout = div;
 	pdc_wdt->wdt_dev.timeout = PDC_WDT_DEF_TIMEOUT;
 	pdc_wdt->wdt_dev.parent = &pdev->dev;
 	watchdog_set_drvdata(&pdc_wdt->wdt_dev, pdc_wdt);
-- 
2.3.3
