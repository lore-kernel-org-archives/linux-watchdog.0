Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:60567 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830AbbJTHtN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 20 Oct 2015 03:49:13 -0400
Subject: Re: [PATCH] watchdog: add Alphascale asm9260-wdt driver
To: linux-watchdog@vger.kernel.org, wim@iguana.be
References: <1442568212-15509-1-git-send-email-linux@rempel-privat.de>
From: Oleksij Rempel <linux@rempel-privat.de>
Message-ID: <5625F1F6.2090505@rempel-privat.de>
Date: Tue, 20 Oct 2015 09:49:10 +0200
MIME-Version: 1.0
In-Reply-To: <1442568212-15509-1-git-send-email-linux@rempel-privat.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="1POrRkre16bd8U2ncjm4mwiedVjJ9J34G"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1POrRkre16bd8U2ncjm4mwiedVjJ9J34G
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hallo all,

any feedback here? or it can be merged?

Am 18.09.2015 um 11:23 schrieb Oleksij Rempel:
> Add WD support for Alphascale asm9260 SoC. This driver
> provide support for different function modes:
> - HW mode to trigger SoC reset on timeout
> - SW mode do soft reset if needed
> - DEBUG mode
>=20
> Optional support for stopping watchdog. If reset binding are not provid=
ed
> this driver will work in nowayout mode.
>=20
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  .../bindings/watchdog/alphascale-asm9260.txt       |  38 ++
>  drivers/watchdog/Kconfig                           |   9 +
>  drivers/watchdog/Makefile                          |   1 +
>  drivers/watchdog/asm9260_wdt.c                     | 405 +++++++++++++=
++++++++
>  4 files changed, 453 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/alphasca=
le-asm9260.txt
>  create mode 100644 drivers/watchdog/asm9260_wdt.c
>=20
> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm9=
260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.t=
xt
> new file mode 100644
> index 0000000..cbe388b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt=

> @@ -0,0 +1,38 @@
> +Alphascale asm9260 Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "alphascale,asm9260-wdt".
> +- reg : Specifies base physical address and size of the registers.
> +- clocks : the clock feeding the watchdog timer.
> +	Needed if platform uses clocks. See clock-bindings.txt
> +- clock-names : should be set to
> +	"mod" - source for tick counter.
> +	"ahb" - ahb gate.
> +
> +Optional properties:
> +- resets : phandle pointing to the system reset controller with correc=
t
> +	reset line index for watchdog controller reset. This propertie is
> +	required if you need to disable "nowayout" and it works only with
> +	CONFIG_WATCHDOG_NOWAYOUT=3Dn.
> +- reset-names : should be set to "wdt_rst" if "resets" is used.
> +- timeout-sec : shall contain the default watchdog timeout in seconds,=

