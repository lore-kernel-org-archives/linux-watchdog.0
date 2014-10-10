Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44620 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703AbaJJTzg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 10 Oct 2014 15:55:36 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XcgHo-002L35-0c
	for linux-watchdog@vger.kernel.org; Fri, 10 Oct 2014 19:55:36 +0000
Message-ID: <543839AA.8050808@roeck-us.net>
Date: Fri, 10 Oct 2014 12:55:22 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: John Crispin <blogic@openwrt.org>, Wim Van Sebroeck <wim@iguana.be>
CC: linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: add MT7621 watchdog support
References: <1412965669-5243-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1412965669-5243-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/10/2014 11:27 AM, John Crispin wrote:
> This patch adds support for the watchdog core found on newer mediatek/ralink
> Wifi SoCs.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>

Hi John,

> ---
>   .../devicetree/bindings/watchdog/mt7621-wdt.txt    |   12 ++
>   drivers/watchdog/Kconfig                           |    7 +
>   drivers/watchdog/Makefile                          |    1 +
>   drivers/watchdog/mt7621_wdt.c                      |  185 ++++++++++++++++++++
>   4 files changed, 205 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
>   create mode 100644 drivers/watchdog/mt7621_wdt.c
>
> diff --git a/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
> new file mode 100644
> index 0000000..c15ef0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/mt7621-wdt.txt
> @@ -0,0 +1,12 @@
> +Ralink Watchdog Timers
> +
> +Required properties:
> +- compatible: must be "mediatek,mt7621-wdt"
> +- reg: physical base address of the controller and length of the register range
> +
> +Example:
> +
> +	watchdog@100 {
> +		compatible = "mediatek,mt7621-wdt";
> +		reg = <0x100 0x10>;
> +	};
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f57312f..84c911f 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1186,6 +1186,13 @@ config RALINK_WDT
>   	help
>   	  Hardware driver for the Ralink SoC Watchdog Timer.
>
> +config MT7621_WDT
> +	tristate "Mediatek SoC watchdog"
> +	select WATCHDOG_CORE
> +	depends on SOC_MT7620 || SOC_MT7621
> +	help
> +	  Hardware driver for the Ralink SoC Watchdog Timer.
> +

The above claims to do the same. Should this be Mediatek ?

