Return-Path: <cbostic@linux.vnet.ibm.com>
Return-path: <cbostic@linux.vnet.ibm.com>
From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
To: wim@iguana.be, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, joel@jms.id.au, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Subject: [PATCH v3 2/2] drivers/watchdog: ASPEED reference dev tree properties for config
Date: Wed, 28 Jun 2017 19:28:11 -0500
In-Reply-To: <20170629002811.87199-1-cbostic@linux.vnet.ibm.com>
References: <20170629002811.87199-1-cbostic@linux.vnet.ibm.com>
Message-Id: <20170629002811.87199-3-cbostic@linux.vnet.ibm.com>
List-ID: <linux-watchdog@vger.kernel.org>

Reference the system device tree when configuring the watchdog
engines. If optional property 'aspeed,no-sys-reset' is specified
then override the default config and do not set sys reset mode.
If optional property 'aspeed,no-soc-reset' is specified then
override the default and do not set soc reset mode.

Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
v3 - Invert the logic for system reset dev tree property to
     preserve backwards compatibility. If not specified the
     default is to configure for system reset
   - Add check for 'aspeed,no-soc-reset' property and only if
     not present is SOC reset to be configured.  This preserves
     backwards compatibility.
v2 - Change of_get_property() to of_property_read_bool()
   - Remove redundant check for NULL struct device_node pointer
   - Optional property names now start with prefix 'aspeed,'
---
 drivers/watchdog/aspeed_wdt.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index 1c65258..ace74f8 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -140,6 +140,7 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 {
 	struct aspeed_wdt *wdt;
 	struct resource *res;
+	struct device_node *np;
 	int ret;
 
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
@@ -166,12 +167,21 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
 
 	/*
 	 * Control reset on a per-device basis to ensure the
-	 * host is not affected by a BMC reboot, so only reset
-	 * the SOC and not the full chip
+	 * host is not affected by a BMC reboot
 	 */
-	wdt->ctrl = WDT_CTRL_RESET_MODE_SOC |
-		WDT_CTRL_1MHZ_CLK |
-		WDT_CTRL_RESET_SYSTEM;
+	wdt->ctrl = WDT_CTRL_1MHZ_CLK;
+
+	np = pdev->dev.of_node;
+	if (!(of_property_read_bool(np, "aspeed,no-soc-reset")))
+		wdt->ctrl |= WDT_CTRL_RESET_MODE_SOC;
+
+	if (!(of_property_read_bool(np, "aspeed,no-sys-reset")))
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
