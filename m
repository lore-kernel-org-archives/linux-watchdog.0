Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drivers/watchdog: ASPEED reference dev tree properties for config
Date: Tue, 27 Jun 2017 16:17:34 -0500
In-Reply-To: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
References: <20170627211734.60477-1-cbostic@linux.vnet.ibm.com>
Message-Id: <20170627211734.60477-3-cbostic@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>

Reference the system device tree when configuring the watchdog
engines.  Set external signal mode on timeout if specified.
Set system reset on timeout if specified.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
v2 - Change of_get_property() to of_property_read_bool()
   - Remove redundant check for NULL struct device_node pointer
   - Optional property names now start with prefix 'aspeed,'
---
 drivers/watchdog/aspeed_wdt.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 1c65258..71ce5f5 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 {
 	struct aspeed_wdt *wdt;
 	struct resource *res;
+	struct device_node *np;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -170,8 +171,16 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 	 * the SOC and not the full chip
 	 */
 	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
-		WDT_CTRL_1MHZ_CLK |
-		WDT_CTRL_RESET_SYSTEM;
+		WDT_CTRL_1MHZ_CLK;
+
+	np = pdev->dev.of_node;
+	if (of_property_read_bool(np, "aspeed,sys-reset"))
+		wdt->ctrl |= WDT_CTRL_RESET_SYSTEM;
+
+	if (of_property_read_bool(np, "aspeed,external-signal"))
+		wdt->ctrl |= WDT_CTRL_WDT_EXT;
+
+	writel(wdt->ctrl, wdt->base + WDT_CTRL);
 
 	if (readl(wdt->base + WDT_CTRL) & WDT_CTRL_ENABLE)  {
 		aspeed_wdt_start(&wdt->wdd);
-- 
1.8.2.2
