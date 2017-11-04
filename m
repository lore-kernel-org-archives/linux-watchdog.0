Return-Path: <gregkh@linuxfoundation.org>
Return-path: <gregkh@linuxfoundation.org>
Date: Sat, 4 Nov 2017 12:24:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	cphealy@gmail.com, Lucas Stach <l.stach@pengutronix.de>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
	Lee Jones <lee.jones@linaro.org>, Pavel Machek <pavel@ucw.cz>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v10 4/5] watchdog: Add RAVE SP watchdog driver
Message-ID: <20171104112455.GB24583@kroah.com>
References: <20171031163656.24552-1-andrew.smirnov@gmail.com>
 <20171031163656.24552-5-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171031163656.24552-5-andrew.smirnov@gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Oct 31, 2017 at 09:36:55AM -0700, Andrey Smirnov wrote:
> This driver provides access to RAVE SP watchdog functionality.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/watchdog/Kconfig       |   7 +
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/rave-sp-wdt.c | 349 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 357 insertions(+)
>  create mode 100644 drivers/watchdog/rave-sp-wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..533a72248cd1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -223,6 +223,13 @@ config ZIIRAVE_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ziirave_wdt.
>  
> +config RAVE_SP_WATCHDOG
> +	tristate "RAVE SP Watchdog timer"
> +	depends on RAVE_SP_CORE
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog on RAVE SP device.
> +
>  # ALPHA Architecture
>  
>  # ARM Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 56adf9fa67d0..5c9556c09f6e 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -223,3 +223,4 @@ obj-$(CONFIG_MAX77620_WATCHDOG) += max77620_wdt.o
>  obj-$(CONFIG_ZIIRAVE_WATCHDOG) += ziirave_wdt.o
>  obj-$(CONFIG_SOFT_WATCHDOG) += softdog.o
>  obj-$(CONFIG_MENF21BMC_WATCHDOG) += menf21bmc_wdt.o
> +obj-$(CONFIG_RAVE_SP_WATCHDOG) += rave-sp-wdt.o
> diff --git a/drivers/watchdog/rave-sp-wdt.c b/drivers/watchdog/rave-sp-wdt.c
> new file mode 100644
> index 000000000000..8a2943f7c123
> --- /dev/null
> +++ b/drivers/watchdog/rave-sp-wdt.c
> @@ -0,0 +1,349 @@
> +/*
> + *  rave-sp-wdt.c - Watchdog driver present in RAVE SP
> + *
> + * Copyright (C) 2017 Zodiac Inflight Innovation
> + *
> + * Driver for parent device can be found in drivers/mfd/rave-sp.c
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/rave-sp.h>
> +#include <linux/reboot.h>
> +#include <linux/slab.h>
> +#include <linux/watchdog.h>
> +
> +enum {
> +	RAVE_SP_RESET_BYTE = 1,
> +	RAVE_SP_RESET_REASON_NORMAL = 0,
> +	RAVE_SP_RESET_DELAY_MS = 500,
> +};
> +
> +/**
> + * struct rave_sp_wdt_variant - RAVE SP watchdog variant
> + *
> + * @max_timeout:	Largest possible watchdog timeout setting
> + * @min_timeout:	Smallest possible watchdog timeout setting
> + *
> + * @configure:		Function to send configuration command
> + * @restart:		Function to send "restart" command
> + */
> +struct rave_sp_wdt_variant {
> +	unsigned int max_timeout;
> +	unsigned int min_timeout;
> +
> +	int (*configure)(struct watchdog_device *, bool);
> +	int (*restart)(struct watchdog_device *);
> +};
> +
> +/**
> + * struct rave_sp_wdt - RAVE SP watchdog
> + *
> + * @wdd:		Underlying watchdog device
> + * @sp:			Pointer to parent RAVE SP device
> + * @variant:		Device specific variant information
> + * @reboot_notifier:	Reboot notifier implementing machine reset
> + */
> +struct rave_sp_wdt {
> +	struct watchdog_device wdd;
> +	struct rave_sp *sp;
> +	const struct rave_sp_wdt_variant *variant;
> +	struct notifier_block reboot_notifier;
> +};
> +
> +static struct rave_sp_wdt *to_rave_sp_wdt(struct watchdog_device *wdd)
> +{
> +	return container_of(wdd, struct rave_sp_wdt, wdd);
> +}
> +
> +static int rave_sp_wdt_exec(struct watchdog_device *wdd, void *data,
> +			    size_t data_size)
> +{
> +	return rave_sp_exec(to_rave_sp_wdt(wdd)->sp,
> +			    data, data_size, NULL, 0);
> +}
> +
> +static int rave_sp_wdt_legacy_configure(struct watchdog_device *wdd, bool on)
> +{
> +	u8 cmd[] = {
> +		[0] = RAVE_SP_CMD_SW_WDT,
> +		[1] = 0,
> +		[2] = 0,
> +		[3] = on,
> +		[4] = on ? wdd->timeout : 0,
> +	};
> +
> +	return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> +}
> +
> +static int rave_sp_wdt_rdu_configure(struct watchdog_device *wdd, bool on)
> +{
> +	u8 cmd[] = {
> +		[0] = RAVE_SP_CMD_SW_WDT,
> +		[1] = 0,
> +		[2] = on,
> +		[3] = (u8)wdd->timeout,
> +		[4] = (u8)(wdd->timeout >> 8),
> +	};
> +
> +	return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> +}
> +
> +/**
> + * rave_sp_wdt_configure - Configure watchdog device
> + *
> + * @wdd:	Device to configure
> + * @on:		Desired state of the watchdog timer (ON/OFF)
> + *
> + * This function configures two aspects of the watchdog timer:
> + *
> + *  - Wheither it is ON or OFF
> + *  - Its timeout duration
> + *
> + * with first aspect specified via function argument and second via
> + * the value of 'wdd->timeout'.
> + */
> +static int rave_sp_wdt_configure(struct watchdog_device *wdd, bool on)
> +{
> +	return to_rave_sp_wdt(wdd)->variant->configure(wdd, on);
> +}
> +
> +static int rave_sp_wdt_legacy_restart(struct watchdog_device *wdd)
> +{
> +	u8 cmd[] = {
> +		[0] = RAVE_SP_CMD_RESET,
> +		[1] = 0,
> +		[2] = RAVE_SP_RESET_BYTE
> +	};
> +
> +	return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> +}
> +
> +static int rave_sp_wdt_rdu_restart(struct watchdog_device *wdd)
> +{
> +	u8 cmd[] = {
> +		[0] = RAVE_SP_CMD_RESET,
> +		[1] = 0,
> +		[2] = RAVE_SP_RESET_BYTE,
> +		[3] = RAVE_SP_RESET_REASON_NORMAL
> +	};
> +
> +	return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> +}
> +
> +static int rave_sp_wdt_reboot_notifier(struct notifier_block *nb,
> +				       unsigned long action, void *data)
> +{
> +	/*
> +	 * Restart handler is called in atomic context which means we
> +	 * can't communicate to SP via UART. Luckily for use SP will
> +	 * wait 500ms before actually resetting us, so we ask it to do
> +	 * so here and let the rest of the system go on wrapping
> +	 * things up.
> +	 */
> +	if (action == SYS_DOWN || action == SYS_HALT) {
> +		struct rave_sp_wdt *sp_wd =
> +			container_of(nb, struct rave_sp_wdt, reboot_notifier);
> +
> +		const int ret = sp_wd->variant->restart(&sp_wd->wdd);
> +
> +		if (ret < 0)
> +			dev_err(sp_wd->wdd.parent,
> +				"Failed to issue restart command (%d)", ret);
> +		return NOTIFY_OK;
> +	}
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static int rave_sp_wdt_restart(struct watchdog_device *wdd,
> +			       unsigned long action, void *data)
> +{
> +	/*
> +	 * The actual work was done by reboot notifier above. SP
> +	 * firmware waits 500 ms before issuing reset, so let's hang
> +	 * here for twice that delay and hopefuly we'd never reach
> +	 * the return statement.
> +	 */
> +	mdelay(2 * RAVE_SP_RESET_DELAY_MS);
> +
> +	return -EIO;
> +}
> +
> +static int rave_sp_wdt_start(struct watchdog_device *wdd)
> +{
> +	int ret;
> +
> +	ret = rave_sp_wdt_configure(wdd, true);
> +	if (!ret)
> +		set_bit(WDOG_HW_RUNNING, &wdd->status);
> +
> +	return ret;
> +}
> +
> +static int rave_sp_wdt_stop(struct watchdog_device *wdd)
> +{
> +	return rave_sp_wdt_configure(wdd, false);
> +}
> +
> +static int rave_sp_wdt_set_timeout(struct watchdog_device *wdd,
> +				   unsigned int timeout)
> +{
> +	wdd->timeout = timeout;
> +
> +	return rave_sp_wdt_configure(wdd, watchdog_active(wdd));
> +}
> +
> +static int rave_sp_wdt_ping(struct watchdog_device *wdd)
> +{
> +	u8 cmd[] = {
> +		[0] = RAVE_SP_CMD_PET_WDT,
> +		[1] = 0,
> +	};
> +
> +	return rave_sp_wdt_exec(wdd, cmd, sizeof(cmd));
> +}
> +
> +static const struct watchdog_info rave_sp_wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "RAVE SP Watchdog",
> +};
> +
> +static const struct watchdog_ops rave_sp_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = rave_sp_wdt_start,
> +	.stop = rave_sp_wdt_stop,
> +	.ping = rave_sp_wdt_ping,
> +	.set_timeout = rave_sp_wdt_set_timeout,
> +	.restart = rave_sp_wdt_restart,
> +};
> +
> +static const struct of_device_id rave_sp_wdt_of_match[] = {
> +	{ .compatible = "zii,rave-sp-watchdog" },
> +	{}
> +};
> +
> +static const struct rave_sp_wdt_variant rave_sp_wdt_legacy = {
> +	.max_timeout = 255,
> +	.min_timeout = 1,
> +	.configure = rave_sp_wdt_legacy_configure,
> +	.restart   = rave_sp_wdt_legacy_restart,
> +};
> +
> +static const struct rave_sp_wdt_variant rave_sp_wdt_rdu = {
> +	.max_timeout = 180,
> +	.min_timeout = 60,
> +	.configure = rave_sp_wdt_rdu_configure,
> +	.restart   = rave_sp_wdt_rdu_restart,
> +};
> +
> +static const struct of_device_id rave_sp_wdt_variants[] = {
> +	{ .compatible = COMPATIBLE_RAVE_SP_NIU,  .data = &rave_sp_wdt_legacy },
> +	{ .compatible = COMPATIBLE_RAVE_SP_MEZZ, .data = &rave_sp_wdt_legacy },
> +	{ .compatible = COMPATIBLE_RAVE_SP_ESB,  .data = &rave_sp_wdt_legacy },
> +	{ .compatible = COMPATIBLE_RAVE_SP_RDU1, .data = &rave_sp_wdt_rdu    },
> +	{ .compatible = COMPATIBLE_RAVE_SP_RDU2, .data = &rave_sp_wdt_rdu    },
> +	{ /* sentinel */ }
> +};
> +
> +static int rave_sp_wdt_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *id;
> +	struct watchdog_device *wdd;
> +	struct rave_sp_wdt *sp_wd;
> +	struct nvmem_cell *cell;
> +	__le16 timeout = 0;
> +	int ret;
> +
> +	id = of_match_device(rave_sp_wdt_variants, dev->parent);
> +	if (!id) {
> +		dev_err(dev, "Unknown parent device variant. Bailing out\n");
> +		return -ENODEV;
> +	}
> +
> +	sp_wd = devm_kzalloc(dev, sizeof(*sp_wd), GFP_KERNEL);
> +	if (!sp_wd)
> +		return -ENOMEM;
> +
> +	sp_wd->variant = id->data;
> +	sp_wd->sp      = dev_get_drvdata(dev->parent);
> +
> +	wdd              = &sp_wd->wdd;
> +	wdd->parent      = dev;
> +	wdd->info        = &rave_sp_wdt_info;
> +	wdd->ops         = &rave_sp_wdt_ops;
> +	wdd->min_timeout = sp_wd->variant->min_timeout;
> +	wdd->max_timeout = sp_wd->variant->max_timeout;
> +	wdd->status      = WATCHDOG_NOWAYOUT_INIT_STATUS;
> +	wdd->timeout     = 60;
> +
> +	cell = nvmem_cell_get(dev, "wdt-timeout");
> +	if (!IS_ERR(cell)) {
> +		size_t len;
> +		void *value = nvmem_cell_read(cell, &len);
> +
> +		if (!IS_ERR(value)) {
> +			memcpy(&timeout, value, min(len, sizeof(timeout)));
> +			kfree(value);
> +		}
> +		nvmem_cell_put(cell);
> +	}
> +	watchdog_init_timeout(wdd, le16_to_cpu(timeout), dev);
> +	watchdog_set_restart_priority(wdd, 255);
> +
> +	sp_wd->reboot_notifier.notifier_call = rave_sp_wdt_reboot_notifier;
> +	ret = devm_register_reboot_notifier(dev, &sp_wd->reboot_notifier);
> +	if (ret) {
> +		dev_err(dev, "Failed to register reboot notifier\n");
> +		return ret;
> +	}
> +
> +	/*
> +	 * We don't know if watchdog is running now. To be sure, let's
> +	 * start it and depend on watchdog core to ping it
> +	 */
> +	wdd->max_hw_heartbeat_ms = wdd->max_timeout * 1000;
> +	ret = rave_sp_wdt_start(wdd);
> +	if (ret) {
> +		dev_err(dev, "Watchdog didn't start\n");
> +		return ret;
> +	}
> +
> +	return devm_watchdog_register_device(dev, wdd);
> +}
> +
> +static struct platform_driver rave_sp_wdt_driver = {
> +	.probe = rave_sp_wdt_probe,

No remove?  :)
