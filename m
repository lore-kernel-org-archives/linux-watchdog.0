Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.138]:19839 "EHLO
        mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966623AbcJFJJf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Oct 2016 05:09:35 -0400
Message-ID: <cb234a7d84a8a82d6da8ea7e80f48cdee02b9de2.1475743411.git.stwiss.opensource@diasemi.com>
In-Reply-To: <cover.1475743411.git.stwiss.opensource@diasemi.com>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
From: Steve Twiss <stwiss.opensource@diasemi.com>
Date: Thu, 6 Oct 2016 09:43:30 +0100
Subject: [PATCH V1 04/10] watchdog: da9061: watchdog driver
To: Guenter Roeck <linux@roeck-us.net>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
CC: DEVICETREE <devicetree@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        LINUX-INPUT <linux-input@vger.kernel.org>,
        LINUX-PM <linux-pm@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Zhang Rui <rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Steve Twiss <stwiss.opensource@diasemi.com>

Support for the DA9061 watchdog is added into the DA9062 watchdog driver.

The of_device_id match array is expanded to support "dlg,da9061-watchdog"
as a valid .compatible string. A new watchdog_info structure is added and
linked to this device tree compatible string in the .data section. Extra
code is added into the probe function to search-for and assign this match
data.

Copyright header is updated to add DA9061 in its description and the module
description macro is extended to include DA9061.

Kconfig is updated to reflect support for DA9061/62.

Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

---
This patch applies against linux-next and v4.8

Regards,
Steve Twiss, Dialog Semiconductor Ltd.


 drivers/watchdog/Kconfig      |  4 ++--
 drivers/watchdog/da9062_wdt.c | 24 +++++++++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 1bffe00..d6b4088 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -104,11 +104,11 @@ config DA9063_WATCHDOG
 	  This driver can be built as a module. The module name is da9063_wdt.
 
 config DA9062_WATCHDOG
-	tristate "Dialog DA9062 Watchdog"
+	tristate "Dialog DA9062/61 Watchdog"
 	depends on MFD_DA9062
 	select WATCHDOG_CORE
 	help
-	  Support for the watchdog in the DA9062 PMIC.
+	  Support for the watchdog in the DA9062 and DA9061 PMICs.
 
 	  This driver can be built as a module. The module name is da9062_wdt.
 
diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 7386111..5b9d408 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -1,5 +1,5 @@
 /*
- * da9062_wdt.c - WDT device driver for DA9062
+ * Watchdog device driver for DA9062 and DA9061 PMICs
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  *
  * This program is free software; you can redistribute it and/or
@@ -180,6 +180,11 @@ static const struct watchdog_info da9062_watchdog_info = {
 	.identity = "DA9062 WDT",
 };
 
+static const struct watchdog_info da9061_watchdog_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
+	.identity = "DA9061 WDT",
+};
+
 static const struct watchdog_ops da9062_watchdog_ops = {
 	.owner = THIS_MODULE,
 	.start = da9062_wdt_start,
@@ -188,23 +193,35 @@ static const struct watchdog_ops da9062_watchdog_ops = {
 	.set_timeout = da9062_wdt_set_timeout,
 };
 
+static const struct of_device_id da9062_compatible_id_table[] = {
+	{ .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
+	{ .compatible = "dlg,da9061-watchdog", .data = &da9061_watchdog_info },
+	{ },
+};
+
 static int da9062_wdt_probe(struct platform_device *pdev)
 {
 	int ret;
 	struct da9062 *chip;
 	struct da9062_watchdog *wdt;
+	const struct of_device_id *match;
 
 	chip = dev_get_drvdata(pdev->dev.parent);
 	if (!chip)
 		return -EINVAL;
 
+	match = of_match_node(da9062_compatible_id_table,
+			      pdev->dev.of_node);
+	if (!match)
+		return -ENXIO;
+
 	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
 	if (!wdt)
 		return -ENOMEM;
 
 	wdt->hw = chip;
 
-	wdt->wdtdev.info = &da9062_watchdog_info;
+	wdt->wdtdev.info = (const struct watchdog_info *)match->data;
 	wdt->wdtdev.ops = &da9062_watchdog_ops;
 	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
 	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
@@ -244,11 +261,12 @@ static struct platform_driver da9062_wdt_driver = {
 	.remove = da9062_wdt_remove,
 	.driver = {
 		.name = "da9062-watchdog",
+		.of_match_table = da9062_compatible_id_table,
 	},
 };
 module_platform_driver(da9062_wdt_driver);
 
 MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
-MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
+MODULE_DESCRIPTION("WDT device driver for Dialog DA9062 and DA9061");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:da9062-watchdog");
-- 
end-of-patch for PATCH V1

