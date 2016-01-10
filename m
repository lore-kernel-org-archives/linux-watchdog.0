Return-path: <richard.dorsch@gmail.com>
From: richard.dorsch@gmail.com
To: linux-kernel@vger.kernel.org
Cc: lm-sensors@lm-sensors.org,
	linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	lee.jones@linaro.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	wim@iguana.be,
	jo.sunga@advantech.com,
	Richard Vidal-Dorsch <richard.dorsch@gmail.com>
Subject: [PATCH v3 4/6] Add Advantech iManager I2C driver
Date: Sun, 10 Jan 2016 15:31:13 -0800
Message-Id: <1452468675-5827-5-git-send-email-richard.dorsch@gmail.com>
In-Reply-To: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>

Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
---
 Documentation/i2c/busses/i2c-imanager |  48 ++++
 drivers/i2c/busses/Kconfig            |  11 +
 drivers/i2c/busses/Makefile           |   2 +
 drivers/i2c/busses/imanager-ec-i2c.c  | 466 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/imanager-i2c.c     | 239 +++++++++++++++++
 include/linux/mfd/imanager/i2c.h      |  55 ++++
 6 files changed, 821 insertions(+)
 create mode 100644 Documentation/i2c/busses/i2c-imanager
 create mode 100644 drivers/i2c/busses/imanager-ec-i2c.c
 create mode 100644 drivers/i2c/busses/imanager-i2c.c
 create mode 100644 include/linux/mfd/imanager/i2c.h

diff --git a/Documentation/i2c/busses/i2c-imanager b/Documentation/i2c/busses/i2c-imanager
new file mode 100644
index 0000000..d149fbf
--- /dev/null
+++ b/Documentation/i2c/busses/i2c-imanager
@@ -0,0 +1,48 @@
+Kernel driver imanager_i2c
+==========================
+
+This platform driver provides support for iManager I2C/SMBus.
+
+This driver depends on imanager (mfd).
+
+Module Parameters
+-----------------
+
+* bus_frequency (unsigned short)
+Set desired bus frequency. Valid values (kHz) are:
+  50  Slow
+ 100  Standard (default)
+ 400  Fast
+
+
+Description
+-----------
+
+The Advantech iManager provides up to four SMBus controllers. One of them
+is configured for I2C compatibility.
+
+
+Process Call Support
+--------------------
+
+Not supported.
+
+
+I2C Block Read Support
+----------------------
+
+I2C block read is supported.
+
+
+SMBus 2.0 Support
+-----------------
+
+Several SMBus 2.0 features are supported.
+No PEC support.
+
+
+Interrupt Support
+-----------------
+
+No interrupt support available
+
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 7b0aa82..4c401a4 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -42,6 +42,17 @@ config I2C_ALI15X3
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-ali15x3.
 
+config I2C_IMANAGER
+	tristate "Advantech iManager I2C Interface"
+	depends on MFD_IMANAGER
+	help
+	  This enables support for Advantech iManager I2C of some
+	  Advantech SOM, MIO, AIMB, and PCM modules/boards.
+	  Requires mfd-core and imanager-core to function properly.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called i2c-imanager.
+
 config I2C_AMD756
 	tristate "AMD 756/766/768/8111 and nVidia nForce"
 	depends on PCI
diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
index 37f2819..da76404 100644
--- a/drivers/i2c/busses/Makefile
+++ b/drivers/i2c/busses/Makefile
@@ -15,6 +15,8 @@ obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_ISCH)		+= i2c-isch.o
 obj-$(CONFIG_I2C_ISMT)		+= i2c-ismt.o
