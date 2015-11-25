Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49228 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbbKYOxB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 09:53:01 -0500
Subject: Re: [PATCH v3 2/2] Zodiac Aerospace RAVE Switch Watchdog Processor
 Driver
To: Martyn Welch <martyn.welch@collabora.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1448453015-16126-1-git-send-email-martyn.welch@collabora.co.uk>
 <1448453015-16126-2-git-send-email-martyn.welch@collabora.co.uk>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5655CB45.50305@roeck-us.net>
Date: Wed, 25 Nov 2015 06:52:53 -0800
MIME-Version: 1.0
In-Reply-To: <1448453015-16126-2-git-send-email-martyn.welch@collabora.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Martyn,

On 11/25/2015 04:03 AM, Martyn Welch wrote:
> This patch adds a driver for the Zodiac Aerospace RAVE Watchdog Procesor.
> This device implements a watchdog timer, accessible over I2C.
>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>
> v2:
>   - Improved error handling.
>   - Correct indentation of split lines.
>   - Remove unnecessary checks, casts and bracketing.
>   - Remove sysfs entries provided by standard mechanisms.
>   - Remove simple access functions.
>   - Allocate wdd as a part of w_priv.
>   - Add ability to set timeout from module parameter or device tree property
>     rather than through a sysfs entry.
>   - Add ability to set reset duration from module parameter or device tree
>     property rather than through a sysfs entry.
>
> v3:
>   - Correct naming of reset-duration-msec -> reset-duration-ms
>   - Improved timeout logic (wasn't falling back to default, whoops.)
>
>   drivers/watchdog/Kconfig       |  11 ++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/ziirave_wdt.c | 428 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 440 insertions(+)
>   create mode 100644 drivers/watchdog/ziirave_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 7a8a6c6..816b5fb 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -161,6 +161,17 @@ config XILINX_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called of_xilinx_wdt.
>
> +config ZIIRAVE_WATCHDOG
> +	tristate "Zodiac RAVE Watchdog Timer"
> +	depends on I2C
> +	select WATCHDOG_CORE
> +	help
> +	  Watchdog driver for the Zodiac Aerospace RAVE Switch Watchdog
> +	  Processor.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ziirave_wdt.
> +
>   # ALPHA Architecture
>
>   # ARM Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 53d4827..05ba23a 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -190,5 +190,6 @@ obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
>   obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
>   obj-$(CONFIG_WM8350_WATCHDOG) += wm8350_wdt.o
>   obj-$(CONFIG_MAX63XX_WATCHDOG) += max63xx_wdt.o
> +obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
>   obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
>   obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
> new file mode 100644
> index 0000000..3d337ab
> --- /dev/null
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -0,0 +1,428 @@
> +/*
> + * Copyright (C) 2015 Zodiac Inflight Innovations
> + *
> + * Author: Martyn Welch <martyn.welch@collabora.co.uk>
> + *
> + * Based on twl4030_wdt.c by Timo Kokkonen <timo.t.kokkonen at nokia.com>:
> + *
> + * Copyright (C) Nokia Corporation
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/kernel.h>
> +#include <linux/watchdog.h>
> +#include <linux/i2c.h>
> +#include <linux/version.h>
> +#include <linux/sysfs.h>
> +
> +#define ZIIRAVE_TIMEOUT_MIN	3
> +#define ZIIRAVE_TIMEOUT_DEFAULT	30
> +#define ZIIRAVE_TIMEOUT_MAX	255
> +
> +#define ZIIRAVE_PING_VALUE	0x0
> +#define ZIIRAVE_RESET_VALUE	0x1
> +
> +#define ZIIRAVE_STATE_INITIAL	0x0
> +#define ZIIRAVE_STATE_OFF	0x1
> +#define ZIIRAVE_STATE_ON	0x2
> +#define ZIIRAVE_STATE_TRIGGERED	0x3
> +
> +static char *ziirave_states[] = {"unconfigured", "disabled", "enabled",
> +				 "triggered"};
> +
> +#define ZIIRAVE_REASON_POWER_UP	0x0
> +#define ZIIRAVE_REASON_HW_WDT	0x1
> +#define ZIIRAVE_REASON_HOST_REQ	0x4
> +#define ZIIRAVE_REASON_IGL_CFG	0x6
> +#define ZIIRAVE_REASON_IGL_INST	0x7
> +#define ZIIRAVE_REASON_IGL_TRAP	0x8
> +#define ZIIRAVE_REASON_UNKNOWN	0x9
> +
> +static char *ziirave_reasons[] = {"power cycle", "triggered", "host request",
> +				  "illegal configuration",
> +				  "illegal instruction", "illegal trap",
> +				  "unknown"};
> +

I don't see mapping code from the reason values to the array.
"host request" is array index 2 but the defined value is 0x4.

Am I missing something ?

> +#define ZIIRAVE_WDT_FIRM_VER_MAJOR	0x1
> +#define ZIIRAVE_WDT_FIRM_VER_MINOR	0x2
> +#define ZIIRAVE_WDT_BOOT_VER_MAJOR	0x3
> +#define ZIIRAVE_WDT_BOOT_VER_MINOR	0x4
> +#define ZIIRAVE_WDT_RESET_REASON	0x5
> +#define ZIIRAVE_WDT_STATE		0x6
> +#define ZIIRAVE_WDT_TIMEOUT		0x7
> +#define ZIIRAVE_WDT_TIME_LEFT		0x8
> +#define ZIIRAVE_WDT_PING		0x9
> +#define ZIIRAVE_WDT_RESET_DURATION	0xa
> +#define ZIIRAVE_WDT_RESET_WDT		0xb
> +#define ZIIRAVE_WDT_GOTO_BOOTLOADER	0xc
> +#define ZIIRAVE_WDT_FORCE_RESET_HOST	0xd
> +

Do you plan to use the unused defines in a later patch ?

> +struct ziirave_wdt_rev {
> +	unsigned char part;
> +	unsigned char major;
> +	unsigned char minor;
> +};
> +
> +struct ziirave_wdt_data {
> +	struct watchdog_device wdd;
> +	struct ziirave_wdt_rev bootloader_rev;
> +	struct ziirave_wdt_rev firmware_rev;
> +	int reset_reason;
> +};
> +
> +static int wdt_timeout;
> +module_param(wdt_timeout, int, 0);
> +MODULE_PARM_DESC(wdt_timeout, "Watchdog timeout in seconds");
> +
> +static int reset_duration;
> +module_param(reset_duration, int, 0);
> +MODULE_PARM_DESC(reset_duration,
> +		 "Watchdog reset pulse duration in milliseconds");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int ziirave_wdt_firmware_rev(struct i2c_client *client,
> +				    struct ziirave_wdt_rev *rev)
> +{
> +	int ret;
> +
> +	rev->part = 2;
> +	ret = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_FIRM_VER_MAJOR);
> +	if (ret < 0)
> +		return ret;
> +
> +	rev->major = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_FIRM_VER_MINOR);
> +	if (ret < 0)
> +		return ret;
> +
> +	rev->minor = ret;
> +
> +	return 0;
> +}
> +
> +static int ziirave_wdt_bootloader_rev(struct i2c_client *client,
> +				      struct ziirave_wdt_rev *rev)
> +{
> +	int ret;
> +
> +	rev->part = 1;
> +	ret = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_BOOT_VER_MAJOR);
> +	if (ret < 0)
> +		return ret;
> +
> +	rev->major = ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_BOOT_VER_MINOR);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	rev->minor = ret;
> +
> +	return 0;
> +}

You could merge those two functions into one by also specifying
the registers as parameters. 'part' does not really provide any value -
you could hard-code it in the print function.

> +
> +static int ziirave_wdt_set_state(struct watchdog_device *wdd, int state)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_STATE, state);
> +}
> +
> +static int ziirave_wdt_start(struct watchdog_device *wdd)
> +{
> +	return ziirave_wdt_set_state(wdd, ZIIRAVE_STATE_ON);
> +}
> +
> +static int ziirave_wdt_stop(struct watchdog_device *wdd)
> +{
> +	return ziirave_wdt_set_state(wdd, ZIIRAVE_STATE_OFF);
> +}
> +
> +static int ziirave_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_PING,
> +					 ZIIRAVE_PING_VALUE);
> +}
> +
> +static int ziirave_wdt_set_timeout(struct watchdog_device *wdd,
> +				   unsigned int timeout)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	int ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_TIMEOUT,
> +					timeout);
> +	if (!ret)
> +		wdd->timeout = timeout;
> +
> +	return ret;
> +}
> +
> +static unsigned int ziirave_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIME_LEFT);
> +	if (ret < 0)
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +static const struct watchdog_info ziirave_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPING,
> +	.identity = "Zodiac RAVE Watchdog",
> +};
> +
> +static const struct watchdog_ops ziirave_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= ziirave_wdt_start,
> +	.stop		= ziirave_wdt_stop,
> +	.ping		= ziirave_wdt_ping,
> +	.set_timeout	= ziirave_wdt_set_timeout,
> +	.get_timeleft	= ziirave_wdt_get_timeleft,
> +};
> +
> +static ssize_t ziirave_wdt_sysfs_show_firm(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
> +
> +	return sprintf(buf, "%02u.%02u.%02u", w_priv->firmware_rev.part,
> +		       w_priv->firmware_rev.major, w_priv->firmware_rev.minor);
> +}
> +
> +static DEVICE_ATTR(firmware_version, S_IRUGO, ziirave_wdt_sysfs_show_firm,
> +		   NULL);
> +
> +static ssize_t ziirave_wdt_sysfs_show_boot(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
> +
> +	return sprintf(buf, "%02u.%02u.%02u", w_priv->bootloader_rev.part,
> +		       w_priv->bootloader_rev.major,
> +		       w_priv->bootloader_rev.minor);
> +}
> +
> +static DEVICE_ATTR(bootloader_version, S_IRUGO, ziirave_wdt_sysfs_show_boot,
> +		   NULL);
> +
> +static ssize_t ziirave_wdt_sysfs_show_reason(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
> +
> +	if (w_priv->reset_reason < 0 ||
> +	    w_priv->reset_reason >= ARRAY_SIZE(ziirave_states))
> +		return sprintf(buf, "error");
> +
The probe function bails out on error, and if the reason is out of range,
so this range check is unnecessary.

> +	return sprintf(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
> +}
> +
> +static DEVICE_ATTR(reset_reason, S_IRUGO, ziirave_wdt_sysfs_show_reason,
> +		   NULL);
> +
> +static struct attribute *ziirave_wdt_attrs[] = {
> +	&dev_attr_firmware_version.attr,
> +	&dev_attr_bootloader_version.attr,
> +	&dev_attr_reset_reason.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ziirave_wdt_sysfs_files = {
> +	.attrs  = ziirave_wdt_attrs,
> +};
> +
> +static int ziirave_wdt_init_duration(struct i2c_client *client,
> +				     int duration_parm)
> +{
> +	int duration = 0;
> +	int ret = 0;

Unnecessary initialization.

> +
> +	if (duration_parm) {
> +		duration = duration_parm;
> +	} else {

Since you are initializing duration, you might as well use it directly as
parameter.

	..., int duration)
{
	..
	if (!duration) {

> +		/* See if the reset pulse duration is provided in an of_node */
> +		if (client->dev.of_node == NULL)
> +			return ret;
> +
> +		ret = of_property_read_u32(client->dev.of_node,
> +					   "reset-duration-ms", &duration);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (duration < 1 || duration > 255)
> +		return -EINVAL;
> +
> +	dev_info(&client->dev, "Setting reset duration to %dms", duration);
> +
> +	ret = i2c_smbus_write_byte_data(client,	ZIIRAVE_WDT_RESET_DURATION,
> +					duration);
> +
> +	return ret;
> +}
> +
> +static int ziirave_wdt_probe(struct i2c_client *client,
> +			     const struct i2c_device_id *id)
> +{
> +	int ret;
> +	struct ziirave_wdt_data *w_priv;
> +	int val;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C
> +				     | I2C_FUNC_SMBUS_BYTE_DATA
> +				     | I2C_FUNC_SMBUS_READ_I2C_BLOCK))

