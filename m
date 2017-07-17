Return-Path: <lee.jones@linaro.org>
Return-path: <lee.jones@linaro.org>
Date: Mon, 17 Jul 2017 08:51:17 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Moritz Fischer <mdf@kernel.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, wim@iguana.be,
	linux@roeck-us.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Moritz Fischer <moritz.fischer@ettus.com>
Subject: Re: [PATCH 2/2] mfd: ds1374: Add Dallas/Maxim DS1374 Multi Function
 Device
Message-ID: <20170717075117.btnhbmgpofwn7zdk@dell>
References: <1499975665-14581-1-git-send-email-mdf@kernel.org>
 <1499975665-14581-2-git-send-email-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1499975665-14581-2-git-send-email-mdf@kernel.org>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 13 Jul 2017, Moritz Fischer wrote:

> From: Moritz Fischer <moritz.fischer@ettus.com>
> 
> Add support for the Maxim/Dallas DS1374 RTC/WDT with trickle charger.
> The device can either be configured as simple RTC, as simple RTC with
> Alarm (IRQ) as well as simple RTC with watchdog timer.
> 
> Break up the old monolithic driver in drivers/rtc/rtc-ds1374.c into:
> - rtc part in drivers/rtc/rtc-ds1374.c
> - watchdog part under drivers/watchdog/ds1374-wdt.c
> - mfd part drivers/mfd/ds1374.c
> 
> The MFD part takes care of trickle charging and mode selection,
> since the usage modes of a) RTC + Alarm or b) RTC + WDT
> are mutually exclusive.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/mfd/Kconfig              |  10 +
>  drivers/mfd/Makefile             |   1 +
>  drivers/mfd/ds1374.c             | 260 ++++++++++++++++
>  drivers/rtc/rtc-ds1374.c         | 639 ++++++++++-----------------------------

It looks like this should now depend on MFD_DS1374, right?

>  drivers/watchdog/Kconfig         |  10 +
>  drivers/watchdog/Makefile        |   1 +
>  drivers/watchdog/ds1374-wdt.c    | 208 +++++++++++++

The RTC and Watchdog drivers need to be split out of this patch and
placed into their own.  Then we can take them through their respective
subsystem trees and do not have to rely on immutable branches for
unification.

>  include/dt-bindings/mfd/ds1374.h |  17 ++
>  include/linux/mfd/ds1374.h       |  59 ++++
>  9 files changed, 722 insertions(+), 483 deletions(-)
>  create mode 100644 drivers/mfd/ds1374.c
>  create mode 100644 drivers/watchdog/ds1374-wdt.c
>  create mode 100644 include/dt-bindings/mfd/ds1374.h
>  create mode 100644 include/linux/mfd/ds1374.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3eb5c93..2dfef3c 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -203,6 +203,16 @@ config MFD_CROS_EC_SPI
>  	  response time cannot be guaranteed, we support ignoring
>  	  'pre-amble' bytes before the response actually starts.
>  
> +config MFD_DS1374
> +	tristate "Dallas/Maxim DS1374 RTC/WDT/ALARM (I2C)"
> +	select MFD_CORE
> +	depends on I2C
> +	depends on REGMAP_I2C
> +
> +	 ---help---

This is an old style of help.  Please remove the '-'s.

> +	  This driver supports the Dallas Maxim DS1374 multi function chip.

"Multi-Functional"

> +	  The chip combines an RTC, trickle charger, Watchdog or Alarm.

Why is "trickle charger" not capitalised?

