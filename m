Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888960;
	b=v/8jhQn7NQiRk0IrwZUauU5Pd9D0IR70A4nCeUcq7swdF7iqCOqvz7GnBZ1hHfUuDZtE
	 z3QiAb10x06yWkkfP7tNytlvc4wr3GTXsPlworzYKcuXMTjgA052YdgXNxHSOzY6MDMb9
	 tAA8ler6WLg8wTVxHifrmhZSC5esHBmTa+S/kazLkdsDXJ/QtxvURT9WN9keR/2c8idg9
	 kMgUv+oxk8TJJNSxo+qH/9Gnz8TvPMayYmIjqh21jgOFTwW0RdfJGRCjpw4KZFaabU6ky
	 uHKvllLqIz4bl/2pqhBSLFso+9kw7SltiTG6+Klq+nHEnehRg+UvjfK3J64t7HGNpbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888960;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-AI-Review-Draft;
	bh=A3wa5CvpyG7Bv+3nyw/J1JeS+qybhpRhQxCSuvYcfwk=;
	b=MJJLeNM5tDIQSdbKF/NyOFBizE93BLDntCqZTW+FCsSBDWe2COYRaLkeazO7jVrgjrBv
	 oyNT5ucAqB6XNqrRSQnoigv9mnBVzJ/sCTdRG4OwPpiGOZX95gz5+3djPtpwyCR1mfm9O
	 ovTeHjlW5G1LkSMsTvhzKmL27LMR5xH+F4v9mUUglPUImVtisisyWh/QhZsCFVcpbszjW
	 1pZgKPNZ5iWvExesb4yUTDYX4RdOK4oLjhKsHgnZO5jb1ovDgV3CwMPAJ9ElxzuOsHWHl
	 7pHswUq5Igt5lkWMC8buT/mj8u+obbbdv1uubDJ96wwfMM6+r5pY/sGrcntjGBVyITw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9oaO+Na;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0E606A32D;
	Thu,  5 Nov 2026 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E9oaO+Na
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B4BF1F00A18;
	Thu,  5 Nov 2026 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888959;
	bh=A3wa5CvpyG7Bv+3nyw/J1JeS+qybhpRhQxCSuvYcfwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E9oaO+Naww29VHVnNJYLHH2NZLzrkucxWXbicUL99iwVV2j6hEBgtf14CELtGtFVB
	 RUXLo5DB4+hpDhTtD1BrDQNIZZC2nB19+0QArVauTW0Cp0wY9KjzL8w5snuLuSYhW1
	 QrGiOcOJA8o+u3HmjoJtUKWg5T5VFNduYyJHdl9wQdxE3I6cxoHFGZJ9xFze2o5I+l
	 rNQizRf4fm7Y/fbdsgab+lrhP2ZkGeHJczT6ZmDYXNLjrhrHb+XnCp65rcNhpToxdW
	 gklch/oS040pSuB855YNqVR2DSzbsgPnJVSvQJJUhlB1zP4FMJWCt2N0Hm445XvMMb
	 Y23nS1eLlSfVA==
Date: Thu, 5 Nov 2026 14:29:12 +0000
From: Lee Jones <lee@kernel.org>
To: Thomas Perrot <thomas.perrot@bootlin.com>
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
	Guenter Roeck <linux@roeck-us.net>, Frank Li <Frank.Li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>, mfd@lists.linux.dev
Subject: Re: [PATCH v9 2/4] mfd: aaeon: Add SRG-IMX8P MCU driver
Message-ID: <179370051070.793788.9316421428527145334@kernel.org>
References: <20261029-dev-b4-aaeon-mcu-driver-v9-0-f9b6d0cc180d@bootlin.com>
 <20261029-dev-b4-aaeon-mcu-driver-v9-2-f9b6d0cc180d@bootlin.com>
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Post: <mailto:linux-watchdog@vger.kernel.org>
List-Help: <mailto:linux-watchdog+help@vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-watchdog+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029-dev-b4-aaeon-mcu-driver-v9-2-f9b6d0cc180d@bootlin.com>
X-AI-Review-Draft: <20261029-dev-b4-aaeon-mcu-driver-v9-2-f9b6d0cc180d@bootlin.com>

--- checkpatch.pl (2 issues) ---
Line 301: WARNING: DT compatible string "aaeon,srg-imx8p-mcu" appears un-documented -- check ./Documentation/devicetree/bindings/
Line 301: WARNING: DT compatible string vendor "aaeon" appears un-documented -- check ./Documentation/devicetree/bindings/vendor-prefixes.yaml
----------------------------------

On Thu, 29 Oct 2026, Thomas Perrot (Schneider Electric) wrote:

> Add a driver for the Aaeon SRG-IMX8P embedded controller. This driver
> provides the core I2C communication interface and registers child
> devices (GPIO and watchdog controllers).
>
> The driver implements a custom regmap bus over I2C to match the MCU's
> fixed 3-byte command format [opcode, arg, value]. Register addresses
> are encoded as 16-bit values (opcode << 8 | arg) using the
> AAEON_MCU_REG() macro defined in the shared header. The regmap
> instance is shared with child drivers via dev_get_regmap(). Concurrent
> I2C accesses from child drivers are serialized by regmap's built-in
> locking.
>
> The MCU wants a STOP between a command and its response, so they are
> two separate transfers. Both are issued under the I2C segment lock so
> that no other transfer on the same I2C segment can land in between.
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
> Only those two kinds of registers are readable. Any other opcode is a
> command, and the frame sent for a read is the same as the one used to
> write it, so reading it, for instance through the regmap debugfs
> registers file, would execute the command.
>
> Co-developed-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
> Signed-off-by: Jérémie Dautheribes (Schneider Electric) <jeremie.dautheribes@bootlin.com>
> Signed-off-by: Thomas Perrot (Schneider Electric) <thomas.perrot@bootlin.com>
> ---
>  MAINTAINERS                   |   2 +
>  drivers/mfd/Kconfig           |  11 +++
>  drivers/mfd/Makefile          |   1 +
>  drivers/mfd/aaeon-mcu.c       | 221 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/aaeon-mcu.h |  40 ++++++++
>  5 files changed, 275 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f85e2a8b192..55fc12c283fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -192,6 +192,8 @@ M:	Thomas Perrot <thomas.perrot@bootlin.com>
>  R:	Jérémie Dautheribes <jeremie.dautheribes@bootlin.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/aaeon,srg-imx8p-mcu.yaml
> +F:	drivers/mfd/aaeon-mcu.c
> +F:	include/linux/mfd/aaeon-mcu.h
>
>  AAEON UPBOARD FPGA MFD DRIVER
>  M:	Thomas Richard <thomas.richard@bootlin.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 87ed55c155f0..72bca7026cee 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1581,6 +1581,17 @@ config ABX500_CORE
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
> index f8101d2a9ce9..166b25638f7f 100644
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
> index 000000000000..e7470023265d
> --- /dev/null
> +++ b/drivers/mfd/aaeon-mcu.c
> @@ -0,0 +1,221 @@
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
> + * write and the response read, so two separate transfers are issued. The
> + * I2C segment lock is held across both so that no other transfer on the
> + * same I2C segment can land between the command and its response. The
> + * regmap lock serialises concurrent accesses from the GPIO and watchdog
> + * child drivers.
> + *
> + * Register addresses are encoded as a 16-bit big-endian value where the
> + * high byte is the opcode and the low byte is the argument, matching the
> + * wire layout produced by regmap for reg_bits=16.
> + */
> +
> +/*
> + * Send the command held in mcu->cmd and read the 1-byte response into
> + * mcu->response. Both buffers are heap-allocated and thus DMA-safe.
> + */
> +static int aaeon_mcu_xfer(struct aaeon_mcu *mcu)
> +{
> +	struct i2c_adapter *adap = mcu->client->adapter;
> +	struct i2c_msg msg = {
> +		.addr	= mcu->client->addr,
> +		.flags	= I2C_M_DMA_SAFE,
> +		.buf	= mcu->cmd,
> +		.len	= AAEON_MCU_CMD_LEN,
> +	};
> +	int ret;
> +
> +	i2c_lock_bus(adap, I2C_LOCK_SEGMENT);
> +
> +	ret = __i2c_transfer(adap, &msg, 1);
> +	if (ret == 1) {
> +		msg.flags = I2C_M_RD | I2C_M_DMA_SAFE;
> +		msg.buf   = mcu->response;
> +		msg.len   = 1;
> +		ret = __i2c_transfer(adap, &msg, 1);
> +	}
> +
> +	i2c_unlock_bus(adap, I2C_LOCK_SEGMENT);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return ret == 1 ? 0 : -EIO;
> +}
> +
> +static int aaeon_mcu_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct aaeon_mcu *mcu = context;
> +
> +	/*
> +	 * use_single_write guarantees one register per call: a 2-byte
> +	 * address followed by a 1-byte value.
> +	 */
> +	if (count != AAEON_MCU_CMD_LEN)
> +		return -EINVAL;
> +
> +	memcpy(mcu->cmd, data, count);
> +
> +	/* The MCU always sends a response byte after each command; discard it. */
> +	return aaeon_mcu_xfer(mcu);
> +}
> +
> +static int aaeon_mcu_regmap_read(void *context, const void *reg_buf,
> +				 size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct aaeon_mcu *mcu = context;
> +	int ret;
> +
> +	/*
> +	 * reg_buf holds the 2-byte big-endian register address [opcode, arg].
> +	 * Append a trailing 0x00 to form the full 3-byte MCU command.
> +	 */

What about 'reg_size != 2 || val_size != 1' here, for the same reason as
the checks in *_write()?

> +	mcu->cmd[0] = ((u8 *)reg_buf)[0];
> +	mcu->cmd[1] = ((u8 *)reg_buf)[1];
> +	mcu->cmd[2] = 0x00;
> +
> +	ret = aaeon_mcu_xfer(mcu);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * val_buf is owned by the regmap caller and is not necessarily
> +	 * DMA-safe, so go through the driver's response buffer.
> +	 * use_single_read guarantees val_size == 1.
> +	 */
> +	*(u8 *)val_buf = *mcu->response;
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

No magic numbers please.

> +		return true;
> +	return false;
> +}
> +
> +static bool aaeon_mcu_readable_reg(struct device *dev, unsigned int reg)
> +{
> +	/*
> +	 * Every opcode but the GPIO input read and the watchdog status is a
> +	 * command: the frame sent for a read is identical to the one used to
> +	 * write it, so reading such a register would execute the command.
> +	 * Only the registers reflecting hardware state may be read.
> +	 */
> +	return aaeon_mcu_volatile_reg(dev, reg);
> +}
> +
> +static const struct regmap_config aaeon_mcu_regmap_config = {
> +	.reg_bits          = 16,
> +	.val_bits          = 8,
> +	.reg_format_endian = REGMAP_ENDIAN_BIG,
> +	.max_register      = AAEON_MCU_MAX_REGISTER,
> +	.readable_reg      = aaeon_mcu_readable_reg,
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

Why do 'cmd' and 'response' need two separate heap allocations?  Since
'struct aaeon_mcu' is allocated via 'devm_kzalloc()' and Regmap
serialises all accesses, could you just embed fixed-size arrays directly
inside 'struct aaeon_mcu' and drop these two extra 'devm_k*alloc()'s?

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
> 2.56.0
>

-- 
Lee Jones