Why 2C_FUNC_SMBUS_READ_I2C_BLOCK, and why I2C_FUNC_I2C ?
Unless I am missing something, you only need I2C_FUNC_SMBUS_BYTE_DATA.

> +		return -ENODEV;
> +
> +	w_priv = devm_kzalloc(&client->dev, sizeof(*w_priv), GFP_KERNEL);
> +	if (!w_priv)
> +		return -ENOMEM;
> +
> +	w_priv->wdd.info = &ziirave_wdt_info;
> +	w_priv->wdd.ops = &ziirave_wdt_ops;
> +	w_priv->wdd.status = 0;

Unnecessary initialization.

> +	w_priv->wdd.min_timeout = ZIIRAVE_TIMEOUT_MIN;
> +	w_priv->wdd.max_timeout = ZIIRAVE_TIMEOUT_MAX;
> +	w_priv->wdd.parent = &client->dev;
> +
> +	ret = watchdog_init_timeout(&w_priv->wdd, wdt_timeout, &client->dev);
> +	if (ret) {
> +		dev_info(&client->dev,
> +			 "Unable to select timeout value, using default\n");
> +	}
> +
> +	/*
> +	 * The default value set in the watchdog should be perfectly valid, so
> +	 * pass that in if we haven't provided one via the module parameter or
> +	 * of property.
> +	 */
> +	if (w_priv->wdd.timeout == 0) {
> +		val = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIMEOUT);
> +		if (val < 0)
> +			return val;
> +
> +		w_priv->wdd.timeout = val;

