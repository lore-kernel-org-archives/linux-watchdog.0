Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:59435 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753305AbbAEO2x (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 5 Jan 2015 09:28:53 -0500
Message-ID: <54AA9FB1.1090603@atmel.com>
Date: Mon, 5 Jan 2015 15:29:05 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Boris Brezillon <boris.brezillon@free-electrons.com>,
	"Jean-Christophe Plagniol-Villard" <plagnioj@jcrosoft.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Samuel Ortiz" <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	"Wim Van Sebroeck" <wim@iguana.be>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH 3/8] watchdog: at91rm9200: use the regmap from mfd
References: <1420459605-24561-1-git-send-email-alexandre.belloni@free-electrons.com> <1420459605-24561-4-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1420459605-24561-4-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Le 05/01/2015 13:06, Alexandre Belloni a =E9crit :
> The system timer MFD driver is providing a regmap. Use it to access t=
he
> registers.
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.co=
m>
> ---
>  drivers/watchdog/Kconfig          |  2 +-
>  drivers/watchdog/at91rm9200_wdt.c | 22 +++++++++-------------
>  2 files changed, 10 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 08f41add1461..18c73bc159fc 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -154,7 +154,7 @@ config ARM_SP805_WATCHDOG
> =20
>  config AT91RM9200_WATCHDOG
>  	tristate "AT91RM9200 watchdog"
> -	depends on SOC_AT91RM9200
> +	depends on SOC_AT91RM9200 && MFD_ATMEL_ST
>  	help
>  	  Watchdog timer embedded into AT91RM9200 chips. This will reboot y=
our
>  	  system when the timeout is reached.
> diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at9=
1rm9200_wdt.c
> index d244112d5b6f..6d6f36652112 100644
> --- a/drivers/watchdog/at91rm9200_wdt.c
> +++ b/drivers/watchdog/at91rm9200_wdt.c
> @@ -17,22 +17,24 @@
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/mfd/atmel-st.h>
>  #include <linux/miscdevice.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/types.h>
>  #include <linux/watchdog.h>
>  #include <linux/uaccess.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> -#include <mach/at91_st.h>
> =20
>  #define WDT_DEFAULT_TIME	5	/* seconds */
>  #define WDT_MAX_TIME		256	/* seconds */
> =20
>  static int wdt_time =3D WDT_DEFAULT_TIME;
>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> +static struct regmap *regmap_st;
> =20
>  module_param(wdt_time, int, 0);
>  MODULE_PARM_DESC(wdt_time, "Watchdog time in seconds. (default=3D"
> @@ -55,7 +57,7 @@ static unsigned long at91wdt_busy;
>   */
>  static inline void at91_wdt_stop(void)
>  {
> -	at91_st_write(AT91_ST_WDMR, AT91_ST_EXTEN);
> +	regmap_write(regmap_st, AT91_ST_WDMR, AT91_ST_EXTEN);
>  }
> =20
>  /*
> @@ -63,9 +65,9 @@ static inline void at91_wdt_stop(void)
>   */
>  static inline void at91_wdt_start(void)
>  {
> -	at91_st_write(AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN |
> +	regmap_write(regmap_st, AT91_ST_WDMR, AT91_ST_EXTEN | AT91_ST_RSTEN=
 |
>  				(((65536 * wdt_time) >> 8) & AT91_ST_WDV));
> -	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
> +	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
>  }
> =20
>  /*
> @@ -73,7 +75,7 @@ static inline void at91_wdt_start(void)
>   */
>  static inline void at91_wdt_reload(void)
>  {
> -	at91_st_write(AT91_ST_CR, AT91_ST_WDRST);
> +	regmap_write(regmap_st, AT91_ST_CR, AT91_ST_WDRST);
>  }
> =20
>  /* .................................................................=
=2E....... */
> @@ -204,6 +206,7 @@ static struct miscdevice at91wdt_miscdev =3D {
>  static int at91wdt_probe(struct platform_device *pdev)
>  {
>  	int res;
> +	regmap_st =3D dev_get_drvdata(pdev->dev.parent);
> =20
>  	if (at91wdt_miscdev.parent)
>  		return -EBUSY;
> @@ -254,12 +257,6 @@ static int at91wdt_resume(struct platform_device=
 *pdev)
>  #define at91wdt_resume	NULL
>  #endif
> =20
> -static const struct of_device_id at91_wdt_dt_ids[] =3D {
> -	{ .compatible =3D "atmel,at91rm9200-wdt" },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, at91_wdt_dt_ids);
> -
>  static struct platform_driver at91wdt_driver =3D {
>  	.probe		=3D at91wdt_probe,
>  	.remove		=3D at91wdt_remove,
> @@ -267,8 +264,7 @@ static struct platform_driver at91wdt_driver =3D =
{
>  	.suspend	=3D at91wdt_suspend,
>  	.resume		=3D at91wdt_resume,
>  	.driver		=3D {
> -		.name	=3D "at91_wdt",
> -		.of_match_table =3D at91_wdt_dt_ids,

As we remove all the DT specific bits in this driver, don't we have the
opportunity to remove some #include directives?

> +		.name	=3D "atmel_st_watchdog",
>  	},
>  };
> =20
>=20


--=20
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
