Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E2947ACF4;
	Thu,  6 Aug 2026 14:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027523; cv=none; b=N9r98t/lIx3kemt0AROf7Rry2zUb0tcEGkJctJNnIFl51pIvI43Fo12jZ8SgsgnX/hlrtLhEvdnqWX1fkr44+qRCwtVnLsoqqdUc6GAW5uCG0blbCXSuH10t350dnMVsz21K4/Fqf5U6NX4JFpHHqOFlEcgBO0VJoR2iXkykXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027523; c=relaxed/simple;
	bh=hdKqq0A917bebNCMD3P/xl6fiIr78cXlP5rJIF0CdHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NehCQYkYMUsKsY1sPJb9UbzOtfJmfSK/1asskF1mFHcY+hDSYk86p/aAv0IMQcUuSsy1ONfSE/eCH4OQ4iTACUtEn1qIg9aUCYtOnoaY5mc5nXwl80U9iZnZuinVrAwDWwZoxisyGO42lvmFgHBtSV80x9cXcT+KlJbUfqVbYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzXedx8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzXedx8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E480B1F00A3A;
	Thu,  6 Aug 2026 14:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786027520;
	bh=sA/Au7S/KrYZzUieAPhYekBhJPW6eueCL/Esuuos5kM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZzXedx8J3D5ItKDFR3JV0Ha2BBDUL2e0R6ZHMi039of9q9Whqg2r4vwHMYAJQNMOi
	 fOj//0QK8oQos9jPMkz4thYOxSQsHm6WZ0WqtMNEMbDwjEQVyXESBh6jCZDXbdUpqV
	 WsCgUKKCe3494BIX6I2dlCXHgk5MCOHAezwbwklgupSpamKUEYVvAGNfkP7ihHYKUe
	 +Ez537pDOj+sTUerHn4kLRuTWDLefS/ZfXhoY98didO6AqCpuhfh0n6WgKxR2f2M3q
	 /mbyPXC8m5/KA7Z5eprr3AEcAqeFKnVI4p9DCUP2L17JN0qxrenBJ8A+Nx6qUpV52O
	 bnPLdBGhhNGUA==
Date: Thu, 6 Aug 2026 15:45:14 +0100
From: Lee Jones <lee@kernel.org>
To: "Thomas Perrot (Schneider Electric)" <thomas.perrot@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	=?iso-8859-1?Q?J=E9r=E9mie?= Dautheribes <jeremie.dautheribes@bootlin.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v8 3/5] mfd: aaeon: Add SRG-IMX8P MCU driver
Message-ID: <20260806144514.GR2869284@google.com>
References: <20260731-dev-b4-aaeon-mcu-driver-v8-0-9ab00e80df2a@bootlin.com>
 <20260731-dev-b4-aaeon-mcu-driver-v8-3-9ab00e80df2a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731-dev-b4-aaeon-mcu-driver-v8-3-9ab00e80df2a@bootlin.com>

/* Sashiko Automation: Issues Found (4 Findings) */

Please review, explain or fix the Sashiko review(s).

If this is a set, this request includes the other patches too.

On Fri, 31 Jul 2026, Thomas Perrot (Schneider Electric) wrote:

