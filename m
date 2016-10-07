Return-path: <pantelis.antoniou@konsulko.com>
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Peter Rosin <peda@axentia.se>,
	Debjit Ghosh <dghosh@juniper.net>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <groeck@juniper.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: [PATCH 01/10] mfd: Juniper PTXPMB CPLD Multi-function core driver
Date: Fri,  7 Oct 2016 18:17:22 +0300
Message-Id: <1475853451-22121-2-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Guenter Roeck <groeck@juniper.net>

Add Juniper's PTXPMB FPGA CPLD driver. Those FPGAs
are present in Juniper's PTX series of routers.

There are two variants, the original which is found on the
PTXPMB_P2020, PTXPMB_P2020_SPMB based on a Freescale P2020 SoC,
and PTXPMB_P5040 based on a Freescale P5040 SoC.

The new variant NGPMB is present on a new line of x86 based
boards (currently only the Gladiator FPC).

Both variants provide a hardware watchdog, i2c mux and a
gpio block, with the i2c mux block being different.

Signed-off-by: Debjit Ghosh <dghosh@juniper.net>
Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
Signed-off-by: Guenter Roeck <groeck@juniper.net>
Signed-off-by: JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>
Signed-off-by: Rajat Jain <rajatjain@juniper.net>
Signed-off-by: Tom Kavanagh <tkavanagh@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/mfd/Kconfig             |  15 ++
 drivers/mfd/Makefile            |   1 +
 drivers/mfd/ptxpmb-cpld-core.c  | 406 ++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/ptxpmb_cpld.h | 140 ++++++++++++++
 4 files changed, 562 insertions(+)
 create mode 100644 drivers/mfd/ptxpmb-cpld-core.c
 create mode 100644 include/linux/mfd/ptxpmb_cpld.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2caf7e9..438666a 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1340,6 +1340,21 @@ config TWL4030_POWER
 	  and load scripts controlling which resources are switched off/on
 	  or reset when a sleep, wakeup or warm reset event occurs.
 
+config MFD_JUNIPER_CPLD
+	tristate "Juniper PTX PMB CPLD"
+	depends on (PTXPMB_COMMON || JNX_PTX_NGPMB)
+	default y if (PTXPMB_COMMON || JNX_PTX_NGPMB)
+	select MFD_CORE
+	select I2C_MUX_PTXPMB
+	select GPIO_PTXPMB_CPLD
+	select JNX_PTXPMB_WDT
+	help
+	  Select this to enable the PTX PMB CPLD multi-function kernel driver
+	  for the applicable Juniper platforms.
+
+	  This driver can be built as a module. If built as a module it will be
+	  called "ptxpmb-cpld"
+
 config MFD_TWL4030_AUDIO
 	bool "TI TWL4030 Audio"
 	depends on TWL4030_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2bf6a1a..62decc9 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -148,6 +148,7 @@ obj-$(CONFIG_AB3100_CORE)	+= ab3100-core.o
 obj-$(CONFIG_AB3100_OTP)	+= ab3100-otp.o
 obj-$(CONFIG_AB8500_DEBUG)	+= ab8500-debugfs.o
 obj-$(CONFIG_AB8500_GPADC)	+= ab8500-gpadc.o
+obj-$(CONFIG_MFD_JUNIPER_CPLD)	+= ptxpmb-cpld-core.o
 obj-$(CONFIG_MFD_DB8500_PRCMU)	+= db8500-prcmu.o
 # ab8500-core need to come after db8500-prcmu (which provides the channel)
 obj-$(CONFIG_AB8500_CORE)	+= ab8500-core.o ab8500-sysctrl.o
