Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35037 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753393AbcLOQrY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 15 Dec 2016 11:47:24 -0500
Subject: Re: [PATCH v4] watchdog: nic7018_wdt: Add NIC7018 watchdog driver
To: Hui Chun Ong <hui.chun.ong@ni.com>, wim@iguana.be, corbet@lwn.net
References: <1481796336-86605-1-git-send-email-hui.chun.ong@ni.com>
Cc: linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
        jonathan.hearn@ni.com, julia.cartwright@ni.com, rjw@rjwysocki.net,
        mika.westerberg@linux.intel.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4d192765-8e59-debc-bb50-484f9b523647@roeck-us.net>
Date: Thu, 15 Dec 2016 08:47:19 -0800
MIME-Version: 1.0
In-Reply-To: <1481796336-86605-1-git-send-email-hui.chun.ong@ni.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,

On 12/15/2016 02:05 AM, Hui Chun Ong wrote:
> Add support for the watchdog timer on PXI Embedded Controller.
>
> Signed-off-by: Hui Chun Ong <hui.chun.ong@ni.com>
> ---
> v3: Update timeout calculation from miliseconds to seconds.
>     Reorder watchdog_regiser_device() call to prevent potential race condition.
>
> v2: Remove mutex lock and platform_device *pdev fields from struct nic7018_wdt.
>     Update config NIC7018_WDT description.
>     Update nic7018_get_config() to never return error.
>     Remove checking for IO resource size in nic7018_probe().
>
> v1: Remove non-standard attributes.
>     Change from acpi_driver to platform_driver.
>     Rename driver from ni7018_wdt to nic7018_wdt.
> ---
>  Documentation/watchdog/watchdog-parameters.txt |   5 +
>  drivers/watchdog/Kconfig                       |  10 +
>  drivers/watchdog/Makefile                      |   1 +
>  drivers/watchdog/nic7018_wdt.c                 | 265 +++++++++++++++++++++++++
>  4 files changed, 281 insertions(+)
>  create mode 100644 drivers/watchdog/nic7018_wdt.c
>

[ ... ]

> +
> +static int nic7018_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct watchdog_device *wdd;
> +	struct nic7018_wdt *wdt;
> +	struct resource *io_rc;
> +	int ret;
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	io_rc = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (!io_rc) {
> +		dev_err(dev, "missing IO resources\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!devm_request_region(dev, io_rc->start, resource_size(io_rc),
> +				 KBUILD_MODNAME)) {
> +		dev_err(dev, "failed to get IO region\n");
> +		return -EBUSY;
> +	}
> +
> +	wdt->io_base = io_rc->start;
> +	wdd = &wdt->wdd;
> +	wdd->info = &nic7018_wdd_info;
> +	wdd->ops = &nic7018_wdd_ops;
> +	wdd->min_timeout = WDT_MIN_TIMEOUT;
> +	wdd->max_timeout = WDT_MAX_TIMEOUT;
> +	wdd->timeout = WDT_DEFAULT_TIMEOUT;
> +	wdd->parent = dev;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	ret = watchdog_init_timeout(wdd, timeout, dev);
> +	if (ret)
> +		dev_warn(dev, "unable to set timeout value, using default\n");
> +
> +	/* Unlock WDT register */
> +	outb(UNLOCK, wdt->io_base + WDT_REG_LOCK);
> +
> +	ret = watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(dev, "failed to register watchdog\n");

I don't want to be annoying, but for consistency you'll need to lock the device here.

> +		return ret;
> +	}
> +
> +	dev_dbg(dev, "io_base=0x%04X, timeout=%d, nowayout=%d\n",
> +		wdt->io_base, timeout, nowayout);
> +	return 0;
> +}
> +
> +static int nic7018_remove(struct platform_device *pdev)
> +{
> +	struct nic7018_wdt *wdt = platform_get_drvdata(pdev);
> +
> +	nic7018_stop(&wdt->wdd);

This always bothers me. I _think_ the core will prevent a driver from unloading
while the watchdog is running open (and thus might be running), which would make
this unnecessary. But I am never really sure and will have to look it up.

Guenter

> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	/* Lock WDT register */
> +	outb(LOCK, wdt->io_base + WDT_REG_LOCK);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id nic7018_device_ids[] = {
> +	{"NIC7018", 0},
> +	{"", 0},
> +};
> +MODULE_DEVICE_TABLE(acpi, nic7018_device_ids);
> +
> +static struct platform_driver watchdog_driver = {
> +	.probe = nic7018_probe,
> +	.remove = nic7018_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.acpi_match_table = ACPI_PTR(nic7018_device_ids),
> +	},
> +};
> +
> +module_platform_driver(watchdog_driver);
> +
> +MODULE_DESCRIPTION("National Instruments NIC7018 Watchdog driver");
> +MODULE_AUTHOR("Hui Chun Ong <hui.chun.ong@ni.com>");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

