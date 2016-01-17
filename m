Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52523 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbcAQTPi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jan 2016 14:15:38 -0500
Subject: Re: [PATCH v3 6/6] Add Advantech iManager Watchdog driver
To: richard.dorsch@gmail.com, linux-kernel@vger.kernel.org
References: <1452468675-5827-1-git-send-email-richard.dorsch@gmail.com>
 <1452468675-5827-7-git-send-email-richard.dorsch@gmail.com>
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org,
	lee.jones@linaro.org, jdelvare@suse.com, wim@iguana.be,
	jo.sunga@advantech.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <569BE856.3080909@roeck-us.net>
Date: Sun, 17 Jan 2016 11:15:34 -0800
MIME-Version: 1.0
In-Reply-To: <1452468675-5827-7-git-send-email-richard.dorsch@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/10/2016 03:31 PM, richard.dorsch@gmail.com wrote:
> From: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
>
> Signed-off-by: Richard Vidal-Dorsch <richard.dorsch@gmail.com>
> ---
>   drivers/watchdog/Kconfig           |  12 ++
>   drivers/watchdog/Makefile          |   2 +
>   drivers/watchdog/imanager-ec-wdt.c | 170 +++++++++++++++++++
>   drivers/watchdog/imanager-wdt.c    | 333 +++++++++++++++++++++++++++++++++++++
>   include/linux/mfd/imanager/wdt.h   |  37 +++++
>   5 files changed, 554 insertions(+)
>   create mode 100644 drivers/watchdog/imanager-ec-wdt.c
>   create mode 100644 drivers/watchdog/imanager-wdt.c
>   create mode 100644 include/linux/mfd/imanager/wdt.h
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1c427be..e555127 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -846,6 +846,18 @@ config ITCO_VENDOR_SUPPORT
>   	  devices. At this moment we only have additional support for some
>   	  SuperMicro Inc. motherboards.
>
> +config IMANAGER_WDT
> +	tristate "Advantech iManager Watchdog"
> +	depends on MFD_IMANAGER
> +	select WATCHDOG_CORE
> +	help
> +	  This driver provides support for Advantech iManager watchdog
> +	  of Advantech SOM, MIO, AIMB, and PCM modules/boards.
> +	  Requires mfd-core and imanager-core to function properly.
> +
> +	  This driver can also be built as a module.  If so, the module
> +	  will be called imanager_wdt.
> +
>   config IT8712F_WDT
>   	tristate "IT8712F (Smart Guardian) Watchdog Timer"
>   	depends on X86
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 53d4827..647eca87 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -100,6 +100,8 @@ obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
>   ifeq ($(CONFIG_ITCO_VENDOR_SUPPORT),y)
>   obj-$(CONFIG_ITCO_WDT) += iTCO_vendor_support.o
>   endif
> +imanager_wdt-objs := imanager-wdt.o imanager-ec-wdt.o
> +obj-$(CONFIG_IMANAGER_WDT) += imanager_wdt.o
>   obj-$(CONFIG_IT8712F_WDT) += it8712f_wdt.o
>   obj-$(CONFIG_IT87_WDT) += it87_wdt.o
>   obj-$(CONFIG_HP_WATCHDOG) += hpwdt.o
> diff --git a/drivers/watchdog/imanager-ec-wdt.c b/drivers/watchdog/imanager-ec-wdt.c
> new file mode 100644
> index 0000000..9c94b21
> --- /dev/null
> +++ b/drivers/watchdog/imanager-ec-wdt.c
> @@ -0,0 +1,170 @@
> +/*
> + * Advantech iManager Watchdog core
> + *
> + * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
> + * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + *
> + * Note: Current release only implements RESET of the EC WDT.
> + *       In other words, no PWR button, NMI, SCI, IRQ, or WDPin support yet!
> + */
> +
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/bug.h>
> +#include <linux/io.h>
> +#include <linux/delay.h>
> +#include <linux/string.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/swab.h>
> +#include <linux/mfd/imanager/ec.h>
> +#include <linux/mfd/imanager/wdt.h>
> +
> +/* Timer resolution */
> +#define WDT_FREQ	10 /* Hz */
> +
> +enum wdt_ctrl {
> +	START = 1,
> +	STOP,
> +	RST,
> +	GET_TIMEOUT,
> +	SET_TIMEOUT,
> +	STOPBOOT = 8,
> +};
> +
> +struct wdt_event_delay {
> +	u16	delay,
> +		pwrbtn,
> +		nmi,
> +		reset,
> +		wdpin,
> +		sci,
> +		dummy;
> +};
> +
> +static const struct imanager_watchdog_device *wd;
> +

