Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159464;
	b=iPc67Le7M5a3QC6J3RSycPeuBRyAW9/VaaY+86oWkK2j0eZ2ZLHVQ7sZeTJ6OwlGYZ58
	 dB4HVP72h2mGOBHulPOzqYUcwiq9D29a/lh0ziuYPbjMlv1M8qjgElZcLP1NSXeAchpdU
	 3/5r7vMZzhuCNcW27aAZXoIS+++XEy0FX8ksqdoKl4BmYfJhjHFUp0rLl/DRVLg4gUxnO
	 Qfb9AkHpK07t2iRWDlqh8QjF855pWoDFuA4i10d4GUokV8+hq6t3XyliFr/edh2qsfkPX
	 BYkBYZ2oLry8+E8VKowYYZqKE3Toes4s8dyLTFRQPO1U1jUpVSRYDo6vLHOKmFIYzcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159464;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=yW8Nv3/bjabR4IeowP0IwE2ZyKAWWY4hGOAY9Ef+3DE=;
	b=fg4tMY4LivO6m9R2pzPFG+TreSHs0wUv3aj+GdoeYB/ycrGsiit5HGrwqEkCtg/fgDmE
	 rjWl3sgUHjlIIg1BGkFn0D78aKweMN5y8gJfQuoYkjMaozCdGQN/OSxnSW0l7fhIzro6G
	 R9cBFlBMrfzSPUaT5+10ag6j4oJs4eL4+CIYOQrtNbbCfgXARps4DHcNkDYZsSsISZqq2
	 aaxZMdpHNEI6u9/tRyVRlXoNv2Iaf8KbzNiJP3KGWqWvHTzErGkVi8OqImPEQnU0qhNpA
	 W2vXGSoNpYcU7S0xYcAbmft03/dfWnPaBJwM6xK7uipZSj4hsAKrJTgxjuyjZrVOVJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MkUznqSp;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6360A260D;
	Fri, 20 Nov 2026 07:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49B6360A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=MkUznqSp
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B9FE3C2F4DF;
	Fri, 20 Nov 2026 07:24:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29C1F6017D;
	Fri, 20 Nov 2026 07:24:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 77FE411BC1185;
	Fri, 20 Nov 2026 08:24:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795159459; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=yW8Nv3/bjabR4IeowP0IwE2ZyKAWWY4hGOAY9Ef+3DE=;
	b=MkUznqSpuuA46VvarcZLd7a6tU5Ne/+wiu8xd+aMz1Gcx2iIaZs45d/V+DHKNZAEKM1lLv
	ZVwDTPMgK8LV2V/chJkY/WLMKqmA00x6t4PW+y1bdixp+teybIbBi2ldLDYoHpj3tNyiRZ
	akWQpj0Qv0HPQfHt9+DXk3QJAgvQtmm2BDp3nc1gAJnbdyPXMmhlP7Jys+8ik3nQqXtGHY
	W/gHCIICU9tmS70swo/E4WbqzzTeMUtsDQlJndGnH/d9+PlFF2OwFCaz10NdIWHxFEhgPh
	aZ/b7jYmZn2uXf6DVLZzQdo3Mu8lQwrG/Uk47Q3jyqYXwEC1R4ZDhvRM6qoLIQ==
