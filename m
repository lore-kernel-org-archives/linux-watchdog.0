Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35267 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbbJ3R2P (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 30 Oct 2015 13:28:15 -0400
Received: by wicll6 with SMTP id ll6so15223944wic.0
        for <linux-watchdog@vger.kernel.org>; Fri, 30 Oct 2015 10:28:14 -0700 (PDT)
Date: Fri, 30 Oct 2015 17:28:07 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 3/5] watchdog: ts4800: add driver for TS-4800 watchdog
Message-ID: <20151030172807.GD4058@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1446150450-22093-4-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1446150450-22093-4-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable


Where is your change-log?

I have no idea what the intention of this patch is.

> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  .../devicetree/bindings/mfd/ts4800-syscon.txt      |   8 +
>  .../devicetree/bindings/watchdog/ts4800-wdt.txt    |  12 ++

These should be in a seperate patch.

>  drivers/mfd/Kconfig                                |   1 +
>  drivers/mfd/ts4800-syscon.c                        |  13 +-
>  drivers/watchdog/Kconfig                           |  10 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/ts4800_wdt.c                      | 216 +++++++++++++=
++++++++
>  7 files changed, 260 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/ts4800-w=
dt.txt
>  create mode 100644 drivers/watchdog/ts4800_wdt.c
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt b/=
Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> index 8dbc12c..8c0fd1d 100644
> --- a/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> +++ b/Documentation/devicetree/bindings/mfd/ts4800-syscon.txt
> @@ -4,9 +4,17 @@ Required properties:
>  - compatible : must be "ts,ts4800-syscon"
>  - reg : physical base address and length of memory mapped region
> =20
> +The driver exposes following subdevices:
> +- a watchdog: see ../watchdog/ts4800-wdt.txt
> +
>  Example:
> =20
>  syscon@b0010000 {
>  	compatible =3D "ts,ts4800-syscon";
>  	reg =3D <0xb0010000 0x3d>;
> +
> +	wdt@e {
> +		compatible =3D "ts,ts4800-wdt";
> +		offset =3D <0xe>;
> +	};
>  };
> diff --git a/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt =
b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> new file mode 100644
> index 0000000..a9305c2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/ts4800-wdt.txt
> @@ -0,0 +1,12 @@
> +Technologic Systems Watchdog
> +
> +Required properties:
> +- compatible : must be "ts,ts4800-wdt"
> +- offset : offset of the feed register from syscon base
> +
> +Example:
> +
> +wdt1: wdt@b0010000 {
> +	compatible =3D "ts,ts4800-wdt";
> +	offset =3D <0xe>;
> +};
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 8f03dce..95ba036 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1304,6 +1304,7 @@ config MFD_TC6393XB
> =20
>  config MFD_TS4800_SYSCON
>  	tristate "TS-4800 Syscon Support"
> +	select MFD_CORE
>  	select REGMAP
>  	select REGMAP_MMIO
>  	help

This change is orthogonal and has not place in this patch.