> +
>  config MFD_ASIC3
>  	bool "Compaq ASIC3"
>  	depends on GPIOLIB && ARM
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index c16bf1e..b5cfcf4 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -15,6 +15,7 @@ cros_ec_core-$(CONFIG_ACPI)	+= cros_ec_acpi_gpe.o
>  obj-$(CONFIG_MFD_CROS_EC)	+= cros_ec_core.o
>  obj-$(CONFIG_MFD_CROS_EC_I2C)	+= cros_ec_i2c.o
>  obj-$(CONFIG_MFD_CROS_EC_SPI)	+= cros_ec_spi.o
> +obj-$(CONFIG_MFD_DS1374)	+= ds1374.o
>  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
>  
>  rtsx_pci-objs			:= rtsx_pcr.o rts5209.o rts5229.o rtl8411.o rts5227.o rts5249.o
> diff --git a/drivers/mfd/ds1374.c b/drivers/mfd/ds1374.c
> new file mode 100644
> index 0000000..a0cfa1b
> --- /dev/null
> +++ b/drivers/mfd/ds1374.c
> @@ -0,0 +1,260 @@
> +/*
> + * Copyright (c) 2017, National Instruments Corp.
> + *
> + * Dallas/Maxim DS1374 Multi Function Device Driver

"Functional"

> + * The trickle charger code was taken more ore less 1:1 from

"or"

> + * drivers/rtc/rtc-1390.c

Why does this need to be documented in this file?

If the Trickle Charger code is in here (I haven't been down that far
yet) you need to move it out into a more appropriate subsystem.

> + * SPDX-License-Identifier: GPL-2.0
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/interrupt.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/ds1374.h>

Alphabetical.

> +#define DS1374_TRICKLE_CHARGER_ENABLE	0xa0
> +#define DS1374_TRICKLE_CHARGER_ENABLE_MASK 0xe0
> +
> +#define DS1374_TRICKLE_CHARGER_250_OHM	0x01
> +#define DS1374_TRICKLE_CHARGER_2K_OHM	0x02
> +#define DS1374_TRICKLE_CHARGER_4K_OHM	0x03
> +#define DS1374_TRICKLE_CHARGER_ROUT_MASK 0x03
> +
> +#define DS1374_TRICKLE_CHARGER_NO_DIODE	0x04
> +#define DS1374_TRICKLE_CHARGER_DIODE	0x08
> +#define DS1374_TRICKLE_CHARGER_DIODE_MASK 0xc

Are these tabs or spaces, or a mixture?

Did you run checkpatch.pl?

> +static const struct regmap_range volatile_ranges[] = {
> +	regmap_reg_range(DS1374_REG_TOD0, DS1374_REG_WDALM2),
> +	regmap_reg_range(DS1374_REG_SR, DS1374_REG_SR),
> +};
> +
> +static const struct regmap_access_table ds1374_volatile_table = {
> +	.yes_ranges = volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(volatile_ranges),
> +};
> +
> +static struct regmap_config ds1374_regmap_config = {

Genuine question: Can this be const?

> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = DS1374_REG_TCR,
> +	.volatile_table	= &ds1374_volatile_table,
> +	.cache_type	= REGCACHE_RBTREE,

It might just be the patch format, but can you check if this is
tabs/spaces?  If you're using tabs, please ensure they are all
aligned.

> +};
> +
> +static struct mfd_cell ds1374_wdt_cell = {
> +	.name = "ds1374-wdt",
> +};
> +
> +static struct mfd_cell ds1374_rtc_cell = {
> +	.name = "ds1374-rtc",
> +};
> +
> +static int ds1374_add_device(struct ds1374 *chip,
> +			     struct mfd_cell *cell)
> +{
> +	cell->platform_data = chip;
> +	cell->pdata_size = sizeof(*chip);
> +
> +	return mfd_add_devices(&chip->client->dev, PLATFORM_DEVID_AUTO,
> +			       cell, 1, NULL, 0, NULL);
> +}

This function appears to serve no purpose.  Why don't you just use
mfd_add_devices() instead?

> +static int ds1374_trickle_of_init(struct ds1374 *ds1374)
> +{
> +	u32 ohms = 0;
> +	u8 value;
> +	struct i2c_client *client = ds1374->client;
> +
> +	if (of_property_read_u32(client->dev.of_node, "trickle-resistor-ohms",
> +				 &ohms))
> +		return 0;
> +
> +	/* Enable charger */
> +	value = DS1374_TRICKLE_CHARGER_ENABLE;
> +	if (of_property_read_bool(client->dev.of_node, "trickle-diode-disable"))
> +		value |= DS1374_TRICKLE_CHARGER_NO_DIODE;
> +	else
> +		value |= DS1374_TRICKLE_CHARGER_DIODE;
> +
> +	/* Resistor select */
> +	switch (ohms) {
> +	case 250:
> +		value |= DS1374_TRICKLE_CHARGER_250_OHM;
> +		break;
> +	case 2000:
> +		value |= DS1374_TRICKLE_CHARGER_2K_OHM;
> +		break;
> +	case 4000:
> +		value |= DS1374_TRICKLE_CHARGER_4K_OHM;
> +		break;
> +	default:
> +		dev_warn(&client->dev,
> +			 "Unsupported ohm value %02ux in dt\n", ohms);
> +		return -EINVAL;
> +	}
> +	dev_dbg(&client->dev, "Trickle charge value is 0x%02x\n", value);
> +
> +	return regmap_write(ds1374->regmap, DS1374_REG_TCR, value);
> +}
> +
> +int ds1374_read_bulk(struct ds1374 *ds1374, u32 *time, int reg, int nbytes)
> +{
> +	u8 buf[4];
> +	int ret;
> +	int i;
> +
> +	if (WARN_ON(nbytes > 4))
> +		return -EINVAL;
> +
> +	ret = regmap_bulk_read(ds1374->regmap, reg, buf, nbytes);
> +	if (ret) {
> +		dev_err(&ds1374->client->dev,
> +			"Failed to bulkread n = %d at R%d\n",
> +			nbytes, reg);
> +		return ret;
> +	}
> +
> +	for (i = nbytes - 1, *time = 0; i >= 0; i--)
> +		*time = (*time << 8) | buf[i];

You need at least a comment to explain what's happening here.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ds1374_read_bulk);
> +
> +int ds1374_write_bulk(struct ds1374 *ds1374, u32 time, int reg, int nbytes)
> +{
> +	u8 buf[4];
> +	int i;
> +
> +	if (nbytes > 4) {
> +		WARN_ON(1);
> +		return -EINVAL;
> +	}
> +
> +	for (i = 0; i < nbytes; i++) {
> +		buf[i] = time & 0xff;
> +		time >>= 8;
> +	}

Same here.

> +	return regmap_bulk_write(ds1374->regmap, reg, buf, nbytes);
> +}
> +EXPORT_SYMBOL_GPL(ds1374_write_bulk);
> +
> +static int ds1374_probe(struct i2c_client *client,
> +			const struct i2c_device_id *id)
> +{
> +	struct ds1374 *ds1374;
> +	u32 mode;
> +	int err;
> +
> +	ds1374 = devm_kzalloc(&client->dev, sizeof(struct ds1374), GFP_KERNEL);
> +	if (!ds1374)
> +		return -ENOMEM;
> +
> +	ds1374->regmap = devm_regmap_init_i2c(client, &ds1374_regmap_config);
> +	if (IS_ERR(ds1374->regmap))
> +		return PTR_ERR(ds1374->regmap);
> +
> +	if (IS_ENABLED(CONFIG_OF) && client->dev.of_node) {
> +		err = of_property_read_u32(client->dev.of_node,
> +					   "dallas,mode", &mode);
> +		if (err < 0) {
> +			dev_err(&client->dev, "missing dallas,mode property\n");
> +			return -EINVAL;
> +		}
> +
> +		ds1374->remapped_reset
> +			= of_property_read_bool(client->dev.of_node,
> +						"dallas,remap-reset");
> +
> +		ds1374->mode = (enum ds1374_mode)mode;
> +	} else if (IS_ENABLED(CONFIG_RTC_DRV_DS1374_WDT)) {
> +		ds1374->mode = DS1374_MODE_RTC_WDT;
> +	} else {
> +		ds1374->mode = DS1374_MODE_RTC_ALM;
> +	}

This is non-standard.  So if OF is enabled, you're taking the 'mode'
from platform data (DT) and if it's not, you're relying on Kconfig.
May I suggest that you pick platform data OR Kconfig, but not mix the
two.

> +	ds1374->client = client;
> +	ds1374->irq = client->irq;
> +	i2c_set_clientdata(client, ds1374);
> +
> +	/* check if we're supposed to trickle charge */

"Check".

> +	err = ds1374_trickle_of_init(ds1374);
> +	if (err) {
> +		dev_err(&client->dev, "Failed to init trickle charger!\n");
> +		return err;
> +	}
> +
> +	/* we always have a rtc */

"We", "an RTC".

Or

"The RTC is always available."

> +	err = ds1374_add_device(ds1374, &ds1374_rtc_cell);
> +	if (err)
> +		return err;
> +
> +	/* we might have a watchdog if configured that way */

"We"

> +	if (ds1374->mode == DS1374_MODE_RTC_WDT)
> +		return ds1374_add_device(ds1374, &ds1374_wdt_cell);
> +
> +	return err;
> +}
> +
> +static const struct i2c_device_id ds1374_id[] = {
> +	{ "ds1374", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ds1374_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id ds1374_of_match[] = {
> +	{ .compatible = "dallas,ds1374" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ds1374_of_match);
> +#endif
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int ds1374_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int ds1374_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +#endif

These seem pointless.

I'm sure there will be a nice MACRO you can use instead.

> +static SIMPLE_DEV_PM_OPS(ds1374_pm, ds1374_suspend, ds1374_resume);
> +
> +static struct i2c_driver ds1374_driver = {
> +	.driver = {
> +		.name = "ds1374",
> +		.of_match_table = of_match_ptr(ds1374_of_match),
> +		.pm = &ds1374_pm,
> +	},
> +	.probe = ds1374_probe,
> +	.id_table = ds1374_id,
> +};
> +
> +static int __init ds1374_init(void)
> +{
> +	return i2c_add_driver(&ds1374_driver);
> +}
> +subsys_initcall(ds1374_init);
> +
> +static void __exit ds1374_exit(void)
> +{
> +	i2c_del_driver(&ds1374_driver);
> +}
> +module_exit(ds1374_exit);
> +
> +MODULE_AUTHOR("Moritz Fischer <mdf@kernel.org>");
> +MODULE_DESCRIPTION("Maxim/Dallas DS1374 MFD Driver");
> +MODULE_LICENSE("GPL");

This conflicts with your header.

[...]

> diff --git a/include/dt-bindings/mfd/ds1374.h b/include/dt-bindings/mfd/ds1374.h
> new file mode 100644
> index 0000000..b33cd5e
> --- /dev/null
> +++ b/include/dt-bindings/mfd/ds1374.h
> @@ -0,0 +1,17 @@
> +/*
> + * This header provides macros for Maxim/Dallas DS1374 DT bindings
> + *
> + * Copyright (C) 2017 National Instruments Corp
> + *
> + * SPDX-License-Identifier: GPL-2.0
> + *

This line is superfluous.

> + */
> +
> +#ifndef __DT_BINDINGS_MFD_DS1374_H__
> +#define __DT_BINDINGS_MFD_DS1374_H__
> +
> +#define DALLAS_MODE_RTC		0
> +#define DALLAS_MODE_ALM		1
> +#define DALLAS_MODE_WDT		2

What's stopping these becoming out of line with the #defines in the
other header file?  You should probably use these for comparison
instead.

> +#endif /* __DT_BINDINGS_MFD_DS1374_H__ */
> diff --git a/include/linux/mfd/ds1374.h b/include/linux/mfd/ds1374.h
> new file mode 100644
> index 0000000..7b697f8
> --- /dev/null
> +++ b/include/linux/mfd/ds1374.h
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright (c) 2017, National Instruments Corp.
> + *
> + * Multi Function Device for Dallas/Maxim DS1374 RTC/WDT

"Functional"

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.

Do you have to use the long licence here?

> + */
> +
> +#ifndef MFD_DS1374_H
> +#define MFD_DS1374_H
> +
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +
> +enum ds1374_mode {
> +	DS1374_MODE_RTC_ONLY,
> +	DS1374_MODE_RTC_ALM,
> +	DS1374_MODE_RTC_WDT,
> +};

Please see above.

> +/* Register definitions to for all subdrivers
> + */
> +#define DS1374_REG_TOD0		0x00 /* Time of Day */
> +#define DS1374_REG_TOD1		0x01
> +#define DS1374_REG_TOD2		0x02
> +#define DS1374_REG_TOD3		0x03
> +#define DS1374_REG_WDALM0	0x04 /* Watchdog/Alarm */
> +#define DS1374_REG_WDALM1	0x05
> +#define DS1374_REG_WDALM2	0x06
> +#define DS1374_REG_CR		0x07 /* Control */
> +#define DS1374_REG_CR_AIE	0x01 /* Alarm Int. Enable */
> +#define DS1374_REG_CR_WDSTR	0x08 /* 1=Reset on INT, 0=Rreset on RST */
> +#define DS1374_REG_CR_WDALM	0x20 /* 1=Watchdog, 0=Alarm */
> +#define DS1374_REG_CR_WACE	0x40 /* WD/Alarm counter enable */
> +#define DS1374_REG_SR		0x08 /* Status */
> +#define DS1374_REG_SR_OSF	0x80 /* Oscillator Stop Flag */
> +#define DS1374_REG_SR_AF	0x01 /* Alarm Flag */
> +#define DS1374_REG_TCR		0x09 /* Trickle Charge */
> +
> +struct ds1374 {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	int irq;
> +	enum ds1374_mode mode;
> +	bool remapped_reset;
> +};

This could do with a KernelDoc header.

> +int ds1374_read_bulk(struct ds1374 *ds1374, u32 *time, int reg, int nbytes);
> +
> +int ds1374_write_bulk(struct ds1374 *ds1374, u32 time, int reg, int nbytes);

Do these two just read time?

If so, the nomenclature could be improved.

> +#endif /* MFD_DS1374_H */

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
