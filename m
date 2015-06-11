Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48449 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025AbbFKWFA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Jun 2015 18:05:00 -0400
Message-ID: <557A0605.3050609@roeck-us.net>
Date: Thu, 11 Jun 2015 15:04:53 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Christian Gmeiner <christian.gmeiner@gmail.com>,
	linux-kernel@vger.kernel.org
CC: sameo@linux.intel.com, lee.jones@linaro.org, wsa@the-dreams.de,
	jdelvare@suse.de, linux-i2c@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org, jingoohan1@gmail.com,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/4] watchdog: Add Congatec CGEB watchdog driver
References: <1434055734-3602-1-git-send-email-christian.gmeiner@gmail.com> <1434055734-3602-4-git-send-email-christian.gmeiner@gmail.com>
In-Reply-To: <1434055734-3602-4-git-send-email-christian.gmeiner@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/11/2015 01:48 PM, Christian Gmeiner wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
>
> This driver provides support for the CGEB watchdog found on some
> Congatec x86 modules.
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>

Hi Christian,

comments inline.

Thanks,
Guenter

> ---
>   drivers/watchdog/Kconfig                  |  10 ++
>   drivers/watchdog/Makefile                 |   3 +
>   drivers/watchdog/congatec_cgeb_watchdog.c | 181 ++++++++++++++++++++++++++++++
>   3 files changed, 194 insertions(+)
>   create mode 100644 drivers/watchdog/congatec_cgeb_watchdog.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e5e7c55..bb93cbc 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1088,6 +1088,16 @@ config SBC_EPX_C3_WATCHDOG
>   	  To compile this driver as a module, choose M here: the
>   	  module will be called sbc_epx_c3.
>
> +config CONGATEC_CGEB_WATCHDOG
> +	tristate "Congatec CGEB watchdog"
> +	depends on MFD_CONGATEC_CGEB
> +	---help---
> +	  This driver provides support for the watchdogs found on Congatec
> +	  modules with the CGEB BIOS interface.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called congatec_cgeb_wdt.
> +
>   # M32R Architecture
>
>   # M68K Architecture
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 5c19294..b24fd09 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -171,6 +171,9 @@ obj-$(CONFIG_SH_WDT) += shwdt.o
>   obj-$(CONFIG_WATCHDOG_RIO)		+= riowd.o
>   obj-$(CONFIG_WATCHDOG_CP1XXX)		+= cpwd.o
>
> +# X86 Architecture
> +obj-$(CONFIG_CONGATEC_CGEB_WATCHDOG) += congatec_cgeb_watchdog.o
> +

No need for a second set of x86 drivers. Please add to the existing set.
Also, please align with other '+='.


>   # XTENSA Architecture
>
>   # Xen
> diff --git a/drivers/watchdog/congatec_cgeb_watchdog.c b/drivers/watchdog/congatec_cgeb_watchdog.c
> new file mode 100644
> index 0000000..e4523c4
> --- /dev/null
> +++ b/drivers/watchdog/congatec_cgeb_watchdog.c
> @@ -0,0 +1,181 @@
> +/*
> + * CGEB watchdog driver
> + *
> + * (c) 2011 Sascha Hauer, Pengutronix

2011 ?

> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; version 2 of the License.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +#include <linux/mfd/congatec-cgeb.h>
> +
> +#define CGOS_WDOG_MODE_REBOOT_PC    0
> +#define CGOS_WDOG_MODE_RESTART_OS   1
> +#define CGOS_WDOG_MODE_STAGED    0x80
> +
> +#define CGOS_WDOG_OPMODE_DISABLED      0
> +#define CGOS_WDOG_OPMODE_ONETIME_TRIG  1
> +#define CGOS_WDOG_OPMODE_SINGLE_EVENT  2
> +#define CGOS_WDOG_OPMODE_EVENT_REPEAT  3
> +
> +#define CGOS_WDOG_EVENT_INT 0  /* NMI/IRQ */
> +#define CGOS_WDOG_EVENT_SCI 1  /* SMI/SCI */
> +#define CGOS_WDOG_EVENT_RST 2  /* system reset */
> +#define CGOS_WDOG_EVENT_BTN 3  /* power button */
> +
> +#define CGOS_WDOG_EVENT_MAX_STAGES 3
> +
Please use tabs after the defines.

#define CGOS_WDOG_MODE_REBOOT_PC	0
#define CGOS_WDOG_MODE_RESTART_OS	1
#define CGOS_WDOG_MODE_STAGED		0x80

#define CGOS_WDOG_OPMODE_DISABLED	0
#define CGOS_WDOG_OPMODE_ONETIME_TRIG	1
#define CGOS_WDOG_OPMODE_SINGLE_EVENT	2
#define CGOS_WDOG_OPMODE_EVENT_REPEAT	3

and so on.

> +struct cgeb_watchdog_stage {
> +	unsigned long timeout;
> +	unsigned long event;
> +};
> +
> +struct cgeb_watchdog_config {
> +	unsigned long size;
> +	unsigned long timeout; /* not used in staged mode */
> +	unsigned long delay;
> +	unsigned long mode;
> +	/* optional parameters for staged watchdog */
> +	unsigned long op_mode;
> +	unsigned long stage_count;
> +	struct cgeb_watchdog_stage stages[CGOS_WDOG_EVENT_MAX_STAGES];
> +};
> +
Since this is passed on to cgeb_call, shoul it be part of an API
defined elsewhere ?

