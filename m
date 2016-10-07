Return-path: <pantelis.antoniou@konsulko.com>
From: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Jean Delvare <jdelvare@suse.com>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH 5/7] mtd: ptx1kbf: Add PTX1K BootFPGA MTD driver
Date: Fri,  7 Oct 2016 18:22:02 +0300
Message-Id: <1475853724-22557-6-git-send-email-pantelis.antoniou@konsulko.com>
In-Reply-To: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
References: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Georgi Vlaev <gvlaev@juniper.net>

This patch adds a MTD driver for configuration updates of the
Xilinx Spartan 3AN based FPGAs on the PTX1K RE boards. The
driver is client of the ptx1k-bootfpga driver.

Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
[Ported from Juniper kernel]
Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 drivers/mtd/devices/Kconfig           |  10 +
 drivers/mtd/devices/Makefile          |   1 +
 drivers/mtd/devices/jnx_ptx1kbf_mtd.c | 677 ++++++++++++++++++++++++++++++++++
 3 files changed, 688 insertions(+)
 create mode 100644 drivers/mtd/devices/jnx_ptx1kbf_mtd.c

diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index f5a9032..25a1c4a 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -155,6 +155,16 @@ config MTD_SAM_FLASH
 	  This driver can also be built as a module. When it is so the name of
 	  the module is flash-sam.
 
+config MTD_JNX_PTX1KBF
+	tristate "Juniper I2CS BootFPGA MTD driver"
+	depends on MFD_JUNIPER_PTX1KBF
+	help
+	  This enables the MTD driver for the Juniper I2CS BootFPGA.
+	  The driver is used to perform software upgrades of the RE's
+	  Spartan 3AN XC3S50AN, XC3S200AN, XCS400AN, XC3S700AN and
+	  XC3S1400AN based I2CS. The I2CS BootFPGA must implement the
+	  remote upgrade software interface.
+
 config JNX_PMB_NVRAM
 	tristate "Juniper FPC PMB NVRAM Driver"
 	depends on (PTXPMB_COMMON || JNX_PTX_NGPMB)
diff --git a/drivers/mtd/devices/Makefile b/drivers/mtd/devices/Makefile
index 7556311..e1adfa5 100644
--- a/drivers/mtd/devices/Makefile
+++ b/drivers/mtd/devices/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_MTD_ST_SPI_FSM)    += st_spi_fsm.o
 obj-$(CONFIG_MTD_POWERNV_FLASH)	+= powernv_flash.o
 
 obj-$(CONFIG_MTD_SAM_FLASH)	+= sam-flash.o
+obj-$(CONFIG_MTD_JNX_PTX1KBF)	+= jnx_ptx1kbf_mtd.o
 obj-$(CONFIG_JNX_PMB_NVRAM)     += jnx_pmb_nvram.o
 
 CFLAGS_docg3.o			+= -I$(src)