> diff --git a/drivers/mfd/ts4800-syscon.c b/drivers/mfd/ts4800-syscon.c
> index 1e42e96..03b3b04a 100644
> --- a/drivers/mfd/ts4800-syscon.c
> +++ b/drivers/mfd/ts4800-syscon.c
> @@ -24,6 +24,13 @@
>  #include <linux/mfd/ts4800-syscon.h>
> =20
> =20
> +static const struct mfd_cell ts4800_syscon_cells[] =3D {
> +	{
> +		.name =3D "ts4800-watchdog",
> +		.of_compatible =3D "ts,ts4800-wdt",
> +	},
> +};
> +
>  static const struct regmap_config ts4800_regmap_config =3D {
>  	.reg_bits =3D 32,
>  	.reg_stride =3D 2,
> @@ -56,11 +63,15 @@ static int ts4800_syscon_probe(struct platform_devi=
ce *pdev)
> =20
>  	platform_set_drvdata(pdev, syscon);
> =20
> -	return 0;
> +	return mfd_add_devices(&pdev->dev, -1, ts4800_syscon_cells,
> +			       ARRAY_SIZE(ts4800_syscon_cells),
> +			       NULL, 0, NULL);
>  }
> =20
>  static int ts4800_syscon_remove(struct platform_device *pdev)
>  {
> +	mfd_remove_devices(&pdev->dev);
> +
>  	return 0;
>  }
> =20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 241fafd..aaa42b8 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -417,6 +417,16 @@ config NUC900_WATCHDOG
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nuc900_wdt.
> =20
> +config TS4800_WATCHDOG
> +	tristate "TS-4800 Watchdog"
> +	depends on OF
> +	depends on MFD_TS4800_SYSCON
> +	select WATCHDOG_CORE
> +	help
> +	  Technologic Systems TS-4800 has watchdog timer implemented in
> +	  an external FPGA. Say Y here if you want to support for the
> +	  watchdog timer on TS-4800 board.
> +
>  config TS72XX_WATCHDOG
>  	tristate "TS-72XX SBC Watchdog"
>  	depends on MACH_TS72XX
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 59ea9a1..435fc93 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_RN5T618_WATCHDOG) +=3D rn5t618_wdt.o
>  obj-$(CONFIG_COH901327_WATCHDOG) +=3D coh901327_wdt.o
>  obj-$(CONFIG_STMP3XXX_RTC_WATCHDOG) +=3D stmp3xxx_rtc_wdt.o
>  obj-$(CONFIG_NUC900_WATCHDOG) +=3D nuc900_wdt.o
> +obj-$(CONFIG_TS4800_WATCHDOG) +=3D ts4800_wdt.o
>  obj-$(CONFIG_TS72XX_WATCHDOG) +=3D ts72xx_wdt.o
>  obj-$(CONFIG_IMX2_WDT) +=3D imx2_wdt.o
>  obj-$(CONFIG_UX500_WATCHDOG) +=3D ux500_wdt.o
> diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wd=
t.c
> new file mode 100644
> index 0000000..9b9e638
> --- /dev/null
> +++ b/drivers/watchdog/ts4800_wdt.c
> @@ -0,0 +1,216 @@
> +/*
> + * ts4800_wdt.c - Watchdog driver for TS-4800 based boards
> + *
> + * Copyright (c) 2015 - Savoir-faire Linux
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/mfd/ts4800-syscon.h>
> +
> +static bool nowayout =3D WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +	"Watchdog cannot be stopped once started (default=3D"
> +	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +
> +/* possible feed values */
> +#define TS4800_WDT_FEED_2S	0x1
> +#define TS4800_WDT_FEED_10S	0x2
> +#define TS4800_WDT_DISABLE	0x3
> +
> +
> +struct ts4800_wdt {
> +	struct watchdog_device  wdd;
> +	struct regmap           *regmap;
> +	u32                     feed_offset;
> +	u16                     feed_val;
> +};
> +
> +/*
> + * TS-4800 supports the following timeout values:
> + *
> + *   value desc
> + *   ---------------------
> + *     0    feed for 338ms
> + *     1    feed for 2.706s
> + *     2    feed for 10.824s
> + *     3    disable watchdog
> + *
> + * Keep the regmap/timeout map ordered by timeout
> + */
> +static const struct {
> +	const int timeout;
> +	const int regval;
> +} ts4800_wdt_map[] =3D {
> +	{ 2,  TS4800_WDT_FEED_2S },
> +	{ 10, TS4800_WDT_FEED_10S },
> +};
> +
> +static int timeout_to_regval(struct watchdog_device *wdd, int new_time=
out)
> +{
> +	int i;
> +
> +	new_timeout =3D clamp_val(new_timeout,
> +				wdd->min_timeout, wdd->max_timeout);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ts4800_wdt_map); i++) {
> +		if (ts4800_wdt_map[i].timeout >=3D new_timeout)
> +			return ts4800_wdt_map[i].timeout;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static void ts4800_write_feed(struct ts4800_wdt *wdt, u16 val)
> +{
> +	regmap_write(wdt->regmap, wdt->feed_offset, val);
> +}
> +
> +static int ts4800_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct ts4800_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +
> +	ts4800_write_feed(wdt, wdt->feed_val);
> +	return 0;
> +}
> +
> +static int ts4800_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct ts4800_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +
> +	ts4800_write_feed(wdt, TS4800_WDT_DISABLE);
> +	return 0;
> +}
> +
> +static int ts4800_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int new_timeout)
> +{
> +	struct ts4800_wdt *wdt =3D watchdog_get_drvdata(wdd);
> +	int val =3D timeout_to_regval(wdd, new_timeout);
> +
> +	if (val < 0)
> +		return val;
> +
> +	wdt->feed_val =3D (u16) val;
> +
> +	return 0;
> +}
> +
> +static const struct watchdog_ops ts4800_wdt_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	/*
> +	 * pinging the watchdog enables it, so use same function
> +	 * for pinging and starting the watchdog
> +	 */
> +	.start =3D ts4800_wdt_ping,
> +	.stop =3D ts4800_wdt_stop,
> +	.ping =3D ts4800_wdt_ping,
> +	.set_timeout =3D ts4800_wdt_set_timeout,
> +};
> +
> +static const struct watchdog_info ts4800_wdt_info =3D {
> +	.options =3D WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE | WDIOF_KEEPALIVEPIN=
G,
> +	.identity =3D "TS-4800 Watchdog",
> +};
> +
> +static int ts4800_wdt_probe(struct platform_device *pdev)
> +{
> +	int max_timeout_index =3D ARRAY_SIZE(ts4800_wdt_map) - 1;
> +	struct device_node *np =3D pdev->dev.of_node;
> +	struct ts4800_syscon *syscon;
> +	struct watchdog_device *wdd;
> +	struct ts4800_wdt *wdt;
> +	u32 offset;
> +	int ret;
> +
> +	ret =3D of_property_read_u32(np, "offset", &offset);
> +	if (ret) {
> +		dev_err(&pdev->dev, "An offset must be provided\n");
> +		return -EINVAL;
> +	}
> +
> +	/* allocate memory for watchdog struct */
> +	wdt =3D devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	/* set regmap and offset to know where to write */
> +	syscon =3D dev_get_drvdata(pdev->dev.parent);
> +	wdt->regmap =3D syscon->regmap;
> +	wdt->feed_offset =3D offset;
> +
> +	/* Initialize struct watchdog_device */
> +	wdd =3D &wdt->wdd;
> +	wdd->info =3D &ts4800_wdt_info;
> +	wdd->ops =3D &ts4800_wdt_ops;
> +	wdd->min_timeout =3D ts4800_wdt_map[0].timeout;
> +	wdd->max_timeout =3D ts4800_wdt_map[max_timeout_index].timeout;
> +	wdd->timeout =3D wdd->max_timeout;
> +	wdt->feed_val =3D ts4800_wdt_map[max_timeout_index].regval;
> +
> +	watchdog_set_drvdata(wdd, wdt);
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	/*
> +	 * Must be called after watchdog_set_drvdata to dereference a valid
> +	 * pointer. The feed register is write-only, so it is not possible to
> +	 * determine if watchdog is already started or not. Disable it to be =
in
> +	 * a known state.
> +	 */
> +	ts4800_wdt_stop(wdd);
> +
> +	ret =3D watchdog_register_device(wdd);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"failed to register watchdog device\n");
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, wdt);
> +
> +	dev_info(&pdev->dev,
> +		 "initialized (timeout =3D %d sec, nowayout =3D %d)\n",
> +		 wdd->timeout, nowayout);
> +
> +	return 0;
> +}
> +
> +static int ts4800_wdt_remove(struct platform_device *pdev)
> +{
> +	struct ts4800_wdt *wdt =3D platform_get_drvdata(pdev);
> +
> +	watchdog_unregister_device(&wdt->wdd);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ts4800_wdt_of_match[] =3D {
> +	{ .compatible =3D "ts,ts4800-wdt", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ts4800_wdt_of_match);
> +
> +static struct platform_driver ts4800_wdt_driver =3D {
> +	.probe		=3D ts4800_wdt_probe,
> +	.remove		=3D ts4800_wdt_remove,
> +	.driver		=3D {
> +		.name	=3D "ts4800_wdt",
> +		.of_match_table =3D ts4800_wdt_of_match,
> +	},
> +};
> +
> +module_platform_driver(ts4800_wdt_driver);
> +
> +MODULE_AUTHOR("Damien Riegel <damien.riegel@savoirfairelinux.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ts4800_wdt");

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