diff --git a/drivers/mfd/ptxpmb-cpld-core.c b/drivers/mfd/ptxpmb-cpld-core.c
new file mode 100644
index 0000000..18e60a4
--- /dev/null
+++ b/drivers/mfd/ptxpmb-cpld-core.c
@@ -0,0 +1,406 @@
+/*
+ * Juniper PTX PMB CPLD multi-function core driver
+ *
+ * Copyright (C) 2012 Juniper Networks
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/dmi.h>
+#include <linux/mfd/core.h>
+#include <linux/of_device.h>
+#include <linux/mfd/ptxpmb_cpld.h>
+#include <linux/jnx/jnx-subsys.h>
+#include <linux/jnx/board_ids.h>
+
+struct pmb_cpld_core {
+	struct device		*dev;
+	struct pmb_boot_cpld __iomem *cpld;
+	spinlock_t		lock;
+	int			irq;
+	wait_queue_head_t	wqh;
+};
+
+static const struct of_device_id pmb_cpld_of_ids[] = {
+	{ .compatible = "jnx,ptxpmb-cpld", .data = (void *)CPLD_TYPE_PTXPMB },
+	{ .compatible = "jnx,ngpmb-bcpld", .data = (void *)CPLD_TYPE_NGPMB },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, pmb_cpld_of_ids);
+
+static struct dmi_system_id gld_2t_dmi_data[] = {
+	{
+		.ident = "Juniper Networks Gladiator 2T FPC",
+		.matches = {
+			    DMI_MATCH(DMI_SYS_VENDOR, "Juniper Networks Inc."),
+			    DMI_MATCH(DMI_PRODUCT_NAME, "0BF9"),
+			},
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(dmi, gld_2t_dmi_data);
+
+static struct dmi_system_id gld_3t_dmi_data[] = {
+	{
+		.ident = "Juniper Networks Gladiator 3T FPC",
+		.matches = {
+			    DMI_MATCH(DMI_SYS_VENDOR, "Juniper Networks Inc."),
+			    DMI_MATCH(DMI_PRODUCT_NAME, "0BFA"),
+			},
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(dmi, gld_3t_dmi_data);
+
+static int ptxpmb_cpld_get_master(void *data)
+{
+	struct pmb_cpld_core *cpld = data;
+	u8 s1;
+
+	s1 = ioread8(&cpld->cpld->i2c_host_sel) & CPLD_I2C_HOST_MSTR_MASK;
+
+	if ((s1 & CPLD_I2C_HOST0_MSTR) == CPLD_I2C_HOST0_MSTR)
+		return 0;
+
+	if ((s1 & CPLD_I2C_HOST1_MSTR) == CPLD_I2C_HOST1_MSTR)
+		return 1;
+
+	return -1;
+}
+
+static int ngpmb_cpld_get_master(void *data)
+{
+	struct pmb_cpld_core *cpld = data;
+
+	if (ioread8(&cpld->cpld->baseboard_status1) & NGPMB_MASTER_SELECT)
+		return 1;
+	else
+		return 0;
+}
+
+static irqreturn_t pmb_cpld_core_interrupt(int irq, void *dev_data)
+{
+	struct pmb_cpld_core *cpld = dev_data;
+
+	pr_info("pmb_cpld_core_interrupt %d\n", irq);
+
+	spin_lock(&cpld->wqh.lock);
+
+	/* clear interrupt, wake up any handlers */
+	wake_up_locked(&cpld->wqh);
+
+	spin_unlock(&cpld->wqh.lock);
+
+	return IRQ_HANDLED;
+}
+
+static struct resource pmb_cpld_resources[] = {
+	{
+		.start	= 0,
+		.end	= sizeof(struct pmb_boot_cpld) - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct mfd_cell pmb_cpld_cells[] = {
+	{
+		.name = "jnx-ptxpmb-wdt",
+		.num_resources = ARRAY_SIZE(pmb_cpld_resources),
+		.resources = pmb_cpld_resources,
+		.of_compatible = "jnx,ptxpmb-wdt",
+	},
+	{
+		.name = "i2c-mux-ptxpmb-cpld",
+		.num_resources = ARRAY_SIZE(pmb_cpld_resources),
+		.resources = pmb_cpld_resources,
+		.of_compatible = "jnx,i2c-mux-ptxpmb-cpld",
+	},
+	{
+		.name = "gpio-ptxpmb-cpld",
+		.num_resources = ARRAY_SIZE(pmb_cpld_resources),
+		.resources = pmb_cpld_resources,
+		.of_compatible = "jnx,gpio-ptxpmb-cpld",
+	},
+};
+
+static struct mfd_cell ngpmb_cpld_cells[] = {
+	{
+		.name = "jnx-ptxpmb-wdt",
+		.num_resources = ARRAY_SIZE(pmb_cpld_resources),
+		.resources = pmb_cpld_resources,
+		.of_compatible = "jnx,ptxpmb-wdt",
+	},
+	{
+		.name = "i2c-mux-ngpmb-bcpld",
+		.num_resources = ARRAY_SIZE(pmb_cpld_resources),
+		.resources = pmb_cpld_resources,
+		.of_compatible = "jnx,i2c-mux-ngpmb-bcpld",
+	},
+	{
+		.name = "gpio-ptxpmb-cpld",
+		.num_resources = ARRAY_SIZE(pmb_cpld_resources),
+		.resources = pmb_cpld_resources,
+		.of_compatible = "jnx,gpio-ptxpmb-cpld",
+	},
+};
+
+static void cpld_ngpmb_init(struct pmb_cpld_core *cpld,
+			    struct jnx_chassis_info *chinfo,
+			    struct jnx_card_info *cinfo)
+{
+	u8 s1, s2, val, chassis;
+
+	s1 = ioread8(&cpld->cpld->baseboard_status1);
+	s2 = ioread8(&cpld->cpld->baseboard_status2);
+	chassis = (ioread8(&cpld->cpld->board.ngpmb.chassis_type)
+		   & NGPMB_CHASSIS_TYPE_MASK) >> NGPMB_CHASSIS_TYPE_LSB;
+
+	dev_info(cpld->dev, "Revision 0x%02X chassis type %s (0x%02X)\n",
+		 ioread8(&cpld->cpld->cpld_rev),
+		 chassis == NGPMB_CHASSIS_TYPE_POLARIS ? "PTX-1000" :
+		 chassis == NGPMB_CHASSIS_TYPE_HENDRICKS ? "PTX-3000" :
+		 "Unknown", chassis);
+
+	/* Only the Gladiator 2t/3t FPC */
+	if (dmi_check_system(gld_2t_dmi_data) ||
+	    dmi_check_system(gld_3t_dmi_data)) {
+		/* Take SAM FPGA out of reset */
+		val = ioread8(&cpld->cpld->gpio_2);
+		iowrite8(val | NGPMB_GPIO2_TO_BASEBRD_LSB, &cpld->cpld->gpio_2);
+		mdelay(10);
+	} else {
+		/*
+		 * Get the PAM FPGA out of reset,
+		 * and wait for 100ms as per HW manual
+		 */
+		val = ioread8(&cpld->cpld->reset);
+		iowrite8(val & ~NGPMB_PCIE_OTHER_RESET, &cpld->cpld->reset);
+		mdelay(100);
+	}
+
+	/* No Card / Chassis info needed in stand alone mode */
+	if (!(s1 & NGPMB_PMB_STANDALONE) || !(s1 & NGPMB_BASEBRD_STANDALONE))
+		return;
+
+	cinfo->type = JNX_BOARD_TYPE_FPC;
+	cinfo->slot = (s1 & NGPMB_BASEBRD_SLOT_MASK) >> NGPMB_BASEBRD_SLOT_LSB;
+
+	if (((s2 & NGPMB_BASEBRD_TYPE_MASK) >> NGPMB_BASEBRD_TYPE_LSB) !=
+	    NGPMB_BASEBRD_TYPE_MX) {
+		if (dmi_check_system(gld_2t_dmi_data))
+			cinfo->assembly_id = JNX_ID_GLD_2T_FPC;
+		else if (dmi_check_system(gld_3t_dmi_data))
+			cinfo->assembly_id = JNX_ID_GLD_3T_FPC;
+		else
+			cinfo->assembly_id = JNX_ID_POLARIS_MLC;
+	}
+
+	/*
+	 * Multi chassis configuration. These bits are not
+	 * valid for Gladiator.
+	 */
+	if (!(dmi_check_system(gld_2t_dmi_data) ||
+	      dmi_check_system(gld_3t_dmi_data))) {
+		if (ioread8(&cpld->cpld->board.ngpmb.sys_config) &
+		    NGPMB_SYS_CONFIG_MULTI_CHASSIS) {
+			chinfo->multichassis = 1;
+			chinfo->chassis_no =
+			ioread8(&cpld->cpld->board.ngpmb.chassis_id);
+		}
+	}
+
+	switch (chassis) {
+	case NGPMB_CHASSIS_TYPE_POLARIS:
+		chinfo->platform = JNX_PRODUCT_POLARIS;
+		break;
+	case NGPMB_CHASSIS_TYPE_HENDRICKS:
+		chinfo->platform = JNX_PRODUCT_HENDRICKS;
+		break;
+	default:
+		chinfo->platform = 0;
+		break;
+	};
+	chinfo->get_master = ngpmb_cpld_get_master;
+}
+
+static void cpld_ptxpmb_init(struct pmb_cpld_core *cpld,
+			     struct jnx_chassis_info *chinfo,
+			     struct jnx_card_info *cinfo)
+{
+	u8 s1, s2;
+
+	s1 = ioread8(&cpld->cpld->baseboard_status1);
+	s2 = ioread8(&cpld->cpld->baseboard_status2);
+
+	dev_info(cpld->dev, "Revision 0x%02x carrier type 0x%x [%s]\n",
+		 ioread8(&cpld->cpld->cpld_rev), s2 & 0x1f,
+		 (s1 & 0X3F) == 0X1F ? "standalone"
+				     : (s2 & 0x10) ? "FPC" : "SPMB");
+
+	if ((s1 & 0x3f) != 0x1f) {	/* not standalone */
+		cinfo->slot = s1 & 0x0f;
+		if (s2 & 0x10) {	/* fpc */
+			cinfo->type = JNX_BOARD_TYPE_FPC;
+			switch (s2 & 0x0f) {
+			case 0x00:	/* Sangria */
+				cinfo->assembly_id = JNX_ID_SNG_VDV_BASE_P2;
+				chinfo->platform = JNX_PRODUCT_SANGRIA;
+				break;
+			case 0x01:	/* Tiny */
+				chinfo->platform = JNX_PRODUCT_TINY;
+				break;
+			case 0x02:	/* Hercules */
+				chinfo->platform = JNX_PRODUCT_HERCULES;
+				break;
+			case 0x03:      /* Hendricks */
+				cinfo->assembly_id = JNX_ID_HENDRICKS_FPC_P2;
+				chinfo->platform = JNX_PRODUCT_HENDRICKS;
+				break;
+			default:	/* unknown */
+				break;
+			}
+		} else {		/* spmb */
+			cinfo->type = JNX_BOARD_TYPE_SPMB;
+			switch (s2 & 0x0f) {
+			case 0x00:	/* Sangria */
+				cinfo->assembly_id = JNX_ID_SNG_PMB;
+				chinfo->platform = JNX_PRODUCT_SANGRIA;
+				break;
+			default:	/* unknown */
+				break;
+			}
+		}
+	}
+	chinfo->get_master = ptxpmb_cpld_get_master;
+}
+
+static int pmb_cpld_core_probe(struct platform_device *pdev)
+{
+	static struct pmb_cpld_core *cpld;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	struct ptxpmb_mux_data *pdata = dev->platform_data;
+	int i, error, mfd_size;
+	int cpld_type = CPLD_TYPE_PTXPMB;
+	const struct of_device_id *match;
+	struct mfd_cell *mfd_cells;
+
+	struct jnx_chassis_info chinfo = {
+		.chassis_no = 0,
+		.multichassis = 0,
+		.master_data = NULL,
+		.platform = -1,
+		.get_master = NULL,
+	};
+	struct jnx_card_info cinfo = {
+		.type = JNX_BOARD_TYPE_UNKNOWN,
+		.slot = -1,
+		.assembly_id = -1,
+	};
+
+	cpld = devm_kzalloc(dev, sizeof(*cpld), GFP_KERNEL);
+	if (!cpld)
+		return -ENOMEM;
+
+	cpld->dev = dev;
+	dev_set_drvdata(dev, cpld);
+
+	if (pdata) {
+		cpld_type = pdata->cpld_type;
+	} else {
+		match = of_match_device(pmb_cpld_of_ids, dev);
+		if (match)
+			cpld_type = (int)(unsigned long)match->data;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	cpld->cpld = devm_ioremap_resource(dev, res);
+	if (IS_ERR(cpld->cpld))
+		return PTR_ERR(cpld->cpld);
+
+	chinfo.master_data = cpld;
+
+	cpld->irq = platform_get_irq(pdev, 0);
+	if (cpld->irq >= 0) {
+		error = devm_request_threaded_irq(dev, cpld->irq, NULL,
+						  pmb_cpld_core_interrupt,
+						  IRQF_TRIGGER_RISING |
+						  IRQF_ONESHOT,
+						  dev_name(dev), cpld);
+		if (error < 0)
+			return error;
+	}
+
+	spin_lock_init(&cpld->lock);
+	init_waitqueue_head(&cpld->wqh);
+
+	mfd_cells = pmb_cpld_cells;
+	mfd_size = ARRAY_SIZE(pmb_cpld_cells);
+
+	switch (cpld_type) {
+	case CPLD_TYPE_PTXPMB:
+		cpld_ptxpmb_init(cpld, &chinfo, &cinfo);
+		break;
+	case CPLD_TYPE_NGPMB:
+		cpld_ngpmb_init(cpld, &chinfo, &cinfo);
+		mfd_cells = ngpmb_cpld_cells;
+		mfd_size = ARRAY_SIZE(ngpmb_cpld_cells);
+		break;
+	}
+
+	if (pdata) {
+		for (i = 0; i < mfd_size; i++) {
+			mfd_cells[i].platform_data = pdata;
+			mfd_cells[i].pdata_size = sizeof(*pdata);
+		}
+	}
+
+	error = mfd_add_devices(dev, pdev->id, mfd_cells,
+				mfd_size, res, 0, NULL);
+	if (error < 0)
+		return error;
+
+	jnx_register_chassis(&chinfo);
+	jnx_register_local_card(&cinfo);
+
+	return 0;
+}
+
+static int pmb_cpld_core_remove(struct platform_device *pdev)
+{
+	jnx_unregister_local_card();
+	jnx_unregister_chassis();
+	mfd_remove_devices(&pdev->dev);
+	return 0;
+}
+
+static struct platform_driver pmb_cpld_core_driver = {
+	.probe		= pmb_cpld_core_probe,
+	.remove		= pmb_cpld_core_remove,
+	.driver		= {
+		.name	= "ptxpmb-cpld",
+		.of_match_table = pmb_cpld_of_ids,
+		.owner	= THIS_MODULE,
+	}
+};
+
+module_platform_driver(pmb_cpld_core_driver);
+
+MODULE_DESCRIPTION("Juniper PTX PMB CPLD Core Driver");
+MODULE_AUTHOR("Guenter Roeck <groeck@juniper.net>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ptxpmb-cpld");
diff --git a/include/linux/mfd/ptxpmb_cpld.h b/include/linux/mfd/ptxpmb_cpld.h
new file mode 100644
index 0000000..e44afb4
--- /dev/null
+++ b/include/linux/mfd/ptxpmb_cpld.h
@@ -0,0 +1,140 @@
+/*---------------------------------------------------------------------------
+ *
+ * ptxpmb_cpld_core.h
+ *     Copyright (c) 2012 Juniper Networks
+ *
+ *---------------------------------------------------------------------------
+ */
+
+#ifndef PTXPMB_CPLD_CORE_H
+#define PTXPMB_CPLD_CORE_H
+
+struct pmb_boot_cpld {
+	u8 cpld_rev;		/* 0x00 */
+	u8 reset;
+#define CPLD_MAIN_RESET		(1 << 0)
+#define CPLD_PHYCB_RESET	(1 << 1)
+#define CPLD_PHYSW_RESET	(1 << 2)	/* P2020 only	*/
+#define NGPMB_PCIE_OTHER_RESET	(1 << 3)	/* PAM reset on MLC */
+	u8 reset_reason;
+#define NGPMB_REASON_MON_A_FAIL	(1 << 0)
+#define NGPMB_REASON_WDT1	(1 << 1)
+#define NGPMB_REASON_WDT2	(1 << 2)
+#define NGPMB_REASON_WDT3	(1 << 3)
+#define NGPMB_REASON_WDT4	(1 << 4)
+#define NGPMB_REASON_RE_HRST	(1 << 5)
+#define NGPMB_REASON_PWR_ON	(1 << 6)
+#define NGPMB_REASON_RE_SRST	(1 << 7)
+	u8 control;
+#define CPLD_CONTROL_BOOTED_LED	(1 << 0)
+#define CPLD_CONTROL_WATCHDOG	(1 << 6)
+#define CPLD_CONTROL_RTC	(1 << 7)
+#define NGPMB_FLASH_SELECT	(1 << 4)
+#define NGPMB_FLASH_SWIZZ_ENA	(1 << 5)
+	u8 sys_timer_cnt;
+	u8 watchdog_hbyte;
+	u8 watchdog_lbyte;
+	u8 unused1[1];
+	u8 baseboard_status1;	/* 0x08 */
+#define NGPMB_PMB_STANDALONE	(1 << 0)
+#define NGPMB_MASTER_SELECT	(1 << 1)
+#define NGPMB_BASEBRD_STANDALONE (1 << 2)
+#define NGPMB_BASEBRD_SLOT_LSB	3
+#define NGPMB_BASEBRD_SLOT_MASK	0xF8
+	u8 baseboard_status2;
+#define NGPMB_BASEBRD_TYPE_LSB	5
+#define NGPMB_BASEBRD_TYPE_MASK	0xE0
+#define NGPMB_BASEBRD_TYPE_MX	0
+	u8 chassis_number;
+	u8 sys_config;
+	u8 i2c_group_sel;	/* 0x0c */
+	u8 i2c_group_en;
+	u8 unused2[4];
+	u8 timer_irq_st;	/* 0x12 */
+	u8 timer_irq_en;
+	u8 unused3[12];
+	u8 prog_jtag_control;	/* 0x20 */
+	u8 gp_reset1;		/* 0x21 */
+#define CPLD_GP_RST1_PCISW	(1 << 0)
+#define CPLD_GP_RST1_SAM	(1 << 1)
+#define CPLD_GP_RST1_BRCM	(1 << 2)
+	u8 gp_reset2;		/* 0x22 */
+	u8 phy_control;
+	u8 gpio_1;
+	u8 gpio_2;
+#define NGPMB_GPIO2_TO_BASEBRD_LSB	(1 << 3)
+#define NGPMB_I2C_GRP_SEL_LSB	0
+#define NGPMB_I2C_GRP_SEL_MASK	0x03
+	u8 thermal_status;
+	u8 i2c_host_sel;
+#define CPLD_I2C_HOST0_MSTR     0x09
+#define CPLD_I2C_HOST1_MSTR     0x06
+#define CPLD_I2C_HOST_MSTR_MASK 0x0f
+	u8 scratch[3];
+	u8 misc_status;
+	u8 i2c_bus_control;	/* 0x2c */
+	union {
+		struct {
+			u8 mezz_present;
+			u8 unused1[4];
+			u8 i2c_group_sel_dbg;	/* 0x31 */
+			u8 i2c_group_en_dbg;	/* 0x32 */
+			u8 i2c_group_sel_force;	/* 0x33 */
+			u8 i2c_group_en_force;	/* 0x34 */
+			u8 unused2[0x4b];
+		} p2020;
+		struct {
+			u8 hdk_minor_version;	/* 0x2d */
+			u8 hdk_feature_ind;
+			u8 hdk_pmb_srds_mode;
+			u8 hdk_pwr_fail_status;
+			u8 hdk_pmb_pwr_status;
+			u8 hdk_pmb_mezz_status;
+			u8 cpld_self_reset;	/* 0x33 */
+			u8 unused[0x4c];
+			u8 hdk_bcpld_rcw[80];
+		} p5020;
+		struct {
+			u8 unused[3];
+			u8 chassis_id;		/* 0x30 */
+			u8 chassis_type;	/* 0x31 */
+#define NGPMB_CHASSIS_TYPE_LSB		0
+#define NGPMB_CHASSIS_TYPE_MASK		0x0F
+#define NGPMB_CHASSIS_TYPE_POLARIS	0x0B
+#define NGPMB_CHASSIS_TYPE_HENDRICKS	0x09
+			u8 sys_config;		/* 0x32 */
+#define NGPMB_SYS_CONFIG_MULTI_CHASSIS	0x01
+		} ngpmb;
+		struct {
+			u8 nv_win;		/* 0x2d */
+			u8 nv_addr1;
+			u8 nv_addr2;
+			u8 nv_wr_data;
+			u8 nv_rd_data;
+			u8 nv_cmd;
+			u8 nv_done_bit;
+		} nvram;
+	} board;
+};
+
+#ifdef CONFIG_P2020_PTXPMB
+#define CPLD_PHY_RESET	(CPLD_PHYCB_RESET | CPLD_PHYSW_RESET)
+#else
+#define CPLD_PHY_RESET	CPLD_PHYCB_RESET
+#endif
+
+#define i2c_group_sel_force board.p2020.i2c_group_sel_force
+#define i2c_group_en_force board.p2020.i2c_group_en_force
+
+struct ptxpmb_mux_data {
+	int cpld_type;
+#define CPLD_TYPE_PTXPMB    0	/* SPMB / Sangria FPC / Hendricks FPC */
+#define CPLD_TYPE_NGPMB     1	/* MLC / Stout / Gladiator... */
+	int num_enable;		/* Number of I2C enable pins		*/
+	int num_channels;	/* Number of I2C channels used in a mux chip */
+	int parent_bus_num;	/* parent i2c bus number		*/
+	int base_bus_num;	/* 1st bus number, 0 if undefined	*/
+	bool use_force;		/* Use i2c force registers if true	*/
+};
+
+#endif /* PTXPMB_CPLD_CORE_H */
-- 
1.9.1
