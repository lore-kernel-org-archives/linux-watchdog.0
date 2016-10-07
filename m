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
Subject: [PATCH 09/10] mtd: devices: Add driver for memory mapped NVRAM on FPC
Date: Fri,  7 Oct 2016 18:17:30 +0300
Message-Id: <1475853451-22121-10-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>

Add MTD driver for NVRAM on Juniper Gladiator FPC PMB. This driver uses
indirect memory-mapped access facilitated by bootcpld. Requires
cpld_ver >= 0XC6 and DT support.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
Signed-off-by: JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/mtd/devices/Kconfig         |  11 +++
 drivers/mtd/devices/Makefile        |   1 +
 drivers/mtd/devices/jnx_pmb_nvram.c | 191 ++++++++++++++++++++++++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 drivers/mtd/devices/jnx_pmb_nvram.c

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 58329d2..d4255fb 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -144,6 +144,17 @@ config MTD_LART
 	  not need any mapping/chip driver for LART. This one does it all
 	  for you, so go disable all of those if you enabled some of them (:
 
+config JNX_PMB_NVRAM
+	tristate "Juniper FPC PMB NVRAM Driver"
+	depends on (PTXPMB_COMMON || JNX_PTX_NGPMB)
+	default y if (PTXPMB_COMMON || JNX_PTX_NGPMB)
+	help
+	  This driver adds support for NVRAM on Gladiator 3T FPC which is connected
+	  to the BOOTCPLD (cpld_version >= C6).
+
+	  This driver can also be built as a module. When it is so the name of
+	  the module is ngpmb-nvram.
+
 config MTD_MTDRAM
 	tristate "Test driver using RAM"
 	help
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index 7912d3a..b407c5fc 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -18,5 +18,6 @@ obj-$(CONFIG_MTD_BCM47XXSFLASH)	+= bcm47xxsflash.o
 obj-$(CONFIG_MTD_ST_SPI_FSM)    += st_spi_fsm.o
 obj-$(CONFIG_MTD_POWERNV_FLASH)	+= powernv_flash.o
 
+obj-$(CONFIG_JNX_PMB_NVRAM)     += jnx_pmb_nvram.o
 
 CFLAGS_docg3.o			+= -I$(src)
diff --git a/drivers/mtd/devices/jnx_pmb_nvram.c b/drivers/mtd/devices/jnx_pmb_nvram.c
new file mode 100644
index 0000000..8a1e812
--- /dev/null
+++ b/drivers/mtd/devices/jnx_pmb_nvram.c
@@ -0,0 +1,191 @@
+/*
+ * Juniper Networks PTX1K RCB I2CS Boot FPGA MTD driver
+ * FPGA upgrades of the Spartan3AN/XC3S700 based I2CS.
+ *
+ * Copyright (C) 2015 Juniper Networks. All rights reserved.
+ * Author:	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>
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
+ */
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+#include <linux/mfd/ptxpmb_cpld.h>
+
+struct nvram_mtd {
+	void __iomem *base;
+	struct device *dev;
+	struct mtd_info mtd;
+	struct mutex lock;
+};
+
+
+static int ram_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	struct nvram_mtd *nvram = container_of(mtd, struct nvram_mtd, mtd);
+
+	memset((char *)nvram->base + instr->addr, 0xff, instr->len);
+	instr->state = MTD_ERASE_DONE;
+	mtd_erase_callback(instr);
+	return 0;
+}
+
+static int ram_point(struct mtd_info *mtd, loff_t from, size_t len,
+		     size_t *retlen, void **virt, resource_size_t *phys)
+{
+	struct nvram_mtd *nvram = container_of(mtd, struct nvram_mtd, mtd);
+
+	virt = nvram->base + from;
+	*retlen = len;
+	return 0;
+}
+
+static int ram_unpoint(struct mtd_info *mtd, loff_t from, size_t len)
+{
+	return 0;
+}
+
+static int ram_read(struct mtd_info *mtd, loff_t from, size_t len,
+		    size_t *retlen, u_char *buf)
+{
+	struct nvram_mtd *nvram = container_of(mtd, struct nvram_mtd, mtd);
+
+	memcpy(buf, nvram->base + from, len);
+	*retlen = len;
+	return 0;
+}
+
+static int ram_write(struct mtd_info *mtd, loff_t to, size_t len,
+		     size_t *retlen, const u_char *buf)
+{
+	struct nvram_mtd *nvram = container_of(mtd, struct nvram_mtd, mtd);
+
+	memcpy((char *)nvram->base + to, buf, len);
+	*retlen = len;
+	return 0;
+}
+
+int nvram_init_mtd_parse(struct platform_device *pdev, struct mtd_info *mtd)
+{
+	struct mtd_part_parser_data ppdata = {};
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	mtd->name = dev_name(dev);
+	mtd->type = MTD_RAM;
+	mtd->flags = MTD_CAP_RAM;
+	mtd->size = 0xFF00;
+	mtd->writesize = 1;
+	mtd->writebufsize = 64; /* Mimic CFI NOR flashes */
+	mtd->erasesize = 0x1000;
+	mtd->owner = THIS_MODULE;
+	mtd->_erase = ram_erase;
+	mtd->_point = ram_point;
+	mtd->_unpoint = ram_unpoint;
+	mtd->_read = ram_read;
+	mtd->_write = ram_write;
+	mtd->_panic_write = ram_write;
+
+	ret = mtd_device_parse_register(mtd, NULL, &ppdata, NULL, 0);
+	if (ret) {
+		dev_err(dev, "mtd_device_parse_register returned %d\n", ret);
+		return ret;
+	}
+	return ret;
+}
+
+static int nvram_probe(struct platform_device *pdev)
+{
+	struct pmb_boot_cpld __iomem *cpld;
+	struct nvram_mtd *nvram;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	nvram = devm_kzalloc(dev, sizeof(*nvram), GFP_KERNEL);
+	if (!nvram)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "Failed to get nvram mmio resource\n");
+		return -ENOENT;
+	}
+	nvram->base = devm_ioremap_nocache(dev, res->start, resource_size(res));
+	if (!nvram->base) {
+		dev_err(dev, "Cannot map nvram\n");
+		return -EADDRNOTAVAIL;
+	}
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res) {
+		/* Always assume that we need cpld control */
+		dev_err(dev, "Failed to get cpld mmio resource\n");
+		return -ENOENT;
+	}
+	cpld = devm_ioremap_nocache(dev, res->start, resource_size(res));
+	if (!cpld) {
+		dev_err(dev, "Cannot map cpld\n");
+		return -EADDRNOTAVAIL;
+	}
+	nvram->dev = dev;
+	platform_set_drvdata(pdev, nvram);
+	ret = nvram_init_mtd_parse(pdev, &nvram->mtd);
+	if (ret)
+		return ret;
+
+	if (READ_ONCE(cpld->cpld_rev) < 0xC6)
+		dev_info(dev, "NVRAM requires atleast cpld_rev 0XC6\n");
+
+	/* Initialize the window register in the cpld*/
+	WRITE_ONCE(cpld->board.nvram.nv_win, 0x0);
+	dev_info(dev, "Initialized window:0x%x\n",
+			READ_ONCE(cpld->board.nvram.nv_win));
+	return ret;
+}
+
+static int nvram_remove(struct platform_device *pdev)
+{
+	struct nvram_mtd *nvram;
+
+	nvram = platform_get_drvdata(pdev);
+	mtd_device_unregister(&nvram->mtd);
+	return 0;
+}
+
+static const struct of_device_id ngpmb_mtd_ids[] = {
+	{ .compatible = "jnx,ngpmb-nvram", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ngpmb_mtd_ids);
+
+static struct platform_driver nvram_driver = {
+	.probe  = nvram_probe,
+	.remove = nvram_remove,
+	.driver = {
+		.name = "ngpmb-nvram",
+		.owner = THIS_MODULE,
+		.of_match_table = ngpmb_mtd_ids,
+	},
+};
+
+module_platform_driver(nvram_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>");
+MODULE_DESCRIPTION("EVO PTXPMB CPLD NVRAM Driver");
+MODULE_ALIAS("platform:ngpmb-nvram");
-- 
1.9.1
