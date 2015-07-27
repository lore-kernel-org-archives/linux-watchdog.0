Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34969 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbbG0NiU (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 27 Jul 2015 09:38:20 -0400
Received: by wibxm9 with SMTP id xm9so113184126wib.0
        for <linux-watchdog@vger.kernel.org>; Mon, 27 Jul 2015 06:38:19 -0700 (PDT)
From: Matt Fleming <matt@codeblueprint.co.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform data
Date: Mon, 27 Jul 2015 14:38:08 +0100
Message-Id: <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
In-Reply-To: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

From: Matt Fleming <matt.fleming@intel.com>

Intel Sunrisepoint (Skylake PCH) has the iTCO watchdog accessible across
the SMBus, unlike previous generations of PCH/ICH where it was on the
LPC bus. Because it's on the SMBus, it doesn't make sense to pass around
a 'struct lpc_ich_info', and leaking the type of bus into the iTCO
watchdog driver is kind of backwards anyway.

This change introduces a new 'struct iTCO_wdt_platform_data' for use
inside the iTCO watchdog driver and by the upcoming Intel Sunrisepoint
code, which neatly avoids having to include lpc_ich headers in the i801
i2c driver.

A simple translation layer is provided for converting from the existing
'struct lpc_ich_info' inside the lpc_ich mfd driver.

Cc: Peter Tyser <ptyser@xes-inc.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Matt Fleming <matt.fleming@intel.com>
---
 drivers/mfd/lpc_ich.c                  | 32 +++++++++++++++++++++++++++++---
 drivers/watchdog/Kconfig               |  2 +-
 drivers/watchdog/iTCO_wdt.c            | 11 +++++------
 include/linux/mfd/lpc_ich.h            |  6 ------
 include/linux/platform_data/iTCO_wdt.h | 18 ++++++++++++++++++
 5 files changed, 53 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/platform_data/iTCO_wdt.h

diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
index 8de34398abc0..d190b74a6321 100644
--- a/drivers/mfd/lpc_ich.c
+++ b/drivers/mfd/lpc_ich.c
@@ -66,6 +66,7 @@
 #include <linux/pci.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/lpc_ich.h>
+#include <linux/platform_data/iTCO_wdt.h>
 
 #define ACPIBASE		0x40
 #define ACPIBASE_GPE_OFF	0x28
@@ -835,9 +836,31 @@ static void lpc_ich_enable_pmc_space(struct pci_dev *dev)
 	priv->actrl_pbase_save = reg_save;
 }
 
-static void lpc_ich_finalize_cell(struct pci_dev *dev, struct mfd_cell *cell)
+static int lpc_ich_finalize_wdt_cell(struct pci_dev *dev)
 {
+	struct iTCO_wdt_platform_data *pdata;
 	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
+	struct lpc_ich_info *info;
+	struct mfd_cell *cell = &lpc_ich_cells[LPC_WDT];
+
+	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	info = &lpc_chipset_info[priv->chipset];
+
+	pdata->iTCO_version = info->iTCO_version;
+	strcpy(pdata->name, info->name);
+
+	cell->platform_data = pdata;
+	cell->pdata_size = sizeof(*pdata);
+	return 0;
+}
+
+static void lpc_ich_finalize_gpio_cell(struct pci_dev *dev)
+{
+	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
+	struct mfd_cell *cell = &lpc_ich_cells[LPC_GPIO];
 
 	cell->platform_data = &lpc_chipset_info[priv->chipset];
 	cell->pdata_size = sizeof(struct lpc_ich_info);
@@ -933,7 +956,7 @@ gpe0_done:
 	lpc_chipset_info[priv->chipset].use_gpio = ret;
 	lpc_ich_enable_gpio_space(dev);
 
-	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_GPIO]);
+	lpc_ich_finalize_gpio_cell(dev);
 	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
 			      &lpc_ich_cells[LPC_GPIO], 1, NULL, 0, NULL);
 
@@ -1007,7 +1030,10 @@ static int lpc_ich_init_wdt(struct pci_dev *dev)
 		res->end = base_addr + ACPIBASE_PMC_END;
 	}
 
