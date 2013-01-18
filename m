Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:38572 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755039Ab3ARLlh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 18 Jan 2013 06:41:37 -0500
Received: by mail-ea0-f175.google.com with SMTP id d1so1411429eab.20
        for <linux-watchdog@vger.kernel.org>; Fri, 18 Jan 2013 03:41:35 -0800 (PST)
From: Fabio Baltieri <fabio.baltieri@linaro.org>
To: linux-watchdog@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Wim Van Sebroeck <wim@iguana.be>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
	Fabio Baltieri <fabio.baltieri@linaro.org>
Subject: [PATCH 4/4] mfd: db8500-prcmu: add ux500_wdt mfd_cell
Date: Fri, 18 Jan 2013 12:40:14 +0100
Message-Id: <1358509214-22407-5-git-send-email-fabio.baltieri@linaro.org>
In-Reply-To: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
References: <1358509214-22407-1-git-send-email-fabio.baltieri@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This patch adds the necessary structures to use the watchdog
functionality of PRCMU.

The watchdog driver is named ux500_wdt.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 drivers/mfd/db8500-prcmu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 7a63fa8..e42a417 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -32,6 +32,7 @@
 #include <linux/regulator/db8500-prcmu.h>
 #include <linux/regulator/machine.h>
 #include <linux/cpufreq.h>
+#include <linux/platform_data/ux500_wdt.h>
 #include <asm/hardware/gic.h>
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -3074,6 +3075,11 @@ static struct resource ab8500_resources[] = {
 	}
 };
 
+static struct ux500_wdt_data db8500_wdt_pdata = {
+	.timeout = 600, /* 10 minutes */
+	.has_28_bits_resolution = true,
+};
+
 static struct mfd_cell db8500_prcmu_devs[] = {
 	{
 		.name = "db8500-prcmu-regulators",
@@ -3088,6 +3094,12 @@ static struct mfd_cell db8500_prcmu_devs[] = {
 		.pdata_size = sizeof(db8500_cpufreq_table),
 	},
 	{
+		.name = "ux500_wdt",
+		.platform_data = &db8500_wdt_pdata,
+		.pdata_size = sizeof(db8500_wdt_pdata),
+		.id = -1,
+	},
+	{
 		.name = "ab8500-core",
 		.of_compatible = "stericsson,ab8500",
 		.num_resources = ARRAY_SIZE(ab8500_resources),
-- 
1.7.12.1

