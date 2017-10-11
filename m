Return-Path: <chrisp@alliedtelesis.co.nz>
Return-path: <chrisp@alliedtelesis.co.nz>
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: linux@roeck-us.net,
	wim@iguana.be,
	gregory.clement@free-electrons.com,
	devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 2/3] watchdog: orion: don't enable rstout if an interrupt is configured
Date: Wed, 11 Oct 2017 15:29:57 +1300
Message-Id: <20171011022958.31268-3-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
List-ID: <linux-watchdog@vger.kernel.org>

The orion_wdt_irq invokes panic() so we are going to reset the CPU
regardless.  By not setting this bit we get a chance to gather debug
from the panic output before the system is reset.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/watchdog/orion_wdt.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ea676d233e1e..ce88f339ef7f 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -71,6 +71,7 @@ struct orion_watchdog {
 	unsigned long clk_rate;
 	struct clk *clk;
 	const struct orion_watchdog_data *data;
+	int irq;
 };
 
 static int orion_wdt_clock_init(struct platform_device *pdev,
@@ -203,9 +204,11 @@ static int armada375_start(struct watchdog_device *wdt_dev)
 						dev->data->wdt_enable_bit);
 
 	/* Enable reset on watchdog */
-	reg = readl(dev->rstout);
-	reg |= dev->data->rstout_enable_bit;
-	writel(reg, dev->rstout);
+	if (!dev->irq) {
+		reg = readl(dev->rstout);
+		reg |= dev->data->rstout_enable_bit;
+		writel(reg, dev->rstout);
+	}
 
 	atomic_io_modify(dev->rstout_mask, dev->data->rstout_mask_bit, 0);
 	return 0;
@@ -228,9 +231,12 @@ static int armada370_start(struct watchdog_device *wdt_dev)
 						dev->data->wdt_enable_bit);
 
 	/* Enable reset on watchdog */
-	reg = readl(dev->rstout);
-	reg |= dev->data->rstout_enable_bit;
-	writel(reg, dev->rstout);
+	if (!dev->irq) {
+		reg = readl(dev->rstout);
+		reg |= dev->data->rstout_enable_bit;
+		writel(reg, dev->rstout);
+	}
+
 	return 0;
 }
 
@@ -247,8 +253,9 @@ static int orion_start(struct watchdog_device *wdt_dev)
 						dev->data->wdt_enable_bit);
 
 	/* Enable reset on watchdog */
-	atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
-				      dev->data->rstout_enable_bit);
+	if (!dev->irq)
+		atomic_io_modify(dev->rstout, dev->data->rstout_enable_bit,
+					      dev->data->rstout_enable_bit);
 
 	return 0;
 }
@@ -595,6 +602,8 @@ static int orion_wdt_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to request IRQ\n");
 			goto disable_clk;
 		}
+
+		dev->irq = irq;
 	}
 
 	watchdog_set_nowayout(&dev->wdt, nowayout);
-- 
2.14.2