-	lpc_ich_finalize_cell(dev, &lpc_ich_cells[LPC_WDT]);
+	ret = lpc_ich_finalize_wdt_cell(dev);
+	if (ret)
+		goto wdt_done;
+
 	ret = mfd_add_devices(&dev->dev, PLATFORM_DEVID_AUTO,
 			      &lpc_ich_cells[LPC_WDT], 1, NULL, 0, NULL);
 
diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 241fafde42cb..5336fe2ff689 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -797,7 +797,7 @@ config ITCO_WDT
 	tristate "Intel TCO Timer/Watchdog"
 	depends on (X86 || IA64) && PCI
 	select WATCHDOG_CORE
-	select LPC_ICH
+	depends on LPC_ICH || I2C_I801
 	---help---
 	  Hardware driver for the intel TCO timer based watchdog devices.
 	  These drivers are included in the Intel 82801 I/O Controller
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 3c3fd417ddeb..9a6e70976f64 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -66,8 +66,7 @@
 #include <linux/spinlock.h>		/* For spin_lock/spin_unlock/... */
 #include <linux/uaccess.h>		/* For copy_to_user/put_user/... */
 #include <linux/io.h>			/* For inb/outb/... */
-#include <linux/mfd/core.h>
-#include <linux/mfd/lpc_ich.h>
+#include <linux/platform_data/iTCO_wdt.h>
 
 #include "iTCO_vendor.h"
 
@@ -418,9 +417,9 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 {
 	int ret = -ENODEV;
 	unsigned long val32;
-	struct lpc_ich_info *ich_info = dev_get_platdata(&dev->dev);
+	struct iTCO_wdt_platform_data *pdata = dev_get_platdata(&dev->dev);
 
-	if (!ich_info)
+	if (!pdata)
 		goto out;
 
 	spin_lock_init(&iTCO_wdt_private.io_lock);
@@ -435,7 +434,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 	if (!iTCO_wdt_private.smi_res)
 		goto out;
 
-	iTCO_wdt_private.iTCO_version = ich_info->iTCO_version;
+	iTCO_wdt_private.iTCO_version = pdata->iTCO_version;
 	iTCO_wdt_private.dev = dev;
 	iTCO_wdt_private.pdev = to_pci_dev(dev->dev.parent);
 
@@ -501,7 +500,7 @@ static int iTCO_wdt_probe(struct platform_device *dev)
 	}
 
 	pr_info("Found a %s TCO device (Version=%d, TCOBASE=0x%04llx)\n",
-		ich_info->name, ich_info->iTCO_version, (u64)TCOBASE);
+		pdata->name, pdata->iTCO_version, (u64)TCOBASE);
 
 	/* Clear out the (probably old) status */
 	if (iTCO_wdt_private.iTCO_version == 3) {
diff --git a/include/linux/mfd/lpc_ich.h b/include/linux/mfd/lpc_ich.h
index 8feac782fa83..2b300b44f994 100644
--- a/include/linux/mfd/lpc_ich.h
+++ b/include/linux/mfd/lpc_ich.h
@@ -20,12 +20,6 @@
 #ifndef LPC_ICH_H
 #define LPC_ICH_H
 
-/* Watchdog resources */
-#define ICH_RES_IO_TCO		0
-#define ICH_RES_IO_SMI		1
-#define ICH_RES_MEM_OFF		2
-#define ICH_RES_MEM_GCS_PMC	0
-
 /* GPIO resources */
 #define ICH_RES_GPIO	0
 #define ICH_RES_GPE0	1
diff --git a/include/linux/platform_data/iTCO_wdt.h b/include/linux/platform_data/iTCO_wdt.h
new file mode 100644
index 000000000000..ce53c2b01f6d
--- /dev/null
+++ b/include/linux/platform_data/iTCO_wdt.h
@@ -0,0 +1,18 @@
+/*
+ * Platform data for the Intel TCO Watchdog
+ */
+
+#ifndef _ITCO_WDT_H_
+
+/* Watchdog resources */
+#define ICH_RES_IO_TCO		0
+#define ICH_RES_IO_SMI		1
+#define ICH_RES_MEM_OFF		2
+#define ICH_RES_MEM_GCS_PMC	0
+
+struct iTCO_wdt_platform_data {
+	char name[32];
+	unsigned int iTCO_version;
+};
+
+#endif /* _ITCO_WDT_H_ */
-- 
2.1.0