> +	if unset, the default timeout is 30 seconds.
> +- alphascale,mode : tree modes are supported
> +	"hw" - hw reset (defaul).
> +	"sw" - sw reset.
> +	"debug" - no action is taken.
> +
> +Example:
> +
> +watchdog0: watchdog@80048000 {
> +	compatible =3D "alphascale,asm9260-wdt";
> +	reg =3D <0x80048000 0x10>;
> +	clocks =3D <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
> +	clock-names =3D "mod", "ahb";
> +	interrupts =3D <55>;
> +	resets =3D <&rst WDT_RESET>;
> +	reset-names =3D "wdt_rst";
> +	timeout-sec =3D <30>;
> +	alphascale,mode =3D "hw"
> +};
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c68edc1..cc5f675 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -173,6 +173,15 @@ config ARM_SP805_WATCHDOG
>  	  ARM Primecell SP805 Watchdog timer. This will reboot your system wh=
en
>  	  the timeout is reached.
> =20
> +config ASM9260_WATCHDOG
> +	tristate "Alphascale ASM9260 watchdog"
> +	depends on MACH_ASM9260
> +	depends on OF
> +	select WATCHDOG_CORE
> +	help
> +	  Watchdog timer embedded into Alphascale asm9260 chips. This will re=
boot your
> +	  system when the timeout is reached.
> +
>  config AT91RM9200_WATCHDOG
>  	tristate "AT91RM9200 watchdog"
>  	depends on SOC_AT91RM9200 && MFD_SYSCON
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 0c616e3..bd7b0cd 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_USBPCWATCHDOG) +=3D pcwd_usb.o
> =20
>  # ARM Architecture
>  obj-$(CONFIG_ARM_SP805_WATCHDOG) +=3D sp805_wdt.o
> +obj-$(CONFIG_ASM9260_WATCHDOG) +=3D asm9260_wdt.o
>  obj-$(CONFIG_AT91RM9200_WATCHDOG) +=3D at91rm9200_wdt.o
>  obj-$(CONFIG_AT91SAM9X_WATCHDOG) +=3D at91sam9_wdt.o
>  obj-$(CONFIG_CADENCE_WATCHDOG) +=3D cadence_wdt.o
> diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_=
wdt.c
> new file mode 100644
> index 0000000..e5f859b
> --- /dev/null
> +++ b/drivers/watchdog/asm9260_wdt.c
> @@ -0,0 +1,405 @@
> +/*
> + * Watchdog driver for Alphascale ASM9260.
> + *
> + * Copyright (c) 2014 Oleksij Rempel <linux@rempel-privat.de>
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/reboot.h>
> +#include <linux/reset.h>
> +#include <linux/uaccess.h>
> +#include <linux/watchdog.h>
> +
> +#define CLOCK_FREQ	1000000
> +
> +/* Watchdog Mode register */
> +#define HW_WDMOD			0x00
> +/* Wake interrupt. Set by HW, can't be cleared. */
> +#define BM_MOD_WDINT			BIT(3)
> +/* This bit set if timeout reached. Cleared by SW. */
> +#define BM_MOD_WDTOF			BIT(2)
> +/* HW Reset on timeout */
> +#define BM_MOD_WDRESET			BIT(1)
> +/* WD enable */
> +#define BM_MOD_WDEN			BIT(0)
> +
> +/*
> + * Watchdog Timer Constant register
> + * Minimal value is 0xff, the meaning of this value
> + * depends on used clock: T =3D WDCLK * (0xff + 1) * 4
> + */
> +#define HW_WDTC				0x04
> +#define BM_WDTC_MAX(freq)		(0x7fffffff / (freq))
> +
> +/* Watchdog Feed register */
> +#define HW_WDFEED			0x08
> +
> +/* Watchdog Timer Value register */
> +#define HW_WDTV				0x0c
> +
> +#define ASM9260_WDT_DEFAULT_TIMEOUT	30
> +
> +enum asm9260_wdt_mode {
> +	HW_RESET,
> +	SW_RESET,
> +	DEBUG,
> +};
> +
> +struct asm9260_wdt_priv {
> +	struct device		*dev;
> +	struct watchdog_device	wdd;
> +	struct clk		*clk;
> +	struct clk		*clk_ahb;
> +	struct reset_control	*rst;
> +	struct notifier_block	restart_handler;
> +
> +	void __iomem		*iobase;
> +	int			irq;
> +	unsigned long		wdt_freq;
> +	enum asm9260_wdt_mode	mode;
> +};
> +
> +static int asm9260_wdt_feed(struct watchdog_device *wdd)
> +{
> +	struct asm9260_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
> +
> +	iowrite32(0xaa, priv->iobase + HW_WDFEED);
> +	iowrite32(0x55, priv->iobase + HW_WDFEED);
> +
> +	return 0;
> +}
> +
> +static unsigned int asm9260_wdt_gettimeleft(struct watchdog_device *wd=
d)
> +{
> +	struct asm9260_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
> +	u32 counter;
> +
> +	counter =3D ioread32(priv->iobase + HW_WDTV);
> +
> +	return DIV_ROUND_CLOSEST(counter, priv->wdt_freq);
> +}
> +
> +static int asm9260_wdt_updatetimeout(struct watchdog_device *wdd)
> +{
> +	struct asm9260_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
> +	u32 counter;
> +
> +	counter =3D wdd->timeout * priv->wdt_freq;
> +
> +	iowrite32(counter, priv->iobase + HW_WDTC);
> +
> +	return 0;
> +}
> +
> +static int asm9260_wdt_enable(struct watchdog_device *wdd)
> +{
> +	struct asm9260_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
> +	u32 mode =3D 0;
> +
> +	if (priv->mode =3D=3D HW_RESET)
> +		mode =3D BM_MOD_WDRESET;
> +
> +	iowrite32(BM_MOD_WDEN | mode, priv->iobase + HW_WDMOD);
> +
> +	asm9260_wdt_updatetimeout(wdd);
> +
> +	asm9260_wdt_feed(wdd);
> +
> +	return 0;
> +}
> +
> +static int asm9260_wdt_disable(struct watchdog_device *wdd)
> +{
> +	struct asm9260_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
> +
> +	/* The only way to disable WD is to reset it. */
> +	reset_control_assert(priv->rst);
> +	reset_control_deassert(priv->rst);
> +
> +	return 0;
> +}
> +
> +static int asm9260_wdt_settimeout(struct watchdog_device *wdd, unsigne=
d int to)
> +{
> +	wdd->timeout =3D to;
> +	asm9260_wdt_updatetimeout(wdd);
> +
> +	return 0;
> +}
> +
> +static void asm9260_wdt_sys_reset(struct asm9260_wdt_priv *priv)
> +{
> +	/* init WD if it was not started */
> +	priv->wdd.timeout =3D 1;
> +
> +	iowrite32(BM_MOD_WDEN | BM_MOD_WDRESET, priv->iobase + HW_WDMOD);
> +
> +	asm9260_wdt_updatetimeout(&priv->wdd);
> +	/* first pass correct sequence */
> +	asm9260_wdt_feed(&priv->wdd);
> +	/*
> +	 * Then write wrong pattern to the feed to trigger reset
> +	 * ASAP.
> +	 */
> +	iowrite32(0xff, priv->iobase + HW_WDFEED);
> +
> +	mdelay(1000);
> +}
> +
> +static irqreturn_t asm9260_wdt_irq(int irq, void *devid)
> +{
> +	struct asm9260_wdt_priv *priv =3D devid;
> +	u32 stat;
> +
> +	stat =3D ioread32(priv->iobase + HW_WDMOD);
> +	if (!(stat & BM_MOD_WDINT))
> +		return IRQ_NONE;
> +
> +	/*
> +	 * BM_MOD_WDINT flag can't be removed by SW. Only way is
> +	 * to reset WD Controller.
> +	 * TODO: add Controller reset if needed.
> +	 */
> +	if (priv->mode =3D=3D DEBUG)
> +		dev_info(priv->dev, "Watchdog Timeout. Do nothing.\n");
> +	else {
> +		dev_info(priv->dev, "Watchdog Timeout. Doing SW Reset.\n");
> +		asm9260_wdt_sys_reset(priv);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int asm9260_restart_handler(struct notifier_block *this,
> +				unsigned long mode, void *cmd)
> +{
> +	struct asm9260_wdt_priv *priv =3D
> +		container_of(this, struct asm9260_wdt_priv, restart_handler);
> +
> +	asm9260_wdt_sys_reset(priv);
> +
> +	return NOTIFY_DONE;
> +}
> +
> +static const struct watchdog_info asm9260_wdt_ident =3D {
> +	.options          =3D     WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING
> +				| WDIOF_MAGICCLOSE,
> +	.firmware_version =3D	0,
> +	.identity         =3D	"Alphascale asm9260 Watchdog",
> +};
> +
> +static struct watchdog_ops asm9260_wdt_ops =3D {
> +	.owner		=3D THIS_MODULE,
> +	.start		=3D asm9260_wdt_enable,
> +	.stop		=3D asm9260_wdt_disable,
> +	.get_timeleft	=3D asm9260_wdt_gettimeleft,
> +	.ping		=3D asm9260_wdt_feed,
> +	.set_timeout	=3D asm9260_wdt_settimeout,
> +};
> +
> +static int __init asm9260_wdt_get_dt_clks(struct asm9260_wdt_priv *pri=
v)
> +{
> +	int clk_idx =3D 0, err;
> +
> +	priv->clk =3D devm_clk_get(priv->dev, "mod");
> +	if (IS_ERR(priv->clk))
> +		goto out_err;
> +
> +	/* configure AHB clock */
> +	clk_idx =3D 1;
> +	priv->clk_ahb =3D devm_clk_get(priv->dev, "ahb");
> +	if (IS_ERR(priv->clk_ahb))
> +		goto out_err;
> +
> +	err =3D clk_prepare_enable(priv->clk_ahb);
> +	if (err)
> +		dev_err(priv->dev, "Failed to enable ahb_clk!\n");
> +
> +	err =3D clk_set_rate(priv->clk, CLOCK_FREQ);
> +	if (err) {
> +		clk_disable_unprepare(priv->clk_ahb);
> +		dev_err(priv->dev, "Failed to set rate!\n");
> +	}
> +
> +	err =3D clk_prepare_enable(priv->clk);
> +	if (err) {
> +		clk_disable_unprepare(priv->clk_ahb);
> +		dev_err(priv->dev, "Failed to enable clk!\n");
> +	}
> +
> +	/* wdt has internal divider */
> +	priv->wdt_freq =3D clk_get_rate(priv->clk) / 2;
> +
> +	return 0;
> +out_err:
> +	dev_err(priv->dev, "%s: Failed to get clk (%i)\n", __func__, clk_idx)=
;
> +	return 1;
> +}
> +
> +static void __init asm9260_wdt_get_dt_mode(struct asm9260_wdt_priv *pr=
iv)
> +{
> +	const char *tmp;
> +	int ret;
> +
> +	/* default mode */
> +	priv->mode =3D HW_RESET;
> +
> +	ret =3D of_property_read_string(priv->dev->of_node,
> +			"alphascale,mode", &tmp);
> +	if (ret)
> +		return;
> +
> +	if (!strcmp(tmp, "hw"))
> +		priv->mode =3D HW_RESET;
> +	else if (!strcmp(tmp, "sw"))
> +		priv->mode =3D SW_RESET;
> +	else if (!strcmp(tmp, "debug"))
> +		priv->mode =3D DEBUG;
> +	else {
> +		dev_warn(priv->dev, "unknown reset-type: %s. Using defaul \"hw\" mod=
e.",
> +			tmp);
> +		return;
> +	}
> +
> +	dev_info(priv->dev, "using \"%s\" mode.", tmp);
> +}
> +
> +static int __init asm9260_wdt_probe(struct platform_device *pdev)
> +{
> +	struct asm9260_wdt_priv *priv;
> +	struct watchdog_device *wdd;
> +	struct resource *res;
> +	bool nowayout =3D WATCHDOG_NOWAYOUT;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(struct asm9260_wdt_priv),
> +			GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev =3D &pdev->dev;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	priv->iobase =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->iobase))
> +		return PTR_ERR(priv->iobase);
> +
> +	ret =3D asm9260_wdt_get_dt_clks(priv);
> +	if (ret)
> +		return ret;
> +
> +	priv->rst =3D devm_reset_control_get(&pdev->dev, "wdt_rst");
> +	if (IS_ERR(priv->rst)) {
> +		dev_info(&pdev->dev, "No reset control found. Enabling \"nowayout\" =
mode\n");
> +		nowayout =3D 1;
> +		priv->rst =3D NULL;
> +	}
> +
> +	wdd =3D &priv->wdd;
> +	wdd->info =3D &asm9260_wdt_ident;
> +	wdd->ops =3D &asm9260_wdt_ops;
> +	wdd->min_timeout =3D 1;
> +	wdd->max_timeout =3D BM_WDTC_MAX(priv->wdt_freq);
> +	wdd->parent =3D &pdev->dev;
> +
> +	watchdog_set_drvdata(wdd, priv);
> +
> +	/*
> +	 * If 'timeout-sec' unspecified in devicetree, assume a 30 second
> +	 * default, unless the max timeout is less than 30 seconds, then use
> +	 * the max instead.
> +	 */
> +	wdd->timeout =3D ASM9260_WDT_DEFAULT_TIMEOUT;
> +	watchdog_init_timeout(wdd, 0, &pdev->dev);
> +
> +	watchdog_set_nowayout(wdd, nowayout);
> +
> +	asm9260_wdt_get_dt_mode(priv);
> +
> +	if (priv->mode !=3D HW_RESET)
> +		priv->irq =3D platform_get_irq(pdev, 0);
> +
> +	if (priv->irq > 0) {
> +		/*
> +		 * Not all supported platforms specify an interrupt for the
> +		 * watchdog, so let's make it optional.
> +		 */
> +		ret =3D devm_request_irq(&pdev->dev, priv->irq,
> +				asm9260_wdt_irq, IRQF_SHARED,
> +				pdev->name, priv);
> +		if (ret < 0)
> +			dev_err(&pdev->dev, "failed to request IRQ\n");
> +	}
> +
> +	ret =3D watchdog_register_device(wdd);
> +	if (ret)
> +		goto clk_off;
> +
> +	platform_set_drvdata(pdev, priv);
> +
> +	priv->restart_handler.notifier_call =3D asm9260_restart_handler;
> +	priv->restart_handler.priority =3D 128;
> +	ret =3D register_restart_handler(&priv->restart_handler);
> +	if (ret)
> +		dev_err(&pdev->dev, "cannot register restart handler\n");
> +
> +	dev_info(&pdev->dev, "Watchdog enabled (timeout=3D%d sec, nowayout=3D=
%d)",
> +		wdd->timeout, nowayout);
> +	return 0;
> +
> +clk_off:
> +	clk_disable_unprepare(priv->clk);
> +	clk_disable_unprepare(priv->clk_ahb);
> +	return ret;
> +}
> +
> +static void asm9260_wdt_shutdown(struct platform_device *pdev)
> +{
> +	struct asm9260_wdt_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	asm9260_wdt_disable(&priv->wdd);
> +}
> +
> +static int __exit asm9260_wdt_remove(struct platform_device *pdev)
> +{
> +	struct asm9260_wdt_priv *priv =3D platform_get_drvdata(pdev);
> +
> +	asm9260_wdt_shutdown(pdev);
> +
> +	unregister_restart_handler(&priv->restart_handler);
> +	clk_disable_unprepare(priv->clk);
> +	clk_disable_unprepare(priv->clk_ahb);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id asm9260_wdt_of_match[] =3D {
> +	{ .compatible =3D "alphascale,asm9260-wdt"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, asm9260_wdt_of_match);
> +
> +static struct platform_driver asm9260_wdt_driver =3D {
> +	.driver =3D {
> +		.name =3D "asm9260-wdt",
> +		.owner =3D THIS_MODULE,
> +		.of_match_table	=3D asm9260_wdt_of_match,
> +	},
> +	.probe =3D asm9260_wdt_probe,
> +	.remove =3D asm9260_wdt_remove,
> +	.shutdown =3D asm9260_wdt_shutdown,
> +};
> +module_platform_driver(asm9260_wdt_driver);
> +
> +MODULE_DESCRIPTION("asm9260 WatchDog Timer Driver");
> +MODULE_AUTHOR("Oleksij Rempel <linux@rempel-privat.de>");
> +MODULE_LICENSE("GPL");
>=20


--=20
Regards,
Oleksij


--1POrRkre16bd8U2ncjm4mwiedVjJ9J34G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iF4EAREIAAYFAlYl8fYACgkQHwImuRkmbWmnYgD/TFuSSgDP6vxtRw5LTG9F7lHO
pm/XkJpYuEW6WMJQw8AA/0iijzuFCh04fDlQTYaucqtNqRBJA1Qsf99PPA4ac+vG
=N7yv
-----END PGP SIGNATURE-----

--1POrRkre16bd8U2ncjm4mwiedVjJ9J34G--
