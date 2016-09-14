Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@stlinux.com, patrice.chotard@st.com, devicetree@vger.kernel.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, <wim@iguana.be>,
        <linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>
Subject: [PATCH 11/19] watchdog: st_wdt: Remove support for obsolete platforms
Date: Wed, 14 Sep 2016 14:27:49 +0100
Message-Id: <1473859677-9231-12-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
References: <1473859677-9231-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

STiH415/6 SoC support is being removed from the kernel.
This patch updates the watchdog driver to remove references
to these obsolete platforms.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Cc: <wim@iguana.be>
Cc: <linux@roeck-us.net>
Cc: <linux-watchdog@vger.kernel.org>
---
 drivers/watchdog/st_lpc_wdt.c | 33 ---------------------------------
 1 file changed, 33 deletions(-)

diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index 14e9bad..e6100e4 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -52,27 +52,6 @@ struct st_wdog {
 	bool warm_reset;
 };
 
-static struct st_wdog_syscfg stid127_syscfg = {
-	.reset_type_reg		= 0x004,
-	.reset_type_mask	= BIT(2),
-	.enable_reg		= 0x000,
-	.enable_mask		= BIT(2),
-};
-
-static struct st_wdog_syscfg stih415_syscfg = {
-	.reset_type_reg		= 0x0B8,
-	.reset_type_mask	= BIT(6),
-	.enable_reg		= 0x0B4,
-	.enable_mask		= BIT(7),
-};
-
-static struct st_wdog_syscfg stih416_syscfg = {
-	.reset_type_reg		= 0x88C,
-	.reset_type_mask	= BIT(6),
-	.enable_reg		= 0x888,
-	.enable_mask		= BIT(7),
-};
-
 static struct st_wdog_syscfg stih407_syscfg = {
 	.enable_reg		= 0x204,
 	.enable_mask		= BIT(19),
@@ -83,18 +62,6 @@ static const struct of_device_id st_wdog_match[] = {
 		.compatible = "st,stih407-lpc",
 		.data = &stih407_syscfg,
 	},
-	{
-		.compatible = "st,stih416-lpc",
-		.data = &stih416_syscfg,
-	},
-	{
-		.compatible = "st,stih415-lpc",
-		.data = &stih415_syscfg,
-	},
-	{
-		.compatible = "st,stid127-lpc",
-		.data = &stid127_syscfg,
-	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, st_wdog_match);
-- 
1.9.1
