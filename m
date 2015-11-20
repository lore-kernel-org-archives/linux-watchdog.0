Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42077 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbbKTSoN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Nov 2015 13:44:13 -0500
Subject: Re: [PATCH 2/2] Zodiac Aerospace RAVE Switch Watchdog Processor
 Driver
To: Martyn Welch <martyn.welch@collabora.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1447864731-24673-1-git-send-email-martyn.welch@collabora.co.uk>
 <1447864731-24673-2-git-send-email-martyn.welch@collabora.co.uk>
Cc: linux-watchdog@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564F69F6.3030903@roeck-us.net>
Date: Fri, 20 Nov 2015 10:44:06 -0800
MIME-Version: 1.0
In-Reply-To: <1447864731-24673-2-git-send-email-martyn.welch@collabora.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/18/2015 08:38 AM, Martyn Welch wrote:
> This patch adds a driver for the Zodiac Aerospace RAVE Watchdog Procesor.
> This device implements a watchdog timer, accessible over I2C.
>
> This driver implements some functionality that isn't exposed via the
> standard API and so the driver functionality has also been exposed via
> sysfs.
>

Not a complete review, just a start. This will require some major changes
to be acceptable.

> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> ---
>   drivers/watchdog/Kconfig       |  11 +
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/ziirave_wdt.c | 648 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 660 insertions(+)
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
> index 0000000..7577c25
> --- /dev/null
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -0,0 +1,648 @@
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
> +		"triggered"};
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
> +		"illegal configuration", "illegal instruction", "illegal trap",
> +		"unknown"};
> +
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
> +struct ziirave_wdt_rev {
> +	unsigned char part;
> +	unsigned char major;
> +	unsigned char minor;
> +};
> +
> +struct ziirave_wdt_data {
> +	struct ziirave_wdt_rev bootloader_rev;
> +	struct ziirave_wdt_rev firmware_rev;
> +	int reset_reason;
> +};
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int ziirave_wdt_firmware_rev(struct watchdog_device *wdd,
> +		struct ziirave_wdt_rev *rev)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	rev->part = 2;
> +	rev->major = (char)i2c_smbus_read_byte_data(client,
> +			ZIIRAVE_WDT_FIRM_VER_MAJOR);
> +
> +	rev->minor = (char)i2c_smbus_read_byte_data(client,
> +			ZIIRAVE_WDT_FIRM_VER_MINOR);
> +
I am not really a friend of ignoring errors. With the typecast, errors
will translate to an odd version code. Besides, you defined 'minor'
and 'major' as unsigned char, and typecast to char, meaning the values
written into the variables will be really weird on errors (eg 251
for -EIO).

> +	return 0;

A static function always returning 0 doesn't really make any sense.

> +}
> +
> +static int ziirave_wdt_bootloader_rev(struct watchdog_device *wdd,
> +		struct ziirave_wdt_rev *rev)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	rev->part = 1;
> +	rev->major = (char)i2c_smbus_read_byte_data(client,
> +			ZIIRAVE_WDT_BOOT_VER_MAJOR);
> +
> +	rev->minor = (char)i2c_smbus_read_byte_data(client,
> +			ZIIRAVE_WDT_BOOT_VER_MINOR);
> +
> +	return 0;
> +}
> +
> +static int ziirave_wdt_reason(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_RESET_REASON);

I think it would be better to store client in struct ziirave_wdt_data
and access it from there. I am kind of ambivalent on the access functions


> +}
> +
> +static int ziirave_wdt_get_state(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_STATE);
> +}
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
> +			ZIIRAVE_PING_VALUE);

Please align continuation lines with '('.

> +}
> +
> +static int ziirave_wdt_get_timeout(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIMEOUT);
> +}
> +
> +static int ziirave_wdt_set_timeout(struct watchdog_device *wdd,
> +		unsigned int timeout)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +	int ret;
> +
> +	if (watchdog_timeout_invalid(wdd, timeout))
> +		return -EINVAL;
> +
Unnecessary; handled by infrastructure (and a sysfs attribute to set it
is unacceptable outside the infrastructure - please see below).

> +	ret = i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_TIMEOUT,
> +			(char)timeout);