>   # PARISC Architecture
>
>   # POWERPC Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 468c320..5b2031e 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -138,6 +138,7 @@ obj-$(CONFIG_OCTEON_WDT) += octeon-wdt.o
>   octeon-wdt-y := octeon-wdt-main.o octeon-wdt-nmi.o
>   obj-$(CONFIG_LANTIQ_WDT) += lantiq_wdt.o
>   obj-$(CONFIG_RALINK_WDT) += rt2880_wdt.o
> +obj-$(CONFIG_MT7621_WDT) += mt7621_wdt.o
>
>   # PARISC Architecture
>
> diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
> new file mode 100644
> index 0000000..542ed97
> --- /dev/null
> +++ b/drivers/watchdog/mt7621_wdt.c
> @@ -0,0 +1,185 @@
> +/*
> + * Ralink RT288x/RT3xxx/MT76xx built-in hardware watchdog timer
> + *

The rt2880_wdt driver claims to do the same. Either the statement here
or there or both is wrong.

> + * Copyright (C) 2011 Gabor Juhos <juhosg@openwrt.org>
> + * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
> + *
> + * This driver was based on: drivers/watchdog/softdog.c
> + *
Seems to be based on the rt2880 driver ?

> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/watchdog.h>
> +#include <linux/miscdevice.h>

No longer needed.

> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +
> +#include <asm/mach-ralink/ralink_regs.h>
> +
> +#define SYSC_RSTSTAT			0x38
> +#define WDT_RST_CAUSE			BIT(1)
> +
> +#define RALINK_WDT_TIMEOUT		30
> +
> +#define TIMER_REG_TMRSTAT		0x00
> +#define TIMER_REG_TMR1LOAD		0x24
> +#define TIMER_REG_TMR1CTL		0x20
> +
> +#define TMR1CTL_ENABLE			BIT(7)
> +#define TMR1CTL_RESTART			BIT(9)
> +
> +static void __iomem *mt7621_wdt_base;
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		"Watchdog cannot be stopped once started (default="
> +		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");

Please align continuation lines with '('.

> +
> +static inline void rt_wdt_w32(unsigned reg, u32 val)
> +{
> +	iowrite32(val, mt7621_wdt_base + reg);
> +}
> +
> +static inline u32 rt_wdt_r32(unsigned reg)
> +{
> +	return ioread32(mt7621_wdt_base + reg);
> +}
> +
> +static int mt7621_wdt_ping(struct watchdog_device *w)
> +{
> +	rt_wdt_w32(TIMER_REG_TMRSTAT, TMR1CTL_RESTART);
> +
> +	return 0;
> +}
> +
> +static int mt7621_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
> +{
> +	w->timeout = t;
> +	rt_wdt_w32(TIMER_REG_TMR1LOAD, t * 1000);
> +	mt7621_wdt_ping(w);
> +
> +	return 0;
> +}
> +
> +static int mt7621_wdt_start(struct watchdog_device *w)
> +{
> +	u32 t;
> +
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, 1000 << 16);

Can you explain this a bit ?

> +	mt7621_wdt_set_timeout(w, w->timeout);
> +
> +	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t |= TMR1CTL_ENABLE;
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +
> +	return 0;
> +}
> +
> +static int mt7621_wdt_stop(struct watchdog_device *w)
> +{
> +	u32 t;
> +
> +	mt7621_wdt_ping(w);
> +
> +	t = rt_wdt_r32(TIMER_REG_TMR1CTL);
> +	t &= ~TMR1CTL_ENABLE;
> +	rt_wdt_w32(TIMER_REG_TMR1CTL, t);
> +
> +	return 0;
> +}
> +
> +static int mt7621_wdt_bootcause(void)
> +{
> +	if (rt_sysc_r32(SYSC_RSTSTAT) & WDT_RST_CAUSE)
> +		return WDIOF_CARDRESET;
> +
That concerns me a bit. What guarantees that rt_sysc_membase is set ?
I understand that rt2880 driver has the same problem, but that doesn't
really make it better.

> +	return 0;
> +}
> +
> +static struct watchdog_info mt7621_wdt_info = {
> +	.identity = "Mediatek Watchdog",
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +};
> +
> +static struct watchdog_ops mt7621_wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = mt7621_wdt_start,
> +	.stop = mt7621_wdt_stop,
> +	.ping = mt7621_wdt_ping,
> +	.set_timeout = mt7621_wdt_set_timeout,
> +};
> +
> +static struct watchdog_device mt7621_wdt_dev = {
> +	.info = &mt7621_wdt_info,
> +	.ops = &mt7621_wdt_ops,
> +	.min_timeout = 1,
> +};
> +
> +static int mt7621_wdt_probe(struct platform_device *pdev)
> +{
> +	struct resource *res;
> +	int ret;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mt7621_wdt_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(mt7621_wdt_base))
> +		return PTR_ERR(mt7621_wdt_base);
> +
> +	device_reset(&pdev->dev);
> +
Just wondering ... is this doing anything in the real world,
or in other words is there a reset bit (or controller, for
that matter) associated with the watchdog timer ?

I see a reset controller registration for the rl2880,
but not for the mt7621.

> +	mt7621_wdt_dev.dev = &pdev->dev;
> +	mt7621_wdt_dev.bootstatus = mt7621_wdt_bootcause();
> +	mt7621_wdt_dev.max_timeout = (0xfffful / 1000);
> +	mt7621_wdt_dev.timeout = mt7621_wdt_dev.max_timeout;
> +
Why not just set max_timeout and timeout directly in the data structure ?
Also, since the driver supports devicetree, would it make sense
to use watchdog_init_timeout to support the timeout-sec property ?

> +	watchdog_set_nowayout(&mt7621_wdt_dev, nowayout);
> +
> +	ret = watchdog_register_device(&mt7621_wdt_dev);
> +	if (!ret)
> +		dev_info(&pdev->dev, "Initialized\n");
> +
Is that noise really necessary ?

> +	return 0;
> +}
> +
> +static int mt7621_wdt_remove(struct platform_device *pdev)
> +{
> +	watchdog_unregister_device(&mt7621_wdt_dev);
> +
> +	return 0;
> +}
> +
> +static void mt7621_wdt_shutdown(struct platform_device *pdev)
> +{
> +	mt7621_wdt_stop(&mt7621_wdt_dev);
> +}
> +
> +static const struct of_device_id mt7621_wdt_match[] = {
> +	{ .compatible = "mediatek,mt7621-wdt" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt7621_wdt_match);
> +
> +static struct platform_driver mt7621_wdt_driver = {
> +	.probe		= mt7621_wdt_probe,
> +	.remove		= mt7621_wdt_remove,
> +	.shutdown	= mt7621_wdt_shutdown,
> +	.driver		= {
> +		.name		= KBUILD_MODNAME,
> +		.owner		= THIS_MODULE,
> +		.of_match_table	= mt7621_wdt_match,
> +	},
> +};
> +
> +module_platform_driver(mt7621_wdt_driver);
> +
> +MODULE_DESCRIPTION("MediaTek MT762x hardware watchdog driver");
> +MODULE_AUTHOR("John Crispin <blogic@openwrt.org");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);

No longer needed.

Thanks,
Guenter

