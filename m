Return-path: <alexandre.belloni@free-electrons.com>
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Wenyou.Yang@microchip.com,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 3/4] watchodg: sama5d4: simplify probe
Date: Thu,  2 Mar 2017 18:31:13 +0100
Message-Id: <20170302173114.28508-4-alexandre.belloni@free-electrons.com>
In-Reply-To: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
References: <20170302173114.28508-1-alexandre.belloni@free-electrons.com>
List-ID: <linux-watchdog@vger.kernel.org>

Because the only way to use the driver is to have a device tree enabling
it, pdev->dev.of_node will never be NULL. Remove the unnecessary check.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/watchdog/sama5d4_wdt.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 362fd229786d..d710014f3b7d 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -228,15 +228,13 @@ static int sama5d4_wdt_probe(struct platform_device *pdev)
 
 	wdt->reg_base = regs;
 
-	if (pdev->dev.of_node) {
-		irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
-		if (!irq)
-			dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
+	irq = irq_of_parse_and_map(pdev->dev.of_node, 0);
+	if (!irq)
+		dev_warn(&pdev->dev, "failed to get IRQ from DT\n");
 
-		ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
-		if (ret)
-			return ret;
-	}
+	ret = of_sama5d4_wdt_init(pdev->dev.of_node, wdt);
+	if (ret)
+		return ret;
 
 	if ((wdt->mr & AT91_WDT_WDFIEN) && irq) {
 		ret = devm_request_irq(&pdev->dev, irq, sama5d4_wdt_irq_handler,
-- 
2.11.0