What if the returned value is 0 ?

> +	} else {
> +		ret = ziirave_wdt_set_timeout(&w_priv->wdd, w_priv->wdd.timeout);
> +		if (ret)
> +			return ret;
> +
> +		dev_info(&client->dev, "Timeout set to %ds.", w_priv->wdd.timeout);
> +	}
> +
> +	watchdog_set_nowayout(&w_priv->wdd, nowayout);
> +
> +	i2c_set_clientdata(client, w_priv);
> +
> +	/* If in unconfigured state, set to stopped */
> +	val = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_STATE);
> +	if (val < 0)
> +		return val;
> +
> +	if (val == ZIIRAVE_STATE_INITIAL)
> +		ziirave_wdt_stop(&w_priv->wdd);
> +
> +	ret = watchdog_register_device(&w_priv->wdd);
> +	if (ret)
> +		return ret;
> +
> +	ret = ziirave_wdt_init_duration(client, reset_duration);
> +	if (ret) {
> +		dev_info(&client->dev,
> +			 "Unable to set reset pulse duration, using default\n");
> +	}
> +
> +	ret = ziirave_wdt_firmware_rev(client, &w_priv->firmware_rev);
> +	if (ret)
> +		goto err;
> +
> +	ret = ziirave_wdt_bootloader_rev(client, &w_priv->bootloader_rev);
> +	if (ret)
> +		goto err;
> +
> +	w_priv->reset_reason = i2c_smbus_read_byte_data(client,
> +						ZIIRAVE_WDT_RESET_REASON);
> +	if (w_priv->reset_reason < 0
> +	    || w_priv->reset_reason >= ARRAY_SIZE(ziirave_reasons))
> +		goto err;
> +
Would it make sense to call those functions prior to registering the watchdog ?
This would simplify error handling, and avoid a registration followed by an
unregistration if the i2c functions return an error.