I am not entirely happy with those static variables. Any chance
to just read it in the wdt file and pass it around ?

> +static inline int set_timer(enum wdt_ctrl ctrl)
> +{
> +	if (WARN_ON(ctrl == SET_TIMEOUT))
> +		return -EINVAL;
> +

Unnecessary error message and warning.

> +	return imanager_msg_write(EC_CMD_WDT_CTRL, ctrl, NULL);
> +}
> +
> +static int
> +wdt_ctrl(enum wdt_ctrl ctrl, enum wdt_event type, unsigned int timeout)
> +{
> +	u16 val;
> +	int ret;
> +	struct ec_message msg = {
> +		.rlen = 0,
> +		.wlen = 0,
> +	};
> +	u8 *fevent = &msg.u.data[0];
> +	struct wdt_event_delay *event =
> +				(struct wdt_event_delay *)&msg.u.data[1];
> +
> +	switch (ctrl) {
> +	case SET_TIMEOUT:
> +		memset(event, 0xff, sizeof(*event));
> +		msg.wlen = sizeof(*event);
> +		*fevent = 0;
> +		val = (!timeout) ? 0xffff : swab16(timeout * WDT_FREQ);

cpu_to_be16()

> +
> +		switch (type) {
> +		case DELAY:
> +			event->delay = val;
> +			break;
> +		case PWRBTN:
> +			event->pwrbtn = val;
> +			break;
> +		case NMI:
> +			event->nmi = val;
> +			break;
> +		case RESET:
> +			event->reset = val;
> +			break;
> +		case WDPIN:
> +			event->wdpin = val;
> +			break;
> +		case SCI:
> +			event->sci = val;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		ret = imanager_msg_write(EC_CMD_WDT_CTRL, SET_TIMEOUT, &msg);
> +		if (ret < 0) {
> +			pr_err("Failed to set timeout\n");

Please consider dropping the error messages.

> +			return ret;
> +		}
> +		break;
> +	case START:
> +	case STOP:
> +	case RST:
> +	case STOPBOOT:
> +		/* simple command, no data */
> +		return imanager_msg_write(EC_CMD_WDT_CTRL, ctrl, NULL);

Why not use simple(r) wrappers for those or just call imanager_msg_write()
directly, as you do it for set_timer() ?

Actually, you never call wdt_ctrl() with anything but SET_TIMEOUT as parameter,
so everything else in this function seems to be unused.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return timeout;
> +}
> +
> +int wdt_core_start_timer(void)
> +{
> +	return set_timer(START);
> +}
> +
> +int wdt_core_stop_timer(void)
> +{
> +	return set_timer(STOP);
> +}
> +
> +int wdt_core_reset_timer(void)
> +{
> +	return set_timer(RST);
> +}
> +
> +int wdt_core_stop_boot_timer(void)
> +{
> +	return set_timer(STOPBOOT);
> +}
> +
> +inline int wdt_core_set_timeout(enum wdt_event type, u32 timeout)
> +{
> +	return wdt_ctrl(SET_TIMEOUT, type, timeout);
> +}
> +
> +int wdt_core_disable_all(void)

What is the point of a return value which is never checked ?

> +{
> +	struct ec_message msg = {
> +		.rlen = 0,
> +		.wlen = sizeof(struct wdt_event_delay),
> +	};
> +	struct wdt_event_delay *event =
> +				(struct wdt_event_delay *)&msg.u.data[1];
> +
> +	memset(event, 0xff, sizeof(*event));
> +
> +	return  (wdt_core_stop_timer() ||
> +		 wdt_core_stop_boot_timer() ||
> +		 imanager_msg_write(EC_CMD_WDT_CTRL, SET_TIMEOUT, &msg));

Please use individual error checks here.

> +}
> +
> +int wdt_core_init(void)
> +{
> +	wd = imanager_get_watchdog_device();
> +	if (!wd)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
> diff --git a/drivers/watchdog/imanager-wdt.c b/drivers/watchdog/imanager-wdt.c
> new file mode 100644
> index 0000000..10f8e22
> --- /dev/null
> +++ b/drivers/watchdog/imanager-wdt.c
> @@ -0,0 +1,333 @@
> +/*
> + * Advantech iManager Watchdog driver
> + *
> + * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
> + * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +#include <linux/notifier.h>
> +#include <linux/reboot.h>
> +#include <linux/uaccess.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/imanager/core.h>
> +#include <linux/mfd/imanager/wdt.h>
> +
> +#define WATCHDOG_TIMEOUT 30 /* in seconds */
> +
> +static unsigned long last_updated = -1;
> +
> +static uint timeout = WATCHDOG_TIMEOUT;
> +module_param(timeout, uint, 0);
> +MODULE_PARM_DESC(timeout,
> +	"Watchdog timeout in seconds. 1 <= timeout <= 65534, default="
> +	__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +	"Watchdog cannot be stopped once started (default="
> +	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +static int wdt_start_timer(void)
> +{
> +	int ret;
> +
> +	ret = wdt_core_start_timer();
> +	if (ret < 0)
> +		return ret;
> +
> +	last_updated = jiffies;
> +
> +	return 0;
> +}
> +
> +static int wdt_stop_timer(void)
> +{
> +	int ret;
> +
> +	ret = wdt_core_stop_timer();
> +	if (ret < 0)
> +		return ret;
> +
> +	last_updated = 0;
> +
> +	return 0;
> +}
> +
> +static int wdt_ping(void)
> +{
> +	int ret;
> +
> +	ret = wdt_core_reset_timer();
> +	if (ret < 0)
> +		return ret;
> +
> +	last_updated = jiffies;
> +
> +	return 0;
> +}
> +
> +static int imanager_wdt_set(unsigned int _timeout)
> +{
> +	int ret;
> +
> +	if (timeout != _timeout)
> +		timeout = _timeout;
> +
> +	ret = wdt_core_set_timeout(PWRBTN, timeout);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (last_updated != 0)
> +		last_updated = jiffies;
> +
> +	return 0;
> +}
> +
> +static int imanager_wdt_set_timeout(struct watchdog_device *wdt_dev,
> +				    unsigned int timeout)
> +{
> +	struct imanager_device_data *idev = watchdog_get_drvdata(wdt_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&idev->lock);
> +
> +	ret = imanager_wdt_set(timeout);
> +	if (ret < 0)
> +		dev_err(wdt_dev->dev, "Failed to set timeout\n");
> +	mutex_unlock(&idev->lock);
> +
> +	return ret;
> +}
> +
> +static unsigned int imanager_wdt_get_timeleft(struct watchdog_device *wdt_dev)
> +{
> +	unsigned int timeleft = 0;
> +	unsigned long time_diff = ((jiffies - last_updated) / HZ);
> +
> +	if (last_updated && (timeout > time_diff))
> +		timeleft = timeout - time_diff;
> +

This is supposed to be provided by the hardware. Please do not implement
get_timeleft in software (if we wanted to do that we could do it in the
watchdog core).

> +	return timeleft;
> +}
> +
> +static int imanager_wdt_start(struct watchdog_device *wdt_dev)
> +{
> +	struct imanager_device_data *idev = watchdog_get_drvdata(wdt_dev);
> +	int ret = 0;

Unnecessary variable initialization.

> +
> +	mutex_lock(&idev->lock);
> +

The watchdog core handles locking for watchdog devices.

> +	ret = wdt_start_timer();
> +	if (ret < 0)
> +		dev_err(wdt_dev->dev, "Failed to start timer\n");
> +
> +	mutex_unlock(&idev->lock);
> +
> +	return ret;
> +}
> +
> +static int imanager_wdt_stop(struct watchdog_device *wdt_dev)
> +{
> +	struct imanager_device_data *idev = watchdog_get_drvdata(wdt_dev);
> +	int ret = 0;

Unnecessary variable initialization.

> +
> +	mutex_lock(&idev->lock);
> +
> +	ret = wdt_stop_timer();
> +	if (ret < 0)
> +		dev_err(wdt_dev->dev, "Failed to stop timer\n");
> +
> +	mutex_unlock(&idev->lock);
> +
> +	return ret;
> +}
> +
> +static int imanager_wdt_ping(struct watchdog_device *wdt_dev)
> +{
> +	struct imanager_device_data *idev = watchdog_get_drvdata(wdt_dev);
> +	int ret = 0;
> +
> +	mutex_lock(&idev->lock);
> +
> +	ret = wdt_ping();
> +	if (ret < 0)
> +		dev_err(wdt_dev->dev, "Failed to reset timer\n");

Please consider dropping the error messages.

> +
> +	mutex_unlock(&idev->lock);
> +
> +	return ret;
> +}
> +
> +static long imanager_wdt_ioctl(struct watchdog_device *wdt_dev,
> +			       unsigned int cmd, unsigned long arg)
> +{

Why do you re-implement this function ?

> +	struct imanager_device_data *idev = watchdog_get_drvdata(wdt_dev);
> +	void __user *argp = (void __user *)arg;
> +	int __user *p = argp;
> +	int ret = 0;
> +	int timeval, options;
> +	static const struct watchdog_info ident = {
> +		.options = WDIOF_KEEPALIVEPING |
> +			   WDIOF_SETTIMEOUT |
> +			   WDIOF_MAGICCLOSE,
> +		.firmware_version = 0,
> +		.identity = "imanager_wdt",
> +	};
> +
> +	mutex_lock(&idev->lock);
> +
> +	switch (cmd) {
> +	case WDIOC_GETSUPPORT:
> +		if (copy_to_user(argp, &ident, sizeof(ident)))
> +			ret = -EFAULT;
> +		break;
> +	case WDIOC_GETSTATUS:
> +	case WDIOC_GETBOOTSTATUS:
> +		ret = put_user(0, p);
> +		break;
> +	case WDIOC_SETOPTIONS:
> +		if (get_user(options, p)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		if (options & WDIOS_DISABLECARD)
> +			wdt_stop_timer();
> +		if (options & WDIOS_ENABLECARD) {
> +			wdt_ping();
> +			wdt_start_timer();
> +		}
> +		break;
> +	case WDIOC_KEEPALIVE:
> +		wdt_ping();
> +		break;
> +	case WDIOC_SETTIMEOUT:
> +		if (get_user(timeval, p)) {
> +			ret = -EFAULT;
> +			goto out;
> +		}
> +		if (imanager_wdt_set(timeval)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +		wdt_ping();
> +		/* Fall through */
> +	case WDIOC_GETTIMEOUT:
> +		ret = put_user(timeout, p);
> +		break;
> +	case WDIOC_GETTIMELEFT:
> +		timeval = imanager_wdt_get_timeleft(wdt_dev);
> +		ret = put_user(timeval, p);
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +	}
> +
> +out:
> +	mutex_unlock(&idev->lock);
> +
> +	return ret;
> +}
> +
> +static const struct watchdog_info imanager_wdt_info = {
> +	.options		= WDIOF_SETTIMEOUT |
> +				  WDIOF_KEEPALIVEPING |
> +				  WDIOF_MAGICCLOSE,
> +	.identity		= "imanager_wdt",
> +	.firmware_version	= 0,
> +};
> +
> +static const struct watchdog_ops imanager_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= imanager_wdt_start,
> +	.stop		= imanager_wdt_stop,
> +	.ping		= imanager_wdt_ping,
> +	.set_timeout	= imanager_wdt_set_timeout,
> +	.get_timeleft	= imanager_wdt_get_timeleft,
> +	.ioctl		= imanager_wdt_ioctl,
> +};
> +
> +static struct watchdog_device imanager_wdt_dev = {
> +	.info		= &imanager_wdt_info,
> +	.ops		= &imanager_wdt_ops,
> +	.timeout	= WATCHDOG_TIMEOUT,
> +	.min_timeout	= 1,
> +	.max_timeout	= 0xfffe,
> +};
> +
> +static int imanager_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imanager_device_data *idev = dev_get_drvdata(dev->parent);
> +	int ret;
> +
> +	if (!idev) {
> +		dev_err(dev, "Invalid platform data\n");

-ENODEV, and please no error message here.

> +		return -EINVAL;
> +	}
> +
> +	watchdog_set_nowayout(&imanager_wdt_dev, nowayout);
> +	watchdog_set_drvdata(&imanager_wdt_dev, idev);
> +
> +	ret = watchdog_register_device(&imanager_wdt_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	ret = wdt_core_init();

Shouldn't that come first, before you register the watchdog device ?

> +	if (ret) {
> +		dev_err(dev, "Failed to initialize watchdog core\n");

Please no error message here (the error indicates that there is no watchdog device,
which is controlled by the mfd driver and would be on purpose if it happens).

> +		goto unregister_driver;
> +	}
> +
> +	wdt_core_disable_all();

After registration there is a distinct possibility that the watchdog has already
been enabled by user space by the time this code executes. Disabling it here
might be racy.

> +
> +	imanager_wdt_set_timeout(&imanager_wdt_dev, timeout);
> +
Same here - in theory, user space could already have opened the watchdog device
and changed the timeout. I would suggest to use watchdog_init_timeout() prior
to registering the watchdog.

> +	dev_info(dev, "Driver loaded (timeout=%d seconds)\n", timeout);
> +
> +	return 0;
> +
> +unregister_driver:
> +	watchdog_unregister_device(&imanager_wdt_dev);
> +	platform_set_drvdata(pdev, NULL);

Unnecessary.

> +
> +	return ret;
> +}
> +
> +static int imanager_wdt_remove(struct platform_device *pdev)
> +{
> +	wdt_core_disable_all();
> +
> +	watchdog_unregister_device(&imanager_wdt_dev);
> +	platform_set_drvdata(pdev, NULL);

Unnecessary.

> +
> +	return 0;
> +}
> +
> +static struct platform_driver imanager_wdt_driver = {
> +	.driver = {
> +		.name	= "imanager_wdt",
> +	},
> +	.probe	= imanager_wdt_probe,
> +	.remove	= imanager_wdt_remove,
> +};
> +
> +module_platform_driver(imanager_wdt_driver);
> +
> +MODULE_DESCRIPTION("Advantech iManager Watchdog Driver");
> +MODULE_AUTHOR("Richard Vidal-Dorsch <richard.dorsch at advantech.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:imanager_wdt");
> diff --git a/include/linux/mfd/imanager/wdt.h b/include/linux/mfd/imanager/wdt.h
> new file mode 100644
> index 0000000..eb709b7
> --- /dev/null
> +++ b/include/linux/mfd/imanager/wdt.h
> @@ -0,0 +1,37 @@
> +/*
> + * Advantech iManager Watchdog core
> + *
> + * Copyright (C) 2016 Advantech Co., Ltd., Irvine, CA, USA
> + * Author: Richard Vidal-Dorsch <richard.dorsch@advantech.com>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +
> +#ifndef __WDT_H__
> +#define __WDT_H__
> +
> +#include <linux/types.h>
> +
> +enum wdt_event {
> +	DELAY,
> +	PWRBTN,
> +	NMI,
> +	RESET,
> +	WDPIN,
> +	SCI,
> +};
> +
> +int wdt_core_init(void);
> +
> +int wdt_core_set_timeout(enum wdt_event type, u32 timeout);
> +
> +int wdt_core_disable_all(void);
> +int wdt_core_start_timer(void);
> +int wdt_core_stop_timer(void);
> +int wdt_core_reset_timer(void);
> +int wdt_core_stop_boot_timer(void);
> +
> +#endif
>