diff --git a/drivers/mtd/devices/jnx_ptx1kbf_mtd.c b/drivers/mtd/devices/jnx_ptx1kbf_mtd.c
new file mode 100644
index 0000000..3bc17be
--- /dev/null
+++ b/drivers/mtd/devices/jnx_ptx1kbf_mtd.c
@@ -0,0 +1,677 @@
+/*
+ * Juniper Networks PTX1K RCB I2CS Boot FPGA MTD driver
+ * FPGA upgrades of the Spartan3AN/XC3S700 based I2CS.
+ *
+ * Copyright (C) 2015 Juniper Networks. All rights reserved.
+ * Author: Georgi Vlaev <gvlaev@juniper.net>
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
+#include <linux/mfd/ptx1k-bootfpga.h>
+
+#define DEFAULT_BUSY_TIMEOUT	5	/* default timeout (msec) */
+#define PAGE_BUFFER_TXFER	400	/* page->sram transfer (usec) */
+
+/* FLASH_IF_CONTROL commands */
+#define CONTROL_READ_SID	0x80
+#define CONTROL_READ_DID	0x04
+#define CONTROL_READ_STATUS	0x08
+#define CONTROL_SECTOR_ERASE	0x20
+#define CONTROL_PAGE_ERASE	0x40
+#define CONTROL_PAGE_WRITE	0x02
+#define CONTROL_PAGE_READ	0x01
+#define CONTROL_SP_READ		0x02
+#define CONTROL_SP_WRITE	0x08
+#define CONTROL_SP_UALL		0x01
+
+/* FLASH_IF_STATUS bits */
+#define STATUS_BUSY		BIT(0)
+#define STATUS_ILLEGAL_WRITE	BIT(1)
+#define STATUS_ILLEGAL_ERASE	BIT(2)
+#define STATUS_ILLEGAL (STATUS_ILLEGAL_WRITE | STATUS_ILLEGAL_ERASE)
+#define STATUS_POWER_2_ADDR	BIT(3)
+#define STATUS_SID_I2CS		0x1F /* I2CS Spartan3AN FPGA */
+
+/* RU_CONFIG_CONTROL_STATUS bits */
+#define RU_CCS_USER_IMAGE	BIT(7)
+#define RU_CCS_RECONFIG		BIT(5)
+
+#define MASK_SPARE_PAGE		0x1f
+#define MASK_SPARE_SECTOR	0x1fff
+
+#define SECTOR_UNPROTECT	0x00
+#define SECTOR_PROTECT		0xff
+
+struct bfmtd_info {
+	const char *name;
+	u8 device_id;		/* flash id as reported by the fpga */
+	size_t flash_size;	/* total flash size */
+	size_t page_size;	/* read/write page size */
+	size_t sector_size;	/* erase sector size */
+	size_t nr_pages;	/* total number of pages */
+	size_t nr_sectors;	/* total number of sectors */
+	size_t writesize;	/* write size */
+	size_t writebufsize;	/* internal fpga sram buffer size (bytes) */
+	size_t spare_size;	/* additional bytes per page in 'default' mode*/
+	/*
+	 * Timeouts are defined in the Xilinx "In-System Flash (ISF) Upgrade
+	 * User Guide". Our values will add 20% on top of ISF ones
+	 */
+	u16 page_erase_tmo;	/* page erase timeout (msec) */
+	u16 sector_erase_tmo;	/* sector erase timeout (msec) */
+	u16 buffer_program_tmo;	/* sram buffer program timeout (msec) */
+};
+
+/*
+ * Definitions in power-of-2 addressing mode.
+ * Reconfigure sizes if default mode is detected.
+ */
+static struct bfmtd_info bfmtd_info_db[] = {
+	{
+		.name = "XC3S50AN",
+		.device_id = 0x22,
+		.flash_size = 256 * 512,
+		.page_size = 256,
+		.nr_pages = 512,
+		.nr_sectors = 4,
+		.sector_size = 256 * 128,
+		.writesize = 1,
+		.writebufsize = 256,
+		.spare_size = 8,
+		.page_erase_tmo = 38,
+		.sector_erase_tmo = 3000,
+		.buffer_program_tmo = 5,
+	},
+	{
+		.name = "XC3S200AN/XC3S400AN",
+		.device_id = 0x24,
+		.flash_size = 256 * 2048,
+		.page_size = 256,
+		.nr_pages = 2048,
+		.nr_sectors = 8,
+		.sector_size = 256 * 256,
+		.writesize = 1,
+		.writebufsize = 256,
+		.spare_size = 8,
+		.page_erase_tmo = 38,
+		.sector_erase_tmo = 6000,
+		.buffer_program_tmo = 5,
+	},
+	{
+		.name = "XC3S700AN",
+		.device_id = 0x25,
+		.flash_size = 256 * 4096,
+		.page_size = 256,
+		.nr_pages = 4096,
+		.nr_sectors = 16,
+		.sector_size = 256 * 256,
+		.writesize = 1,
+		.writebufsize = 256,
+		.spare_size = 8,
+		.page_erase_tmo = 42,
+		.sector_erase_tmo = 6000,
+		.buffer_program_tmo = 8,
+	},
+	{
+		.name = "XC3S1400AN",
+		.device_id = 0x26,
+		.flash_size = 512 * 4096,
+		.page_size = 512,
+		.nr_pages = 4096,
+		.nr_sectors = 16,
+		.sector_size = 512 * 256,
+		.writesize = 1,
+		.writebufsize = 512,
+		.spare_size = 8,
+		.page_erase_tmo = 42,
+		.sector_erase_tmo = 6000,
+		.buffer_program_tmo = 8,
+	},
+};
+
+struct bf_mtd {
+	void __iomem *base;
+	struct device *dev;
+	struct mtd_info mtd;
+	struct bfmtd_info *info;
+	struct mutex lock;
+};
+
+/*
+ * bfmtd_busy_wait()
+ *	Wait for busy[0] flag in the FLASH_IF_STATUS register
+ */
+static int bfmtd_busy_wait(struct bf_mtd *bfmtd, unsigned long max_wait)
+{
+	u8 status;
+	unsigned long timeout = jiffies + msecs_to_jiffies(max_wait);
+
+	udelay(50);
+	do {
+		status = ioread8(bfmtd->base + BOOT_FPGA_FLASH_IF_STATUS(3));
+		if (!(status & STATUS_BUSY))
+			return 0;
+
+		if (status & STATUS_ILLEGAL)
+			return -EACCES;
+
+		usleep_range(50, 100);
+	} while (time_before(jiffies, timeout));
+
+	return -ETIMEDOUT;
+}
+
+/*
+ * bfmtd_read_status()
+ *	Read FLASH_IF_STATUS regsters
+ */
+static int bfmtd_read_status(struct bf_mtd *bfmtd, u8 control_cmd,
+				u8 status_index)
+{
+	int ret;
+
+	iowrite8(control_cmd,
+		 bfmtd->base + BOOT_FPGA_FLASH_IF_CONTROL(3));
+
+	ret = bfmtd_busy_wait(bfmtd, DEFAULT_BUSY_TIMEOUT);
+	if (ret)
+		return ret;
+
+	return ioread8(bfmtd->base +
+			BOOT_FPGA_FLASH_IF_STATUS(status_index));
+}
+
+/* Device ID */
+static inline int bfmtd_read_did(struct bf_mtd *bfmtd)
+{
+	return bfmtd_read_status(bfmtd, CONTROL_READ_DID, 1);
+}
+
+/* Silicon ID */
+static inline int bfmtd_read_sid(struct bf_mtd *bfmtd)
+{
+	return bfmtd_read_status(bfmtd, CONTROL_READ_SID, 2);
+}
+
+/* ^2 addressing mode */
+static inline int bfmtd_read_p2addr(struct bf_mtd *bfmtd)
+{
+	return bfmtd_read_status(bfmtd, CONTROL_READ_STATUS, 3);
+}
+
+/*
+ * bfmtd_calc_flash_addr()
+ *
+ * We have to support 2 different addressing schemes.
+ * The page_size can be 256, 264, 512, 528.
+ * The page_size in the default addressing mode are 264 and 528.
+ * The same is valid for the sector addresses.
+ * Calculate the page/sector address from the page_size/sectro_size.
+ *
+ * Example (XC3S700AN):
+ * Page#	Default addressing	Power of 2 addressing
+ * 0		0x000 - 0x107		0x000 - 0xFF
+ * 1		0x200 - 0x307		0x100 - 0x1FF
+ * 2		0x400 - 0x507		0x200 - 0x2FF
+ */
+static u32 bfmtd_calc_flash_addr(u32 addr, u32 size, u32 mask)
+{
+	/* spare = 0,8,16 for pages and 0,1024,2048,4096 for sectors */
+	u32 spare = size & mask;
+
+	if (!spare) /* power-of-2 mode */
+		return addr & ~(size - 1);
+
+	/* default mode, use spare to get the page/sector address */
+	addr /= size;
+	addr *= (spare << 6);
+
+	return addr;
+}
+
+/*
+ * bfmtd_read_page()
+ *	Transfer a page from the flash into the sram buffer
+ */
+static int bfmtd_read_page(struct bf_mtd *bfmtd, u32 addr, u8 *buf,
+				size_t len)
+{
+	int ret;
+	u32 page_addr, page_ofs;
+	u16 buff_addr;
+	size_t retlen, page_size =  bfmtd->info->page_size;
+
+	if (len > page_size)
+		len = page_size;
+
+	page_ofs = addr % page_size;
+	retlen = len - page_ofs;
+
+	if (!retlen || addr + retlen > bfmtd->info->flash_size)
+		return -EINVAL;
+
+	ret = bfmtd_busy_wait(bfmtd, DEFAULT_BUSY_TIMEOUT);
+	if (ret)
+		return ret;
+
+	/* Calculate the page address */
+	page_addr = bfmtd_calc_flash_addr(addr, page_size, MASK_SPARE_PAGE);
+
+	/* Set page address, byte count and trigger write */
+	iowrite32(be32_to_cpu(page_addr),
+		bfmtd->base + BOOT_FPGA_FLASH_IF_ADDR(0));
+	/* byte count (N), denotes (N + 1) */
+	iowrite32(be32_to_cpu(len - 1),
+		bfmtd->base + BOOT_FPGA_FLASH_IF_BYTE_COUNT(0));
+	iowrite8(CONTROL_PAGE_READ,
+		bfmtd->base + BOOT_FPGA_FLASH_IF_CONTROL(3));
+
+	/* Wait the fpga the fetch the page into the sram buffer (400 usec) */
+	ret = bfmtd_busy_wait(bfmtd, DEFAULT_BUSY_TIMEOUT);
+	if (ret)
+		return ret;
+
+	for (buff_addr = page_ofs; buff_addr < len; buff_addr++) {
+		iowrite16(be16_to_cpu(buff_addr),
+			bfmtd->base + BOOT_FPGA_FLASH_IF_READ_BUF_ADDR_MSB);
+		*buf = ioread8(bfmtd->base + BOOT_FPGA_FLASH_IF_READ_BUF_DATA);
+		buf++;
+	}
+
+	return retlen;
+}
+
+/*
+ * bfmtd_is_protected()
+ *	Check if the sector @addr is protected
+ */
+static int bfmtd_is_protected(struct bf_mtd *bfmtd, u32 addr)
+{
+	u8 protected_sectors[16];
+	int n_sector, ret = 0;
+	u16 buff_addr;
+
+	if (addr > bfmtd->info->flash_size)
+		return -EINVAL;
+
+	n_sector = addr / bfmtd->info->sector_size;
+
+	/* Read the protected sector array */
+	iowrite8(CONTROL_SP_READ,
+		bfmtd->base + BOOT_FPGA_FLASH_IF_CONTROL(2));
+
+	ret = bfmtd_busy_wait(bfmtd, DEFAULT_BUSY_TIMEOUT);
+	if (ret)
+		return ret;
+
+	for (buff_addr = 0; buff_addr < bfmtd->info->nr_sectors; buff_addr++) {
+		iowrite16(be16_to_cpu(buff_addr),
+			bfmtd->base + BOOT_FPGA_FLASH_IF_READ_BUF_ADDR_MSB);
+		protected_sectors[buff_addr] =
+			ioread8(bfmtd->base + BOOT_FPGA_FLASH_IF_READ_BUF_DATA);
+	}
+
+	if (protected_sectors[n_sector] == SECTOR_PROTECT) {
+		dev_err(bfmtd->dev, "Sector #%d is protected\n", n_sector);
+		return -EACCES;
+	}
+
+	return 0;
+}
+
+/*
+ * bfmtd_erase_region()
+ *	Erase pages or sectors.
+ *	Note: The control (0xa5a5a5a5) words are written on page boundary.
+ */
+static int bfmtd_erase_region(struct bf_mtd *bfmtd, u32 addr)
+{
+	struct mtd_info *mtd = &bfmtd->mtd;
+	u32 flash_addr, mask, timeout;
+	u8 cmd;
+	int ret;
+
+	if (addr > bfmtd->info->flash_size)
+		return -EINVAL;
+
+	ret = bfmtd_is_protected(bfmtd, addr);
+	if (ret)
+		return ret;
+
+	ret = bfmtd_busy_wait(bfmtd, DEFAULT_BUSY_TIMEOUT);
+	if (ret)
+		return ret;
+
+	/* sector/page erase mode ? */
+	if (bfmtd->info->page_size == mtd->erasesize) {
+		mask = MASK_SPARE_PAGE;
+		timeout = bfmtd->info->page_erase_tmo;
+		cmd = CONTROL_PAGE_ERASE;
+	} else {
+		mask = MASK_SPARE_SECTOR;
+		timeout = bfmtd->info->sector_erase_tmo;
+		cmd = CONTROL_SECTOR_ERASE;
+	}
+
+	/* Calculate the page/sector address */
+	flash_addr = bfmtd_calc_flash_addr(addr, mtd->erasesize, mask);
+
+	/* Set page/sector address, byte count and trigger erase */
+	iowrite32(be32_to_cpu(flash_addr),
+		bfmtd->base + BOOT_FPGA_FLASH_IF_ADDR(0));
+	iowrite8(cmd, bfmtd->base + BOOT_FPGA_FLASH_IF_CONTROL(3));
+
+	/* Wait the fpga the flush the buffer */
+	ret = bfmtd_busy_wait(bfmtd, timeout);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+/*
+ * bfmtd_write_page()
+ *	Write a page content in the sram buffer and then to flash device
+ */
+static int bfmtd_write_page(struct bf_mtd *bfmtd, u32 addr, const u8 *buf,
+				size_t len)
+{
+	int ret;
+	u32 page_addr, page_ofs;
+	u16 buff_addr;
+	size_t retlen, page_size =  bfmtd->info->page_size;
+
+	if (len > page_size)
+		len = page_size;
+
+	page_ofs = addr % page_size;
+	retlen = len - page_ofs;
+
+	if (!retlen || addr + retlen > bfmtd->info->flash_size)
+		return -EINVAL;
+
+	ret = bfmtd_busy_wait(bfmtd, DEFAULT_BUSY_TIMEOUT);
+	if (ret)
+		return ret;
+
+	/* Fill the internal fpga buffer */
+	for (buff_addr = page_ofs; buff_addr < len; buff_addr++) {
+		iowrite16(be16_to_cpu(buff_addr),
+			bfmtd->base + BOOT_FPGA_FLASH_IF_WRITE_BUF_ADDR_MSB);
+		iowrite8(*buf, bfmtd->base + BOOT_FPGA_FLASH_IF_WRITE_BUF_DATA);
+		buf++;
+	}
+
+	/* Calculate the page address */
+	page_addr = bfmtd_calc_flash_addr(addr, page_size, MASK_SPARE_PAGE);
+
+	/* Set page address, byte count and trigger write */
+	iowrite32(be32_to_cpu(page_addr),
+		bfmtd->base + BOOT_FPGA_FLASH_IF_ADDR(0));
+	iowrite32(be32_to_cpu(len - 1),
+		bfmtd->base + BOOT_FPGA_FLASH_IF_BYTE_COUNT(0));
+	iowrite8(CONTROL_PAGE_WRITE,
+		bfmtd->base + BOOT_FPGA_FLASH_IF_CONTROL(3));
+
+	/* Wait the fpga the flush the buffer */
+	ret = bfmtd_busy_wait(bfmtd, bfmtd->info->buffer_program_tmo);
+	if (ret)
+		return ret;
+
+	return retlen;
+}
+
+/*
+ * bfmtd_read()
+ *	MTD read
+ */
+static int bfmtd_read(struct mtd_info *mtd, loff_t from, size_t len,
+			size_t *retlen, u8 *buf)
+{
+	struct bf_mtd *bfmtd = container_of(mtd, struct bf_mtd, mtd);
+	int ret, read = 0;
+
+	mutex_lock(&bfmtd->lock);
+	while (len) {
+		ret = bfmtd_read_page(bfmtd, from, buf, len);
+		if (ret < 0) {
+			dev_err(bfmtd->dev, "RD @0x%llx, size %ld failed (%d)",
+					from, len, ret);
+			mutex_unlock(&bfmtd->lock);
+			return ret;
+		}
+		read += ret;
+		len -= ret;
+		from += ret;
+		buf += ret;
+	}
+	mutex_unlock(&bfmtd->lock);
+
+	*retlen = read;
+
+	return 0;
+}
+
+/*
+ * bfmtd_write()
+ *	MTD write
+ */
+static int bfmtd_write(struct mtd_info *mtd, loff_t to, size_t len,
+				size_t *retlen, const u8 *buf)
+{
+	struct bf_mtd *bfmtd = container_of(mtd, struct bf_mtd, mtd);
+	int ret, written = 0;
+
+	mutex_lock(&bfmtd->lock);
+	while (len) {
+		ret = bfmtd_write_page(bfmtd, to, buf, len);
+		if (ret < 0) {
+			dev_err(bfmtd->dev, "WR @0x%llx, size %ld failed (%d)",
+					to, len, ret);
+			mutex_unlock(&bfmtd->lock);
+			return ret;
+		}
+		written += ret;
+		len -= ret;
+		to += ret;
+		buf += ret;
+	}
+	mutex_unlock(&bfmtd->lock);
+
+	*retlen = written;
+
+	return 0;
+}
+
+/*
+ * bfmtd_erase()
+ *	MTD erase
+ */
+static int bfmtd_erase(struct mtd_info *mtd, struct erase_info *ei)
+{
+	struct bf_mtd *bfmtd = container_of(mtd, struct bf_mtd, mtd);
+	u32  start_addr, end_addr, addr;
+	int len, ret = 0;
+
+	len = ei->len;
+	start_addr =  ei->addr;
+	end_addr = start_addr + len - 1;
+
+	ei->state = MTD_ERASE_DONE;
+	addr = start_addr;
+	mutex_lock(&bfmtd->lock);
+	while (addr < end_addr) {
+		ret = bfmtd_erase_region(bfmtd, addr);
+		if (ret < 0) {
+			dev_err(bfmtd->dev, "Erase @0x%x, size %d failed (%d)",
+					addr, mtd->erasesize, ret);
+			ei->state = MTD_ERASE_FAILED;
+			break;
+		}
+		addr += mtd->erasesize;
+	}
+	mutex_unlock(&bfmtd->lock);
+
+	mtd_erase_callback(ei);
+
+	return ret;
+}
+
+static int bfmtd_init_mtd(struct bf_mtd *bfmtd)
+{
+	struct mtd_info *mtd;
+	struct bfmtd_info *info = NULL;
+	int ret, i;
+
+	ret = bfmtd_read_sid(bfmtd);
+	if (ret < 0)
+		return ret;
+
+	if (ret != STATUS_SID_I2CS) {
+		dev_err(bfmtd->dev, "Unsupported silicon id: %u", ret);
+		return -ENODEV;
+	}
+
+	ret = bfmtd_read_did(bfmtd);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(bfmtd_info_db); i++) {
+		if (bfmtd_info_db[i].device_id == ret) {
+			info = &bfmtd_info_db[i];
+			break;
+		}
+	}
+
+	if (!info) {
+		dev_err(bfmtd->dev, "Unsupported device id: %u", ret);
+		return -ENODEV;
+	}
+
+	ret = bfmtd_read_p2addr(bfmtd);
+	if (ret < 0)
+		return ret;
+
+	/* Reconfigure sizes if not in "power-of-2" addressing mode */
+	if (!(ret & STATUS_POWER_2_ADDR)) {
+		info->page_size += info->spare_size;
+		info->writebufsize = info->page_size;
+		info->flash_size = info->page_size * info->nr_pages;
+		info->sector_size = info->flash_size / info->nr_sectors;
+	}
+
+	dev_info(bfmtd->dev, "%s configuration flash in \'%s\' addressing mode\n",
+			info->name,
+			(ret & STATUS_POWER_2_ADDR) ? "power-of-2" : "default");
+
+	ret = ioread8(bfmtd->base + BOOT_FPGA_RU_CONFIG_CONTROL_STATUS);
+	dev_info(bfmtd->dev, "active FPGA configuration: %s\n",
+			(ret & RU_CCS_USER_IMAGE) ? "user" : "golden");
+
+	bfmtd->info = info;
+	mtd = &bfmtd->mtd;
+	mtd->name = dev_name(bfmtd->dev);
+	mtd->type = MTD_NORFLASH;
+	mtd->flags = MTD_CAP_NORFLASH;
+	mtd->erasesize = info->page_size;
+	mtd->writesize = info->writesize;
+	mtd->writebufsize = info->writebufsize;
+	mtd->size = info->flash_size;
+	mtd->_erase = bfmtd_erase;
+	mtd->_read = bfmtd_read;
+	mtd->_write = bfmtd_write;
+
+	return 0;
+}
+
+static int bfmtd_probe(struct platform_device *pdev)
+{
+	struct mtd_part_parser_data ppdata = {};
+	struct bf_mtd *bfmtd;
+	struct resource *mem;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	bfmtd = devm_kzalloc(dev, sizeof(*bfmtd), GFP_KERNEL);
+	if (!bfmtd)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem) {
+		dev_err(dev, "Failed to get platform mmio resource\n");
+		return -ENOENT;
+	}
+
+	bfmtd->base = devm_ioremap_nocache(dev, mem->start, resource_size(mem));
+	if (IS_ERR(bfmtd->base)) {
+		dev_err(dev, "Failed to ioremap mmio memory\n");
+		return PTR_ERR(bfmtd->base);
+	}
+
+	bfmtd->dev = dev;
+	ret = bfmtd_init_mtd(bfmtd);
+	if (ret)
+		return ret;
+
+	ret = mtd_device_parse_register(&bfmtd->mtd, NULL, &ppdata, NULL, 0);
+	if (ret) {
+		dev_err(dev, "Failed to register MTD device (%d)\n", ret);
+		return ret;
+	}
+
+	mutex_init(&bfmtd->lock);
+
+	platform_set_drvdata(pdev, bfmtd);
+
+	return ret;
+}
+
+static int bfmtd_remove(struct platform_device *pdev)
+{
+	struct bf_mtd *bfmtd = platform_get_drvdata(pdev);
+
+	mtd_device_unregister(&bfmtd->mtd);
+
+	return 0;
+}
+
+static const struct of_device_id ptx1kbf_mtd_ids[] = {
+	{ .compatible = "jnx,ptx1kbf-mtd", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ptx1kbf_mtd_ids);
+
+static struct platform_driver bfmtd_driver = {
+	.probe  = bfmtd_probe,
+	.remove = bfmtd_remove,
+	.driver = {
+		.name = "jnx-ptx1kbf-mtd",
+		.owner = THIS_MODULE,
+		.of_match_table = ptx1kbf_mtd_ids,
+	},
+};
+
+module_platform_driver(bfmtd_driver);
+
+MODULE_DESCRIPTION("Juniper Networks PTX1K RCB I2CS Boot FPGA MTD driver");
+MODULE_AUTHOR("Georgi Vlaev <gvlaev@juniper.net>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:jnx-ptx1kbf-mtd");
-- 
1.9.1