Unnecessary (and wrong) typecast.

> +	if (!ret)
> +		wdd->timeout = timeout;
> +
> +	return ret;
> +}
> +
> +static unsigned int ziirave_wdt_get_timeleft(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIME_LEFT);

While it is unfortunate that get_timeleft does not support returning an error code,
converting it into large numbers is even less desirable.

> +}
> +
> +static int ziirave_wdt_set_resettime(struct watchdog_device *wdd,
> +		unsigned int timeout)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	if (timeout < 0 || timeout > 256)
> +		return -EINVAL;

Wrong range check.

> +
> +	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_TIMEOUT,
> +			(char)timeout);

char conversion is odd here. 256 -> 0 ? 255 -> -1 ?
The typecast should be unnecessary.

Also, I am a bit lost here. Isn't this the same as the timeout set above ?

> +}
> +
> +static unsigned int ziirave_wdt_get_resettime(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_RESET_DURATION);

Ignoring an error return code here is not a good idea. -EIO will translate
to a really large number (something like 4294967291).

> +}
> +
> +static int ziirave_wdt_resetwdt(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_RESET_WDT, 0x1);
> +}
> +
> +static int ziirave_wdt_resetwdt_bootloader(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_GOTO_BOOTLOADER,
> +			0x1);
> +}
> +
> +static int ziirave_wdt_resethost(struct watchdog_device *wdd)
> +{
> +	struct i2c_client *client = to_i2c_client(wdd->parent);
> +
> +	return i2c_smbus_write_byte_data(client, ZIIRAVE_WDT_FORCE_RESET_HOST,
> +			0x1);
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
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	struct ziirave_wdt_data *w_priv = watchdog_get_drvdata(wdd);
> +
> +	return sprintf(buf, "%02u.%02u.%02u", w_priv->firmware_rev.part,
> +			w_priv->firmware_rev.major, w_priv->firmware_rev.minor);
> +}
> +
> +static DEVICE_ATTR(firmware_version, S_IRUGO, ziirave_wdt_sysfs_show_firm,
> +		NULL);
> +
> +static ssize_t ziirave_wdt_sysfs_show_boot(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	struct ziirave_wdt_data *w_priv = watchdog_get_drvdata(wdd);
> +
> +	return sprintf(buf, "%02u.%02u.%02u", w_priv->bootloader_rev.part,
> +			w_priv->bootloader_rev.major,
> +			w_priv->bootloader_rev.minor);
> +}
> +
> +static DEVICE_ATTR(bootloader_version, S_IRUGO, ziirave_wdt_sysfs_show_boot,
> +		NULL);
> +
> +static ssize_t ziirave_wdt_sysfs_show_reason(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	struct ziirave_wdt_data *w_priv = watchdog_get_drvdata(wdd);
> +
> +	if ((w_priv->reset_reason < 0) ||
> +	    (w_priv->reset_reason >= ARRAY_SIZE(ziirave_states)))

Please no unnecessary ( ).

> +		return sprintf(buf, "error");
> +
> +	return sprintf(buf, "%s", ziirave_reasons[w_priv->reset_reason]);
> +}
> +
> +static DEVICE_ATTR(reset_reason, S_IRUGO, ziirave_wdt_sysfs_show_reason,
> +		NULL);
> +
> +static ssize_t ziirave_wdt_sysfs_store_state(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +	int state;
> +
> +	if (!strcmp(buf, "enabled") || !strcmp(buf, "enabled\n"))
> +		state = ZIIRAVE_STATE_ON;
> +	else if (!strcmp(buf, "disabled") || !strcmp(buf, "disabled\n"))
> +		state = ZIIRAVE_STATE_OFF;
> +	else
> +		return -EINVAL;
> +
> +	mutex_lock(&wdd->lock);
> +
> +	ret = ziirave_wdt_set_state(wdd, state);
> +	if (ret) {
> +		mutex_unlock(&wdd->lock);
> +		return -EIO;

Please use goto here, and don't overwrite errors from called code.
Mostly irrelevant, though, since the attribute itself is not acceptable.

> +	}
> +
> +	if (state == ZIIRAVE_STATE_ON)
> +		set_bit(WDOG_ACTIVE, &wdd->status);
> +	else
> +		clear_bit(WDOG_ACTIVE, &wdd->status);

That is not the correct way to enable a watchdog. Please use the infrastructure.

> +
> +	mutex_unlock(&wdd->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t ziirave_wdt_sysfs_show_state(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = ziirave_wdt_get_state(wdd);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret >= ARRAY_SIZE(ziirave_states))
> +		return sprintf(buf, "Invalid");
> +
> +	return sprintf(buf, "%s", ziirave_states[ret]);
> +}
> +
> +static DEVICE_ATTR(state, S_IRUGO|S_IWUSR,
> +		ziirave_wdt_sysfs_show_state, ziirave_wdt_sysfs_store_state);
> +
> +static ssize_t ziirave_wdt_sysfs_store_timeout(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +	int timeout;
> +
> +	ret = kstrtouint(buf, 0, &timeout);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&wdd->lock);
> +
> +	ret = ziirave_wdt_set_timeout(wdd, timeout);
> +	if (ret) {
> +		mutex_unlock(&wdd->lock);
> +		return ret;
> +	}
> +
> +	mutex_unlock(&wdd->lock);
> +
> +	return count;
> +}
> +
> +static ssize_t ziirave_wdt_sysfs_show_timeout(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = ziirave_wdt_get_timeout(wdd);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%u", ret);
> +}
> +
> +static DEVICE_ATTR(timeout, S_IRUGO|S_IWUSR,
> +		ziirave_wdt_sysfs_show_timeout,
> +		ziirave_wdt_sysfs_store_timeout);
> +
> +static ssize_t ziirave_wdt_sysfs_show_timeleft(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = ziirave_wdt_get_timeout(wdd);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%u", ret);
> +}
> +
> +static DEVICE_ATTR(timeleft, S_IRUGO,
> +		ziirave_wdt_sysfs_show_timeleft, NULL);
> +