Also, I am a bit concerned about the use of 'unsigned long'.
If this is part of an ABI to the BIOS, shouldn't it be u32 ?
Sure, the driver is currently limited to X64_32, but that doesn't
mean we have to make it extra difficult to port it to X86_64
if that is ever asked for.

> +struct cgeb_watchdog_priv {
> +	struct cgeb_board_data  *board;
> +	struct watchdog_device  wdd;
> +	unsigned int            timeout_s;
> +	int unit;
> +};
> +
> +static struct watchdog_info cgeb_wdd_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.firmware_version = 0,

No need to initialize static variables with 0.

> +	.identity = "cgeb watchdog",
> +};
> +
Please move the above next to the probe function.

> +static unsigned int watchdog_set_config(struct cgeb_watchdog_priv *priv,
> +		unsigned int timeout_s)
> +{
> +	struct cgeb_board_data *board = priv->board;
> +	struct cgeb_watchdog_config wdi;
> +	struct cgeb_function_parameters fps;
> +
						= { 0 };

> +	memset(&wdi, 0, sizeof(wdi));
> +	memset(&fps, 0, sizeof(fps));

would be identical to the memset.

> +
> +	fps.unit = priv->unit;
> +	fps.iptr = &wdi;
> +
> +	wdi.timeout = timeout_s * 1000;
> +	wdi.delay = 0;

Already set to 0.

> +	wdi.size = sizeof(wdi);
> +	wdi.mode = CGOS_WDOG_MODE_REBOOT_PC;
> +
> +	return cgeb_call(board, &fps, CgebWDogSetConfig);
> +}
> +
> +static int cgeb_watchdog_start(struct watchdog_device *wdd)
> +{
> +	struct cgeb_watchdog_priv *priv = watchdog_get_drvdata(wdd);
> +
> +	return watchdog_set_config(priv, priv->timeout_s);
> +}
> +
> +static int cgeb_watchdog_stop(struct watchdog_device *wdd)
> +{
> +	struct cgeb_watchdog_priv *priv = watchdog_get_drvdata(wdd);
> +
> +	return watchdog_set_config(priv, 0);
> +}
> +
> +static int cgeb_watchdog_set_timeout(struct watchdog_device *wdd,
> +		unsigned int timeout_s)

Please align continuation lines with '('.

> +{
> +	struct cgeb_watchdog_priv *priv = watchdog_get_drvdata(wdd);
> +
> +	if (!timeout_s)
> +		return -EINVAL;

Unnecessary, checked by infrastructure.

> +
> +	priv->timeout_s = timeout_s;
> +
You also need to set wdd->timeout. It also seems to me that
priv->timeout_s is not really necessary.

> +	return 0;
> +}
> +
> +struct watchdog_ops cgeb_watchdog_ops = {
> +	.start = cgeb_watchdog_start,
> +	.stop = cgeb_watchdog_stop,
> +	.set_timeout = cgeb_watchdog_set_timeout,
> +};
> +
> +static int cgeb_watchdog_probe(struct platform_device *pdev)
> +{
> +	struct cgeb_watchdog_priv *priv;
> +	struct cgeb_pdata *pdata = pdev->dev.platform_data;
> +	int ret;
> +
> +	dev_info(&pdev->dev, "registering\n");

Unnecessary noise.

> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->wdd.ops = &cgeb_watchdog_ops;
> +	priv->wdd.info = &cgeb_wdd_info;
> +	priv->wdd.min_timeout = 1;
> +	priv->wdd.max_timeout = 3600;
> +	priv->board = pdata->board;

You should check if pdata == NULL and either use defaults
in that case or bail out.

> +	priv->unit = pdata->unit;
> +
> +	watchdog_set_drvdata(&priv->wdd, priv);
> +	platform_set_drvdata(pdev, priv);
> +
> +	ret = watchdog_register_device(&priv->wdd);
> +	if (ret)
> +		return ret;
> +
> +	return 0;

just
	return watchdog_register_device(&priv->wdd);

> +}
> +
> +static int cgeb_watchdog_remove(struct platform_device *pdev)
> +{
> +	struct cgeb_watchdog_priv *priv = platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&priv->wdd);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cgeb_watchdog_driver = {
> +	.probe          = cgeb_watchdog_probe,
> +	.remove         = __exit_p(cgeb_watchdog_remove),
> +	.driver = {
> +		.name   = "cgeb-watchdog",
> +		.owner  = THIS_MODULE,

AFAIK .owner is no longer necessary.

> +	},
> +};
> +
> +static int __init cgeb_watchdog_driver_init(void)
> +{
> +	return platform_driver_register(&cgeb_watchdog_driver);
> +}
> +
> +static void __exit cgeb_watchdog_driver_exit(void)
> +{
> +	platform_driver_unregister(&cgeb_watchdog_driver);
> +}
> +
> +module_init(cgeb_watchdog_driver_init);
> +module_exit(cgeb_watchdog_driver_exit);

module_platform_driver(cgeb_watchdog_driver);

> +
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> +MODULE_DESCRIPTION("cgeb watchdog driver");
> +MODULE_LICENSE("GPL");
>