> +	ret = sysfs_create_group(&w_priv->wdd.dev->kobj,
> +				 &ziirave_wdt_sysfs_files);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	watchdog_unregister_device(&w_priv->wdd);
> +
> +	return ret;
> +}
> +
> +static int ziirave_wdt_remove(struct i2c_client *client)
> +{
> +	struct ziirave_wdt_data *w_priv = i2c_get_clientdata(client);
> +
> +	sysfs_remove_group(&client->dev.kobj, &ziirave_wdt_sysfs_files);
> +
> +	watchdog_unregister_device(&w_priv->wdd);
> +
> +	return 0;
> +}
> +
> +static struct i2c_device_id ziirave_wdt_id[] = {
> +	{ "ziirave-wdt", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, ziirave_wdt_id);
> +
> +static const struct of_device_id zrv_wdt_of_match[] = {
> +	{ .compatible = "zii,rave-wdt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, zrv_wdt_of_match);
> +
> +static struct i2c_driver ziirave_wdt_driver = {
> +	.driver = {
> +		.name = "ziirave_wdt",
> +		.of_match_table = zrv_wdt_of_match,
> +	},
> +	.probe = ziirave_wdt_probe,
> +	.remove = ziirave_wdt_remove,
> +	.id_table = ziirave_wdt_id,
> +};
> +
> +module_i2c_driver(ziirave_wdt_driver);
> +
> +MODULE_AUTHOR("Martyn Welch <martyn.welch@collabora.co.uk");
> +MODULE_DESCRIPTION("Zodiac Aerospace RAVE Switch Watchdog Processor Driver");
> +MODULE_LICENSE("GPL");
> +
>