From: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Date: Fri, 20 Nov 2026 08:23:55 +0100
Subject: [PATCH v10 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261120-dev-b4-aaeon-mcu-driver-v10-3-a756687e7997@bootlin.com>
References: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
In-Reply-To: <20261120-dev-b4-aaeon-mcu-driver-v10-0-a756687e7997@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes?= <jeremie.dautheribes@bootlin.com>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, mfd@lists.linux.dev, 
 linux-doc@vger.kernel.org, 
 "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Add a driver for the Aaeon SRG-IMX8P embedded controller. This driver
provides the core I2C communication interface and registers child
devices (GPIO and watchdog controllers).

The driver implements a custom regmap bus over I2C to match the MCU's
fixed 3-byte command format [opcode, arg, value]. Register addresses
are encoded as 16-bit values (opcode << 8 | arg) using the
AAEON_MCU_REG() macro defined in the shared header. The regmap
instance is shared with child drivers via dev_get_regmap(). Concurrent
I2C accesses from child drivers are serialized by regmap's built-in
locking.

The MCU wants a STOP between a command and its response, so they are
two separate transfers. Both are issued under the I2C segment lock so
that no other transfer on the same I2C segment can land in between.

I2C transfers use buffers embedded in the driver data and aligned to
ARCH_DMA_MINALIGN rather than stack-allocated ones, as required by I2C
controllers that perform DMA.

Regmap caching is enabled (REGCACHE_MAPLE) with a volatile_reg
callback that marks GPIO input read registers (opcode 0x72) and the
watchdog status register (opcode 0x63, arg 0x02) as volatile. All
other registers written by the driver (GPIO direction,
GPO state, watchdog control) are stable and can be safely cached.

Only those two kinds of registers are readable. Any other opcode is a
command, and the frame sent for a read is the same as the one used to
write it, so reading it, for instance through the regmap debugfs
registers file, would execute the command.

Co-developed-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
---
 MAINTAINERS                   |   2 +
 drivers/mfd/Kconfig           |  11 ++
 drivers/mfd/Makefile          |   1 +
 drivers/mfd/aaeon-mcu.c       | 227 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/aaeon-mcu.h |  46 +++++++++
 5 files changed, 287 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e0027ffa227..7546bc8ab83d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -192,6 +192,8 @@ M:	Thomas Perrot <thomas.perrot@bootlin.com>
 R:	Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
+F:	drivers/mfd/aaeon-mcu.c
+F:	include/linux/mfd/aaeon-mcu.h
 
 AAEON UPBOARD FPGA MFD DRIVER
 M:	Thomas Richard <thomas.richard@bootlin.com>
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 87ed55c155f0..a2405a075346 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -54,6 +54,17 @@ config MFD_ALTERA_SYSMGR
 	  using regmap_mmio accesses for ARM32 parts and SMC calls to
 	  EL3 for ARM64 parts.
 
+config MFD_AAEON_MCU
+	tristate "Aaeon SRG-IMX8P MCU Driver"
+	depends on I2C
+	select MFD_CORE
+	select REGMAP
+	help
+	  Select this option to enable support for the Aaeon SRG-IMX8P
+	  onboard microcontroller (MCU). This driver provides the core
+	  functionality to communicate with the MCU over I2C. The MCU
+	  provides GPIO and watchdog functionality.
+
 config MFD_ACT8945A
 	tristate "Active-semi ACT8945A"
 	select MFD_CORE
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f8101d2a9ce9..166b25638f7f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
 obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
 obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
+obj-$(CONFIG_MFD_AAEON_MCU)	+= aaeon-mcu.o
 obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
 obj-$(CONFIG_MFD_SM501)		+= sm501.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
diff --git a/drivers/mfd/aaeon-mcu.c b/drivers/mfd/aaeon-mcu.c
new file mode 100644
index 000000000000..83a63e0b7373
--- /dev/null
+++ b/drivers/mfd/aaeon-mcu.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Aaeon MCU driver
+ *
+ * Copyright (C) 2026 Bootlin
+ * Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+ * Author: Thomas Perrot <thomas.perrot@bootlin.com>
+ */
+
+#include <linux/cache.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/mfd/aaeon-mcu.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+/* A MCU register address is [opcode, arg] and holds a 1-byte value */
+#define AAEON_MCU_REG_LEN	2
+#define AAEON_MCU_VAL_LEN	1
+/* A MCU command is [opcode, arg, value] */
+#define AAEON_MCU_CMD_LEN	(AAEON_MCU_REG_LEN + AAEON_MCU_VAL_LEN)
+
+struct aaeon_mcu {
+	struct i2c_client *client;
+	/*
+	 * I2C transfer buffers, only used with the regmap lock held. Each
+	 * one is aligned to ARCH_DMA_MINALIGN so that it can be flagged
+	 * I2C_M_DMA_SAFE.
+	 */
+	u8 cmd[AAEON_MCU_CMD_LEN] __aligned(ARCH_DMA_MINALIGN);
+	u8 response[AAEON_MCU_VAL_LEN] __aligned(ARCH_DMA_MINALIGN);
+};
+
+static const struct mfd_cell aaeon_mcu_devs[] = {
+	MFD_CELL_BASIC("aaeon-mcu-wdt", NULL, NULL, 0, 0),
+	MFD_CELL_BASIC("aaeon-mcu-gpio", NULL, NULL, 0, 0),
+};
+
+/*
+ * Custom regmap bus for the Aaeon MCU I2C protocol.
+ *
+ * The MCU uses a fixed 3-byte command format [opcode, arg, value] followed
+ * by a 1-byte response. It requires a STOP condition between the command
+ * write and the response read, so two separate transfers are issued. The
+ * I2C segment lock is held across both so that no other transfer on the
+ * same I2C segment can land between the command and its response. The
+ * regmap lock serialises concurrent accesses from the GPIO and watchdog
+ * child drivers.
+ *
+ * Register addresses are encoded as a 16-bit big-endian value where the
+ * high byte is the opcode and the low byte is the argument, matching the
+ * wire layout produced by regmap for reg_bits=16.
+ */
+
+/*
+ * Send the command held in mcu->cmd and read the 1-byte response into
+ * mcu->response.
+ */
+static int aaeon_mcu_xfer(struct aaeon_mcu *mcu)
+{
+	struct i2c_adapter *adap = mcu->client->adapter;
+	struct i2c_msg msg = {
+		.addr	= mcu->client->addr,
+		.flags	= I2C_M_DMA_SAFE,
+		.buf	= mcu->cmd,
+		.len	= AAEON_MCU_CMD_LEN,
+	};
+	int ret;
+
+	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
+
+	ret = __i2c_transfer(adap, &msg, 1);
+	if (ret == 1) {
+		msg.flags = I2C_M_RD | I2C_M_DMA_SAFE;
+		msg.buf   = mcu->response;
+		msg.len   = AAEON_MCU_VAL_LEN;
+		ret = __i2c_transfer(adap, &msg, 1);
+	}
+
+	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
+
+	if (ret < 0)
+		return ret;
+
+	return ret == 1 ? 0 : -EIO;
+}
+
+static int aaeon_mcu_regmap_write(void *context, const void *data, size_t count)
+{
+	struct aaeon_mcu *mcu = context;
+
+	/*
+	 * use_single_write guarantees one register per call: a 2-byte
+	 * address followed by a 1-byte value.
+	 */
+	if (count != AAEON_MCU_CMD_LEN)
+		return -EINVAL;
+
+	memcpy(mcu->cmd, data, count);
+
+	/* The MCU always sends a response byte after each command; discard it. */
+	return aaeon_mcu_xfer(mcu);
+}
+
+static int aaeon_mcu_regmap_read(void *context, const void *reg_buf,
+				 size_t reg_size, void *val_buf, size_t val_size)
+{
+	struct aaeon_mcu *mcu = context;
+	int ret;
+
+	/*
+	 * use_single_read guarantees one register per call: a 2-byte address
+	 * and a 1-byte value.
+	 */
+	if (reg_size != AAEON_MCU_REG_LEN || val_size != AAEON_MCU_VAL_LEN)
+		return -EINVAL;
+
+	/*
+	 * reg_buf holds the big-endian register address [opcode, arg].
+	 * Append a trailing 0x00 to form the full MCU command.
+	 */
+	memcpy(mcu->cmd, reg_buf, AAEON_MCU_REG_LEN);
+	mcu->cmd[AAEON_MCU_REG_LEN] = 0x00;
+
+	ret = aaeon_mcu_xfer(mcu);
+	if (ret)
+		return ret;
+
+	/*
+	 * val_buf is owned by the regmap caller and is not necessarily
+	 * DMA-safe, so go through the driver's response buffer.
+	 */
+	*(u8 *)val_buf = *mcu->response;
+
+	return 0;
+}
+
+static const struct regmap_bus aaeon_mcu_regmap_bus = {
+	.write = aaeon_mcu_regmap_write,
+	.read  = aaeon_mcu_regmap_read,
+};
+
+static bool aaeon_mcu_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * GPIO input registers are driven by external signals and can change
+	 * at any time without CPU involvement, always read from hardware.
+	 *
+	 * The watchdog status register reflects hardware state and can change
+	 * autonomously.
+	 *
+	 * All other registers are written by the driver and their values are
+	 * stable, so they can be safely cached.
+	 */
+	if (AAEON_MCU_REG_OPCODE(reg) == AAEON_MCU_READ_GPIO_OPCODE)
+		return true;
+	if (reg == AAEON_MCU_WDT_STATUS_REG)
+		return true;
+	return false;
+}
+
+static bool aaeon_mcu_readable_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * Every opcode but the GPIO input read and the watchdog status is a
+	 * command: the frame sent for a read is identical to the one used to
+	 * write it, so reading such a register would execute the command.
+	 * Only the registers reflecting hardware state may be read.
+	 */
+	return aaeon_mcu_volatile_reg(dev, reg);
+}
+
+static const struct regmap_config aaeon_mcu_regmap_config = {
+	.reg_bits          = 16,
+	.val_bits          = 8,
+	.reg_format_endian = REGMAP_ENDIAN_BIG,
+	.max_register      = AAEON_MCU_MAX_REGISTER,
+	.readable_reg      = aaeon_mcu_readable_reg,
+	.volatile_reg      = aaeon_mcu_volatile_reg,
+	.cache_type        = REGCACHE_MAPLE,
+	.use_single_write  = true,
+	.use_single_read   = true,
+};
+
+static int aaeon_mcu_probe(struct i2c_client *client)
+{
+	struct aaeon_mcu *ddata;
+	struct regmap *regmap;
+
+	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->client = client;
+
+	regmap = devm_regmap_init(&client->dev, &aaeon_mcu_regmap_bus,
+				  ddata, &aaeon_mcu_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "failed to initialize regmap\n");
+
+	return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
+				    aaeon_mcu_devs, ARRAY_SIZE(aaeon_mcu_devs),
+				    NULL, 0, NULL);
+}
+
+static const struct of_device_id aaeon_mcu_of_match[] = {
+	{ .compatible = "aaeon,srg-imx8p-mcu" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, aaeon_mcu_of_match);
+
+static struct i2c_driver aaeon_mcu_driver = {
+	.driver = {
+		.name = "aaeon-mcu",
+		.of_match_table = aaeon_mcu_of_match,
+	},
+	.probe = aaeon_mcu_probe,
+};
+module_i2c_driver(aaeon_mcu_driver);
+
+MODULE_DESCRIPTION("Aaeon MCU Driver");
+MODULE_AUTHOR("Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/aaeon-mcu.h b/include/linux/mfd/aaeon-mcu.h
new file mode 100644
index 000000000000..561134b2fc7f
--- /dev/null
+++ b/include/linux/mfd/aaeon-mcu.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Aaeon MCU driver definitions
+ *
+ * Copyright (C) 2026 Bootlin
+ * Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
+ * Author: Thomas Perrot <thomas.perrot@bootlin.com>
+ */
+
+#ifndef __LINUX_MFD_AAEON_MCU_H
+#define __LINUX_MFD_AAEON_MCU_H
+
+/*
+ * MCU register address: the high byte is the command opcode, the low
+ * byte is the argument.  This matches the 3-byte wire format
+ * [opcode, arg, value] used by the MCU I2C protocol.
+ */
+#define AAEON_MCU_REG(op, arg)		(((op) << 8) | (arg))
+
+/* Command opcode of a MCU register address */
+#define AAEON_MCU_REG_OPCODE(reg)	((reg) >> 8)
+
+/*
+ * Opcode for GPIO input reads. These registers are volatile, their values
+ * are driven by external signals and can change without CPU involvement.
+ * Used by the MFD driver's volatile_reg callback to bypass the regmap cache.
+ */
+#define AAEON_MCU_READ_GPIO_OPCODE	0x72
+
+/*
+ * Opcode for watchdog control and status commands, the argument selects
+ * the command. The status register reflects hardware state and is volatile.
+ */
+#define AAEON_MCU_CONTROL_WDT_OPCODE	0x63
+#define AAEON_MCU_WDT_STOP_REG		AAEON_MCU_REG(AAEON_MCU_CONTROL_WDT_OPCODE, 0x00)
+#define AAEON_MCU_WDT_START_REG		AAEON_MCU_REG(AAEON_MCU_CONTROL_WDT_OPCODE, 0x01)
+#define AAEON_MCU_WDT_STATUS_REG	AAEON_MCU_REG(AAEON_MCU_CONTROL_WDT_OPCODE, 0x02)
+
+/*
+ * Highest register address in the MCU register map.
+ * The WRITE_GPIO opcode (0x77) with the highest GPIO argument (0x0B = 11,
+ * i.e. MAX_GPIOS - 1) produces the largest encoded address.
+ */
+#define AAEON_MCU_MAX_REGISTER		AAEON_MCU_REG(0x77, 0x0B)
+
+#endif /* __LINUX_MFD_AAEON_MCU_H */

-- 
2.56.0