Please drop all those sysfs attributes which are supposed to be handled
by the infrastructure. If anything, please help getting the respective
infrastructure changes upstream to make those attributes visible as
syfs attributes. I can point you to the patch if needed.

> +static ssize_t ziirave_wdt_sysfs_store_pet(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = ziirave_wdt_get_state(wdd);
> +	if (ret != ZIIRAVE_STATE_ON)
> +		return -EINVAL;
> +
> +	ret = ziirave_wdt_ping(wdd);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(keepalive, S_IRUGO|S_IWUSR, NULL,
> +		ziirave_wdt_sysfs_store_pet);
> +
> +static ssize_t ziirave_wdt_sysfs_store_reset_time(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +	int reset_time;
> +
> +	ret = kstrtouint(buf, 0, &reset_time);
> +	if (ret)
> +		return ret;
> +
> +	ret = ziirave_wdt_set_resettime(wdd, reset_time);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static ssize_t ziirave_wdt_sysfs_show_reset_time(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +
> +	ret = ziirave_wdt_get_resettime(wdd);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%u", ret);
> +}
> +
> +static DEVICE_ATTR(reset_duration, S_IRUGO|S_IWUSR,
> +		ziirave_wdt_sysfs_show_reset_time,
> +		ziirave_wdt_sysfs_store_reset_time);
> +
> +static ssize_t ziirave_wdt_sysfs_store_reset_processor(struct device *dev,
> +		struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (strcmp(buf, "reset") && strcmp(buf, "reset\n"))
> +		return -EINVAL;
> +
> +	ret = ziirave_wdt_resetwdt(wdd);

Is this supposed to cause a system reset ? If so, wrong way to do it.
Please register a reset notifier.

> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(reset_wdt, S_IRUGO|S_IWUSR, NULL,
> +		ziirave_wdt_sysfs_store_reset_processor);
> +
> +static ssize_t ziirave_wdt_sysfs_store_wdt_to_bootloader(
> +		struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (strcmp(buf, "reset") && strcmp(buf, "reset\n"))
> +		return -EINVAL;
> +
> +	ret = ziirave_wdt_resetwdt_bootloader(wdd);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(reset_bootloader, S_IRUGO|S_IWUSR, NULL,
> +		ziirave_wdt_sysfs_store_wdt_to_bootloader);
> +
> +static ssize_t ziirave_wdt_sysfs_store_reset_host(
> +		struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +	int ret;
> +
> +	if (strcmp(buf, "reset") && strcmp(buf, "reset\n"))
> +		return -EINVAL;
> +
> +	ret = ziirave_wdt_resethost(wdd);
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR(force_reset, S_IRUGO|S_IWUSR, NULL,
> +		ziirave_wdt_sysfs_store_reset_host);
> +
> +static struct attribute *ziirave_wdt_attrs[] = {
> +	&dev_attr_firmware_version.attr,
> +	&dev_attr_bootloader_version.attr,
> +	&dev_attr_reset_reason.attr,
> +	&dev_attr_state.attr,
> +	&dev_attr_timeout.attr,
> +	&dev_attr_timeleft.attr,
> +	&dev_attr_keepalive.attr,
> +	&dev_attr_reset_duration.attr,
> +	&dev_attr_reset_wdt.attr,
> +	&dev_attr_reset_bootloader.attr,
> +	&dev_attr_force_reset.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ziirave_wdt_sysfs_files = {
> +	.attrs  = ziirave_wdt_attrs,
> +};
> +
> +static int ziirave_wdt_probe(struct i2c_client *client,
> +		const struct i2c_device_id *id)
> +{
> +	int ret = 0;
> +	struct watchdog_device *wdd;
> +	struct ziirave_wdt_data *w_priv;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C
> +				| I2C_FUNC_SMBUS_BYTE_DATA
> +				| I2C_FUNC_SMBUS_READ_I2C_BLOCK))
> +		return -ENODEV;
> +
> +	wdd = devm_kzalloc(&client->dev, sizeof(*wdd), GFP_KERNEL);
> +	if (!wdd)
> +		return -ENOMEM;
> +
> +	w_priv = devm_kzalloc(&client->dev, sizeof(*w_priv), GFP_KERNEL);
> +	if (!wdd)
> +		return -ENOMEM;
> +

Please allocate wdd as part of w_priv; two separate allocations are not needed.

> +	wdd->info = &ziirave_wdt_info;
> +	wdd->ops = &ziirave_wdt_ops;
> +	wdd->status = 0;
> +	wdd->timeout = i2c_smbus_read_byte_data(client, ZIIRAVE_WDT_TIMEOUT);

No error check ?

> +	wdd->min_timeout = ZIIRAVE_TIMEOUT_MIN;
> +	wdd->max_timeout = ZIIRAVE_TIMEOUT_MAX;
> +	wdd->parent = &client->dev;
> +
> +	watchdog_set_nowayout(wdd, nowayout);
> +
Since the driver supports devicetree, it may make sense to also call
watchdog_set_timeout() to pick up a timeout configured in devicetree data.

> +	i2c_set_clientdata(client, wdd);
> +
> +	ziirave_wdt_stop(wdd);

Are you sure ? This will leave the system unprotected until user space starts.

> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret)
> +		return ret;
> +
> +	ret = ziirave_wdt_firmware_rev(wdd, &w_priv->firmware_rev);
> +	if (ret)
> +		goto err;
> +
> +	ret = ziirave_wdt_bootloader_rev(wdd, &w_priv->bootloader_rev);
> +	if (ret)
> +		goto err;
> +
But those functions always return 0.

> +	w_priv->reset_reason = ziirave_wdt_reason(wdd);
> +	if ((ret < 0) || (ret >= ARRAY_SIZE(ziirave_reasons)))

Unnecessary ( ). And is this really fatal ?

> +		goto err;
> +
> +	watchdog_set_drvdata(wdd, w_priv);
> +
> +	ret = sysfs_create_group(&wdd->dev->kobj, &ziirave_wdt_sysfs_files);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +err:
> +	watchdog_unregister_device(wdd);
> +
> +	return ret;
> +}
> +
> +static int ziirave_wdt_remove(struct i2c_client *client)
> +{
> +	struct watchdog_device *wdd = i2c_get_clientdata(client);
> +
> +	sysfs_remove_group(&client->dev.kobj, &ziirave_wdt_sysfs_files);
> +
> +	watchdog_unregister_device(wdd);
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