> Add Multi-Function Device (MFD) driver for the Aaeon SRG-IMX8P
> embedded controller. This driver provides the core I2C communication
> interface and registers child devices (GPIO and watchdog controllers).
> 
> The driver implements a custom regmap bus over I2C to match the MCU's
> fixed 3-byte command format [opcode, arg, value]. Register addresses
> are encoded as 16-bit values (opcode << 8 | arg) using the
> AAEON_MCU_REG() macro defined in the shared header. The regmap
> instance is shared with child drivers via dev_get_regmap(). Concurrent
> I2C accesses from child drivers are serialized by regmap's built-in
> locking.
> 
> I2C transfers use heap-allocated DMA-safe buffers rather than
> stack-allocated ones, as required by I2C controllers that perform DMA.
> 
> Regmap caching is enabled (REGCACHE_MAPLE) with a volatile_reg
> callback that marks GPIO input read registers (opcode 0x72) and the
> watchdog status register (opcode 0x63, arg 0x02) as volatile. All
> other registers written by the driver (GPIO direction,
> GPO state, watchdog control) are stable and can be safely cached.
> 
> Co-developed-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
> Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
> Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
> ---
>  MAINTAINERS                   |   2 +
>  drivers/mfd/Kconfig           |  11 +++
>  drivers/mfd/Makefile          |   1 +
>  drivers/mfd/aaeon-mcu.c       | 207 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/aaeon-mcu.h |  40 ++++++++
>  5 files changed, 261 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea9d55f76f35..f91b6a1826d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -191,6 +191,8 @@ M:	Thomas Perrot <thomas.perrot@bootlin.com>
>  R:	Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
> +F:	drivers/mfd/aaeon-mcu.c
> +F:	include/linux/mfd/aaeon-mcu.h
>  
>  AAEON UPBOARD FPGA MFD DRIVER
>  M:	Thomas Richard <thomas.richard@bootlin.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index aace5766b38a..66f2e7757748 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1561,6 +1561,17 @@ config ABX500_CORE
>  	  remain unchanged when IC changes. Binding of the functions to
>  	  actual register access is done by the IC core driver.
>  
> +config MFD_AAEON_MCU
> +	tristate "Aaeon SRG-IMX8P MCU Driver"
> +	depends on I2C
> +	select MFD_CORE
> +	select REGMAP
> +	help
> +	  Select this option to enable support for the Aaeon SRG-IMX8P
> +	  onboard microcontroller (MCU). This driver provides the core
> +	  functionality to communicate with the MCU over I2C. The MCU
> +	  provides GPIO and watchdog functionality.
> +
>  config AB8500_CORE
>  	bool "ST-Ericsson AB8500 Mixed Signal Power Management chip"
>  	depends on ABX500_CORE && MFD_DB8500_PRCMU
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e75e8045c28a..34db5b033584 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_MFD_88PM860X)	+= 88pm860x.o
>  obj-$(CONFIG_MFD_88PM800)	+= 88pm800.o 88pm80x.o
>  obj-$(CONFIG_MFD_88PM805)	+= 88pm805.o 88pm80x.o
>  obj-$(CONFIG_MFD_88PM886_PMIC)	+= 88pm886.o
> +obj-$(CONFIG_MFD_AAEON_MCU)	+= aaeon-mcu.o
>  obj-$(CONFIG_MFD_ACT8945A)	+= act8945a.o
>  obj-$(CONFIG_MFD_SM501)		+= sm501.o
>  obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835-pm.o
> diff --git a/drivers/mfd/aaeon-mcu.c b/drivers/mfd/aaeon-mcu.c
> new file mode 100644
> index 000000000000..c06c99d02d64
> --- /dev/null
> +++ b/drivers/mfd/aaeon-mcu.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Aaeon MCU driver
> + *
> + * Copyright (C) 2026 Bootlin
> + * Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
> + * Author: Thomas Perrot <thomas.perrot@bootlin.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mfd/aaeon-mcu.h>
> +#include <linux/mfd/core.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +struct aaeon_mcu {
> +	struct i2c_client *client;
> +	u8 *cmd;      /* DMA-safe 3-byte write buffer [opcode, arg, value] */
> +	u8 *response; /* DMA-safe 1-byte read buffer for MCU acknowledgment */
> +};
> +
> +static const struct mfd_cell aaeon_mcu_devs[] = {
> +	MFD_CELL_BASIC("aaeon-mcu-wdt", NULL, NULL, 0, 0),
> +	MFD_CELL_BASIC("aaeon-mcu-gpio", NULL, NULL, 0, 0),
> +};
> +
> +/* Number of bytes in a MCU command: [opcode, arg, value] */
> +#define AAEON_MCU_CMD_LEN      3
> +
> +/*
> + * Custom regmap bus for the Aaeon MCU I2C protocol.
> + *
> + * The MCU uses a fixed 3-byte command format [opcode, arg, value] followed
> + * by a 1-byte response. It requires a STOP condition between the command
> + * write and the response read, so two separate i2c_transfer() calls are
> + * issued.  The regmap lock serialises concurrent accesses from the GPIO
> + * and watchdog child drivers.
> + *
> + * Register addresses are encoded as a 16-bit big-endian value where the
> + * high byte is the opcode and the low byte is the argument, matching the
> + * wire layout produced by regmap for reg_bits=16.
> + */
> +
> +static int aaeon_mcu_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct aaeon_mcu *mcu = context;
> +	struct i2c_client *client = mcu->client;
> +	struct i2c_msg write_msg;
> +	/* The MCU always sends a response byte after each command; discard it. */
> +	struct i2c_msg response_msg;
> +	int ret;
> +
> +	memcpy(mcu->cmd, data, count);
> +
> +	write_msg.addr  = client->addr;
> +	write_msg.flags = I2C_M_DMA_SAFE;
> +	write_msg.buf   = mcu->cmd;
> +	write_msg.len   = count;
> +
> +	response_msg.addr  = client->addr;
> +	response_msg.flags = I2C_M_RD | I2C_M_DMA_SAFE;
> +	response_msg.buf   = mcu->response;
> +	response_msg.len   = 1;
> +
> +	ret = i2c_transfer(client->adapter, &write_msg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;
> +
> +	ret = i2c_transfer(client->adapter, &response_msg, 1);

[Severity: High]
Since i2c_transfer() internally acquires and releases the I2C adapter lock
per call, does issuing two separate transfers here leave a race window?

If another device driver on the same I2C bus initiates a transfer during
this window, its transaction could be physically interleaved on the bus.
Would it be safer to use i2c_lock_bus() and __i2c_transfer() to maintain
the lock across both the command write and response read?


> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static int aaeon_mcu_regmap_read(void *context, const void *reg_buf,
> +				 size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct aaeon_mcu *mcu = context;
> +	struct i2c_client *client = mcu->client;
> +	struct i2c_msg write_msg;
> +	struct i2c_msg read_msg;
> +	int ret;
> +
> +	/*
> +	 * reg_buf holds the 2-byte big-endian register address [opcode, arg].
> +	 * Append a trailing 0x00 to form the full 3-byte MCU command.
> +	 */
> +	mcu->cmd[0] = ((u8 *)reg_buf)[0];
> +	mcu->cmd[1] = ((u8 *)reg_buf)[1];
> +	mcu->cmd[2] = 0x00;
> +
> +	write_msg.addr  = client->addr;
> +	write_msg.flags = I2C_M_DMA_SAFE;
> +	write_msg.buf   = mcu->cmd;
> +	write_msg.len   = AAEON_MCU_CMD_LEN;
> +
> +	read_msg.addr  = client->addr;
> +	read_msg.flags = I2C_M_RD | I2C_M_DMA_SAFE;
> +	read_msg.buf   = val_buf;

[Severity: High]
Can val_buf point to a stack-allocated buffer?

When a child driver calls regmap_bulk_read() for a volatile register (like
GPIO inputs), regmap might pass a stack-allocated buffer directly to this
function. By unconditionally setting I2C_M_DMA_SAFE, doesn't this force
the I2C core to bypass bounce buffering?

If the I2C host controller then performs DMA directly into a stack memory
address, this could lead to cacheline sharing corruption or a kernel
panic, especially on VMAP_STACK configurations.


> +	read_msg.len   = val_size;
> +
> +	ret = i2c_transfer(client->adapter, &write_msg, 1);
> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;
> +
> +	ret = i2c_transfer(client->adapter, &read_msg, 1);

[Severity: High]
Similar to the write path above, does releasing the I2C adapter lock
between the write command and the read response risk interleaving transfers
with other devices on the same I2C bus?


> +	if (ret < 0)
> +		return ret;
> +	if (ret != 1)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> +static const struct regmap_bus aaeon_mcu_regmap_bus = {
> +	.write = aaeon_mcu_regmap_write,
> +	.read  = aaeon_mcu_regmap_read,
> +};
> +
> +static bool aaeon_mcu_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * GPIO input registers are driven by external signals and can change
> +	 * at any time without CPU involvement, always read from hardware.
> +	 *
> +	 * The watchdog status register reflects hardware state and can change
> +	 * autonomously.
> +	 *
> +	 * All other registers are written by the driver and their values are
> +	 * stable, so they can be safely cached.
> +	 */
> +	if ((reg >> 8) == AAEON_MCU_READ_GPIO_OPCODE)
> +		return true;
> +	if (reg == AAEON_MCU_REG(AAEON_MCU_CONTROL_WDT_OPCODE, 0x02))
> +		return true;
> +	return false;
> +}
> +
> +static const struct regmap_config aaeon_mcu_regmap_config = {
> +	.reg_bits          = 16,
> +	.val_bits          = 8,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +	.max_register      = AAEON_MCU_MAX_REGISTER,
> +	.volatile_reg      = aaeon_mcu_volatile_reg,
> +	.cache_type        = REGCACHE_MAPLE,
> +	.use_single_write  = true,
> +	.use_single_read   = true,
> +};
> +
> +static int aaeon_mcu_probe(struct i2c_client *client)
> +{
> +	struct aaeon_mcu *ddata;
> +	struct regmap *regmap;
> +
> +	ddata = devm_kzalloc(&client->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return -ENOMEM;
> +
> +	ddata->client = client;
> +
> +	ddata->cmd = devm_kcalloc(&client->dev, AAEON_MCU_CMD_LEN, sizeof(*ddata->cmd),
> +				  GFP_KERNEL);
> +	if (!ddata->cmd)
> +		return -ENOMEM;
> +
> +	ddata->response = devm_kzalloc(&client->dev, sizeof(*ddata->response), GFP_KERNEL);
> +	if (!ddata->response)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init(&client->dev, &aaeon_mcu_regmap_bus,
> +				  ddata, &aaeon_mcu_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "failed to initialize regmap\n");
> +
> +	return devm_mfd_add_devices(&client->dev, PLATFORM_DEVID_AUTO,
> +				    aaeon_mcu_devs, ARRAY_SIZE(aaeon_mcu_devs),
> +				    NULL, 0, NULL);
> +}
> +
> +static const struct of_device_id aaeon_mcu_of_match[] = {
> +	{ .compatible = "aaeon,srg-imx8p-mcu" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, aaeon_mcu_of_match);
> +
> +static struct i2c_driver aaeon_mcu_driver = {
> +	.driver = {
> +		.name = "aaeon-mcu",
> +		.of_match_table = aaeon_mcu_of_match,
> +	},
> +	.probe = aaeon_mcu_probe,
> +};
> +module_i2c_driver(aaeon_mcu_driver);
> +
> +MODULE_DESCRIPTION("Aaeon MCU Driver");
> +MODULE_AUTHOR("Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/aaeon-mcu.h b/include/linux/mfd/aaeon-mcu.h
> new file mode 100644
> index 000000000000..3a1aeec85d60
> --- /dev/null
> +++ b/include/linux/mfd/aaeon-mcu.h

[Severity: Low]
This isn't a bug, but should this driver-specific header be placed locally
in drivers/mfd/ instead of the global include/linux/mfd/ directory?

The MFD subsystem guidelines state that driver-specific header files used
only by the parent and its immediate children should be kept local to
drivers/mfd/.

> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Aaeon MCU driver definitions
> + *
> + * Copyright (C) 2026 Bootlin
> + * Author: Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
> + * Author: Thomas Perrot <thomas.perrot@bootlin.com>
> + */
> +
> +#ifndef __LINUX_MFD_AAEON_MCU_H
> +#define __LINUX_MFD_AAEON_MCU_H
> +
> +/*
> + * MCU register address: the high byte is the command opcode, the low
> + * byte is the argument.  This matches the 3-byte wire format
> + * [opcode, arg, value] used by the MCU I2C protocol.
> + */
> +#define AAEON_MCU_REG(op, arg)		(((op) << 8) | (arg))
> +
> +/*
> + * Opcode for GPIO input reads. These registers are volatile, their values
> + * are driven by external signals and can change without CPU involvement.
> + * Used by the MFD driver's volatile_reg callback to bypass the regmap cache.
> + */
> +#define AAEON_MCU_READ_GPIO_OPCODE	0x72
> +
> +/*
> + * Opcode for watchdog control and status commands.
> + * The status register (arg=0x02) reflects hardware state and is volatile.
> + */
> +#define AAEON_MCU_CONTROL_WDT_OPCODE	0x63
> +
> +/*
> + * Highest register address in the MCU register map.
> + * The WRITE_GPIO opcode (0x77) with the highest GPIO argument (0x0B = 11,
> + * i.e. MAX_GPIOS - 1) produces the largest encoded address.
> + */
> +#define AAEON_MCU_MAX_REGISTER		AAEON_MCU_REG(0x77, 0x0B)
> +
> +#endif /* __LINUX_MFD_AAEON_MCU_H */
> 
> -- 
> 2.55.0
> 

-- 
Lee Jones