+i2c-imanager-objs		:= imanager-i2c.o imanager-ec-i2c.o
+obj-$(CONFIG_I2C_IMANAGER)	+= i2c-imanager.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_NFORCE2_S4985)	+= i2c-nforce2-s4985.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
diff --git a/drivers/i2c/busses/imanager-ec-i2c.c b/drivers/i2c/busses/imanager-ec-i2c.c
new file mode 100644
index 0000000..f8839dc
--- /dev/null
+++ b/drivers/i2c/busses/imanager-ec-i2c.c
@@ -0,0 +1,466 @@
+/*
+ * Advantech iManager I2C bus core
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/bug.h>
+#include <linux/io.h>
+#include <linux/delay.h>
+#include <linux/string.h>
+#include <linux/byteorder/generic.h>
+#include <linux/mfd/imanager/ec.h>
+#include <linux/mfd/imanager/i2c.h>
+
+#define I2C_SMBUS_BLOCK_SIZE	32
+
+#define EVAL_WR_SIZE(x)	\
+		(x < I2C_SMBUS_BLOCK_SIZE ? x : I2C_SMBUS_BLOCK_SIZE - 1)
+#define EVAL_RD_SIZE(x) \
+		(x && (x <= I2C_SMBUS_BLOCK_SIZE) ? x : I2C_SMBUS_BLOCK_SIZE)
+
+#define EC_HWRAM_OFFSET_STATUS	0UL
+
+#define I2C_ERR_PROTO		0x19UL
+#define I2C_ERR_TIMEOUT		0x18UL
+#define I2C_ERR_ACCESS		0x17UL
+#define I2C_ERR_UNKNOWN		0x13UL
+#define I2C_ERR_ADDR_NACK	0x10UL
+
+#define EC_SMB_DID(N)		(0x28 + N)
+
+struct ec_i2c_status {
+	u32 error	: 7;
+	u32 complete	: 1;
+};
+
+static const struct imanager_i2c_device *i2c;
+
+static int i2c_core_eval_status(u8 _status)
+{
+	struct ec_i2c_status *status = (struct ec_i2c_status *)&_status;
+	int err = 0;
+
+	switch (status->error) {
+	case 0:
+		break;
+	case I2C_ERR_ADDR_NACK:
+		err = -ENODEV;
+		break;
+	case I2C_ERR_ACCESS:
+	case I2C_ERR_UNKNOWN:
+		err = -EAGAIN;
+		break;
+	case I2C_ERR_TIMEOUT:
+		err = -ETIME;
+		break;
+	case I2C_ERR_PROTO:
+		err = -EPROTO;
+		break;
+	default:
+		pr_err("Undefined status code 0x%02X\n", status->error);
+		err = -EIO;
+		break;
+	}
+
+	return err;
+}
+
+static inline int i2c_send_message(u8 cmd, u8 param, struct ec_message *msg)
+{
+	int err;
+
+	err = imanager_msg_write(cmd, param, msg);
+	if (err)
+		return i2c_core_eval_status(err);
+
+	return 0;
+}
+
+static int i2c_core_blk_wr_rw_combined(u8 proto, struct ec_message *msg)
+{
+	int err;
+
+	if (WARN_ON(!msg))
+		return -EINVAL;
+
+	err = imanager_wait_proc_complete(EC_HWRAM_OFFSET_STATUS, 0);
+	if (err)
+		return err;
+
+	err = i2c_send_message(proto, i2c->i2coem->did, msg);
+	if (err)
+		return err;
+
+	if (msg->rlen) {
+		if (msg->rlen == 1)
+			return msg->u.data[0];
+		else if (msg->rlen == 2)
+			return (msg->u.data[1] << 8) | msg->u.data[0];
+		else
+			return msg->rlen;
+	}
+
+	return 0;
+}
+
+/* Write-Read and Read-Write wrappers */
+static inline int i2c_core_wr_combined(struct ec_message *msg)
+{
+	return i2c_core_blk_wr_rw_combined(EC_CMD_I2C_WR, msg);
+}
+
+static inline int i2c_core_rw_combined(struct ec_message *msg)
+{
+	return i2c_core_blk_wr_rw_combined(EC_CMD_I2C_RW, msg);
+}
+
+/*
+ * iManager I2C core API
+ */
+int i2c_core_write_quick(u16 addr)
+{
+	struct ec_message msg = {
+		.rlen = 0,
+		.wlen = sizeof(struct ec_message_header),
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = 0,
+				.wlen = 1,
+			},
+		},
+	};
+
+	return i2c_core_wr_combined(&msg);
+}
+
+int i2c_core_read_byte(u16 addr)
+{
+	struct ec_message msg = {
+		.rlen = 1,
+		.wlen = sizeof(struct ec_message_header),
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = 1,
+				.wlen = 0,
+			},
+		},
+	};
+
+	return i2c_core_rw_combined(&msg);
+}
+
+int i2c_core_write_byte(u16 addr, u8 cmd)
+{
+	struct ec_message msg = {
+		.rlen = 1,
+		.wlen = sizeof(struct ec_message_header),
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = 1,
+				.wlen = 1,
+				.cmd  = cmd,
+			},
+		},
+	};
+
+	return i2c_core_wr_combined(&msg);
+}
+
+int i2c_core_read_byte_data(u16 addr, u8 cmd)
+{
+	struct ec_message msg = {
+		.rlen = 1,
+		.wlen = sizeof(struct ec_message_header),
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = 1,
+				.wlen = 1,
+				.cmd  = cmd,
+			},
+		},
+	};
+
+	return i2c_core_wr_combined(&msg);
+}
+
+int i2c_core_write_byte_data(u16 addr, u8 cmd, u8 value)
+{
+	struct ec_message msg = {
+		.rlen = 1,
+		.wlen = sizeof(struct ec_message_header) + 1,
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = 0,
+				.wlen = 2,
+				.cmd  = cmd,
+			},
+			.smb.data[0] = value,
+		},
+	};
+
+	return i2c_core_wr_combined(&msg);
+}
+
+int i2c_core_read_word_data(u16 addr, u8 cmd)
+{
+	struct ec_message msg = {
+		.rlen = 2,
+		.wlen = sizeof(struct ec_message_header),
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = 2,
+				.wlen = 1,
+				.cmd  = cmd,
+			},
+		},
+	};
+
+	return i2c_core_wr_combined(&msg);
+}
+
+int i2c_core_write_word_data(u16 addr, u8 cmd, u16 value)
+{
+	struct ec_message msg = {
+		.rlen = 1,
+		.wlen = sizeof(struct ec_message_header) + 2,
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = 0,
+				.wlen = 3,
+				.cmd  = cmd,
+			},
+			.smb.data[0] = LOBYTE16(value),
+			.smb.data[1] = HIBYTE16(value),
+		},
+	};
+
+	return i2c_core_wr_combined(&msg);
+}
+
+int i2c_core_write_block_data(u16 addr, u8 cmd, u8 *buf)
+{
+	int i;
+	struct ec_message msg = {
+		.rlen = 1,
+		.wlen = sizeof(struct ec_message_header) +
+			EVAL_WR_SIZE(buf[0]),
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = 0,
+				.wlen = 1 + EVAL_WR_SIZE(buf[0]),
+				.cmd  = cmd,
+			},
+		},
+	};
+
+	if ((buf[0] == 0) || (buf[0] >= I2C_MAX_WRITE_BYTES)) {
+		pr_err("Invalid I2C write length %d\n", buf[0]);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < EVAL_WR_SIZE(buf[0]); i++)
+		msg.u.data[i + sizeof(struct ec_message_header)] = buf[i + 1];
+
+	return i2c_core_wr_combined(&msg);
+}
+
+int i2c_core_read_block_data(u16 addr, u8 cmd, u8 *buf)
+{
+	int i;
+	int ret;
+	struct ec_message msg = {
+		.rlen = EVAL_RD_SIZE(buf[0]),
+		.wlen = sizeof(struct ec_message_header),
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = EVAL_RD_SIZE(buf[0]),
+				.wlen = 1,
+				.cmd  = cmd,
+			},
+		},
+	};
+
+	/*
+	 * If buf[0] == 0 EC will read I2C_MAX_READ_BYTES
+	 */
+	ret = i2c_core_wr_combined(&msg);
+	if (ret < 0) {
+		pr_err("I2C transaction failed\n");
+		return ret;
+	}
+
+	buf[0] = ret;
+	for (i = 0; i < ret; i++)
+		buf[i + 1] = msg.u.data[i];
+
+	return 0;
+}
+
+int i2c_core_read_i2c_block_data(u16 addr, u8 cmd, u8 *buf)
+{
+	int i;
+	int ret;
+	struct ec_message msg = {
+		.rlen = EVAL_RD_SIZE(buf[0]),
+		.wlen = sizeof(struct ec_message_header),
+		.u = {
+			.smb.hdr = {
+				.addr_low  = LOADDR16(addr),
+				.addr_high = HIADDR16(addr),
+				.rlen = EVAL_RD_SIZE(buf[0]),
+				.wlen = 1,
+				.cmd  = cmd,
+			},
+		},
+	};
+
+	if ((buf[0] == 0) || (buf[0] > I2C_MAX_READ_BYTES)) {
+		pr_err("Invalid I2C read length\n");
+		return -EINVAL;
+	}
+
+	ret = i2c_core_wr_combined(&msg);
+	if (ret < 0) {
+		pr_err("I2C transaction failed\n");
+		return ret;
+	}
+
+	buf[0] = ret;
+	for (i = 0; i < ret; i++)
+		buf[i + 1] = msg.u.data[i];
+
+	return 0;
+}
+
+int i2c_core_write_i2c_block_data(u16 addr, u8 cmd, u8 *buf)
+{
+	if (WARN_ON(!buf))
+		return -EINVAL;
+
+	return i2c_core_write_block_data(addr, cmd, buf);
+}
+
+int i2c_core_smb_get_freq(u32 bus_id)
+{
+	int ret = 0, f;
+	int freq_id, freq;
+
+	if (WARN_ON(bus_id > I2C_OEM_1))
+		return -EINVAL;
+
+	switch (i2c->ecdev->id) {
+	case IT8518:
+	case IT8528:
+		ret = imanager_read_word(EC_CMD_SMB_FREQ_RD,
+					 EC_SMB_DID(bus_id));
+		if (ret < 0) {
+			pr_err("Failed to get bus frequency\n");
+			return ret;
+		}
+
+		freq_id = HIBYTE16(ret);
+		f = LOBYTE16(ret);
+		switch (freq_id) {
+		case 0:
+			freq = f;
+			break;
+		case 1:
+			freq = 50;
+			break;
+		case 2:
+			freq = 100;
+			break;
+		case 3:
+			freq = 400;
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		pr_err("EC version not supported!\n");
+		return -ENODEV;
+	}
+
+	return freq;
+}
+
+int i2c_core_smb_set_freq(u32 bus_id, u32 freq)
+{
+	int err;
+	u16 val;
+
+	if (WARN_ON(bus_id > I2C_OEM_1))
+		return -EINVAL;
+
+	switch (i2c->ecdev->id) {
+	case IT8518:
+	case IT8528:
+		switch (freq) {
+		case 50:
+			val = 0x0100;
+			break;
+		case 100:
+			val = 0x0200;
+			break;
+		case 400:
+			val = 0x0300;
+			break;
+		default:
+			if (freq < 50)
+				val = freq;
+			else
+				return -EINVAL;
+		}
+
+		err = imanager_write_word(EC_CMD_SMB_FREQ_WR,
+					  EC_SMB_DID(bus_id), val);
+		if (err) {
+			pr_err("Failed to set I2C bus frequency\n");
+			return err;
+		}
+		break;
+	default:
+		pr_err("EC version not supported!\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+int i2c_core_init(void)
+{
+	i2c = imanager_get_i2c_device();
+	if (!i2c)
+		return -ENODEV;
+
+	return 0;
+}
+
diff --git a/drivers/i2c/busses/imanager-i2c.c b/drivers/i2c/busses/imanager-i2c.c
new file mode 100644
index 0000000..932cba2
--- /dev/null
+++ b/drivers/i2c/busses/imanager-i2c.c
@@ -0,0 +1,239 @@
+/*
+ * Advantech iManager I2C bus driver
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <linux/i2c.h>
+#include <linux/mfd/imanager/core.h>
+#include <linux/mfd/imanager/i2c.h>
+
+static uint bus_frequency = 100;
+module_param(bus_frequency, uint, 0);
+MODULE_PARM_DESC(bus_frequency,
+	"I2C bus frequency [50, 100, 400]kHz (defaults to 100kHz)");
+
+struct imanager_i2c_data {
+	struct imanager_device_data *idev;
+	struct i2c_adapter adapter;
+};
+
+static int imanager_smb_access(struct i2c_adapter *adap, u16 addr,
+	unsigned short flags, char read_write, u8 command,
+	int size, union i2c_smbus_data *smb_data)
+{
+	struct imanager_i2c_data *data = i2c_get_adapdata(adap);
+	struct device *dev = data->adapter.dev.parent;
+	int ret = 0;
+	int val = 0;
+
+	if (!data)
+		return -ENODEV;
+
+	addr <<= 1;
+
+	mutex_lock(&data->idev->lock);
+
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+		ret = i2c_core_write_quick(addr);
+		break;
+	case I2C_SMBUS_BYTE:
+		if (read_write == I2C_SMBUS_WRITE) /* NOT tested */
+			val = i2c_core_write_byte(addr, command);
+		else
+			val = i2c_core_read_byte(addr);
+
+		if (val < 0)
+			ret = val;
+		else
+			smb_data->byte = val;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		if (read_write == I2C_SMBUS_WRITE)
+			val = i2c_core_write_byte_data(addr, command,
+				smb_data->byte);
+		else
+			val = i2c_core_read_byte_data(addr, command);
+
+		if (val < 0)
+			ret = val;
+		else
+			smb_data->byte = val;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		if (read_write == I2C_SMBUS_WRITE)
+			val = i2c_core_write_word_data(addr, command,
+				smb_data->word);
+		else
+			val = i2c_core_read_word_data(addr, command);
+
+		if (val < 0)
+			ret = val;
+		else
+			smb_data->word = val;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		if (read_write == I2C_SMBUS_WRITE)
+			ret = i2c_core_write_block_data(addr, command,
+				smb_data->block);
+		else
+			ret = i2c_core_read_block_data(addr, command,
+				smb_data->block);
+		break;
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		if (read_write == I2C_SMBUS_WRITE)
+			ret = i2c_core_write_i2c_block_data(addr, command,
+				smb_data->block);
+		else
+			ret = i2c_core_read_i2c_block_data(addr, command,
+				smb_data->block);
+		break;
+	default:
+		dev_err(dev, "Unsupported SMB transaction %d\n", size);
+		ret = -EOPNOTSUPP;
+	}
+
+	mutex_unlock(&data->idev->lock);
+
+	return ret;
+}
+
+static int imanager_i2c_access(struct i2c_adapter *adap, struct i2c_msg *msg,
+			int num)
+{
+	struct imanager_i2c_data *data = i2c_get_adapdata(adap);
+	struct device *dev = data->adapter.dev.parent;
+
+	/*
+	 * To be implemented
+	 */
+
+	dev_info(dev, "i2c_access() is not yet implemented. msg=%p, num=%d\n",
+		 msg, num);
+
+	return 0;
+}
+
+static u32 imanager_smb_i2c_func(struct i2c_adapter *adapter)
+{
+	return	I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+		I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+		I2C_FUNC_SMBUS_BLOCK_DATA |
+		I2C_FUNC_SMBUS_I2C_BLOCK | I2C_FUNC_I2C;
+}
+
+static const struct i2c_algorithm imanager_algorithm = {
+	.smbus_xfer     = imanager_smb_access,
+	.master_xfer    = imanager_i2c_access,
+	.functionality  = imanager_smb_i2c_func,
+};
+
+static int imanager_i2c_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_device_data *idev = dev_get_drvdata(dev->parent);
+	struct imanager_i2c_data *i2c;
+	int ret;
+
+	if (!idev) {
+		dev_err(dev, "Invalid platform data\n");
+		return -EINVAL;
+	}
+
+	ret = i2c_core_init();
+	if (ret) {
+		dev_err(dev, "Failed to initialize I2C core\n");
+		return -EIO;
+	}
+
+	if (bus_frequency > 100)
+		bus_frequency = 400;
+	else if (bus_frequency < 50)
+		bus_frequency = 50;
+	else
+		bus_frequency = 100;
+
+	ret = i2c_core_smb_set_freq(I2C_OEM_1, bus_frequency);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set I2C bus frequency to %d kHz\n",
+				bus_frequency);
+		return ret;
+	}
+
+	ret = i2c_core_smb_get_freq(I2C_OEM_1);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get I2C bus frequency\n");
+		return ret;
+	}
+	bus_frequency = ret;
+	dev_info(dev, "Bus frequency: %d kHz\n", bus_frequency);
+
+	i2c = devm_kzalloc(dev, sizeof(struct imanager_i2c_data), GFP_KERNEL);
+	if (!i2c)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, i2c);
+	i2c_set_adapdata(&i2c->adapter, i2c);
+
+	i2c->idev = idev;
+
+	i2c->adapter.owner	= THIS_MODULE;
+	i2c->adapter.class	= I2C_CLASS_HWMON | I2C_CLASS_SPD;
+	i2c->adapter.algo	= &imanager_algorithm;
+
+	/* set up the sysfs linkage to our parent device */
+	i2c->adapter.dev.parent = dev;
+
+	/* Retry up to 3 times on lost arbitration */
+	i2c->adapter.retries = 3;
+
+	snprintf(i2c->adapter.name, sizeof(i2c->adapter.name),
+		"iManager I2C driver");
+
+	ret = i2c_add_adapter(&i2c->adapter);
+	if (ret) {
+		dev_err(dev, "Failed to add SMBus adapter\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int imanager_i2c_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imanager_i2c_data *i2c = dev_get_drvdata(dev);
+
+	i2c_del_adapter(&i2c->adapter);
+	i2c_set_adapdata(&i2c->adapter, NULL);
+
+	return 0;
+}
+
+static struct platform_driver imanager_i2c_driver = {
+	.driver = {
+		.name  = "imanager_i2c",
+	},
+	.probe	= imanager_i2c_probe,
+	.remove	= imanager_i2c_remove,
+};
+
+module_platform_driver(imanager_i2c_driver);
+
+MODULE_DESCRIPTION("Advantech iManager I2C Driver");
+MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:imanager_i2c");
diff --git a/include/linux/mfd/imanager/i2c.h b/include/linux/mfd/imanager/i2c.h
new file mode 100644
index 0000000..a8ef6c2
--- /dev/null
+++ b/include/linux/mfd/imanager/i2c.h
@@ -0,0 +1,55 @@
+/*
+ * Advantech iManager I2C bus core
+ *
+ * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
+ * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __I2C_H__
+#define __I2C_H__
+
+#include <linux/types.h>
+
+#define I2C_MAX_READ_BYTES	32
+#define I2C_MAX_WRITE_BYTES	32
+
+/* Only for setting SMBus frequency */
+enum smb_bus_id {
+	SMB_OEM_0,
+	SMB_OEM_1,
+	SMB_OEM_2,
+	SMB_EEPROM,
+	SMB_TH_0,
+	SMB_TH_1,
+	SMB_SECURITY_EEPROM,
+	I2C_OEM_1,
+};
+
+int i2c_core_init(void);
+
+int i2c_core_write_quick(u16 addr);
+
+int i2c_core_read_byte(u16 addr);
+int i2c_core_write_byte(u16 addr, u8 cmd);
+
+int i2c_core_write_byte_data(u16 addr, u8 cmd, u8 value);
+int i2c_core_read_byte_data(u16 addr, u8 cmd);
+
+int i2c_core_write_word_data(u16 addr, u8 cmd, u16 value);
+int i2c_core_read_word_data(u16 addr, u8 cmd);
+
+int i2c_core_write_block_data(u16 addr, u8 cmd, u8 *buf);
+int i2c_core_read_block_data(u16 addr, u8 cmd, u8 *buf);
+
+int i2c_core_write_i2c_block_data(u16 addr, u8 cmd, u8 *buf);
+int i2c_core_read_i2c_block_data(u16 addr, u8 cmd, u8 *buf);
+
+int i2c_core_smb_get_freq(u32 bus_id);
+int i2c_core_smb_set_freq(u32 bus_id, u32 freq);
+
+#endif
-- 
2.7.0
