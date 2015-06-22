Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59465 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbbFVQxa (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jun 2015 12:53:30 -0400
Date: Mon, 22 Jun 2015 09:53:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: Re: [v2,2/3] watchdog: max63xx: add GPIO support
Message-ID: <20150622165327.GA1189@roeck-us.net>
References: <1434581940-15086-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434581940-15086-2-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Vivien,

On Wed, Jun 17, 2015 at 06:58:59PM -0400, Vivien Didelot wrote:
> Introduce a new struct max63xx_platform_data to support MAX63xx watchdog
> chips connected via GPIO. A platform code can fill this structure with
> GPIO numbers for WDI and WDSET pins to enable GPIO support in the code.
> 
> The driver takes care of requesting and releasing the GPIOs.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

would it be possible to use gpiod functions ?

> ---
>  drivers/watchdog/Kconfig                  |  2 +-
>  drivers/watchdog/max63xx_wdt.c            | 53 ++++++++++++++++++++++++++++++-
>  include/linux/platform_data/max63xx_wdt.h | 27 ++++++++++++++++
>  3 files changed, 80 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/platform_data/max63xx_wdt.h
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 742fbbc..bb65b20 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -418,7 +418,7 @@ config TS72XX_WATCHDOG
>  
>  config MAX63XX_WATCHDOG
>  	tristate "Max63xx watchdog"
> -	depends on HAS_IOMEM
> +	depends on HAS_IOMEM || GPIOLIB
>  	select WATCHDOG_CORE
>  	help
>  	  Support for memory mapped max63{69,70,71,72,73,74} watchdog timer.
> diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
> index 3f7e8d5..cce2b12 100644
> --- a/drivers/watchdog/max63xx_wdt.c
> +++ b/drivers/watchdog/max63xx_wdt.c
> @@ -22,6 +22,8 @@
>  #include <linux/watchdog.h>
>  #include <linux/bitops.h>
>  #include <linux/platform_device.h>
> +#include <linux/platform_data/max63xx_wdt.h>
> +#include <linux/gpio.h>
>  #include <linux/spinlock.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> @@ -47,6 +49,9 @@ struct max63xx_wdt {
>  	struct watchdog_device wdd;
>  	const struct max63xx_timeout *timeout;
>  
> +	/* platform settings e.g. GPIO */
> +	struct max63xx_platform_data *pdata;
> +
>  	/* memory mapping */
>  	void __iomem *base;
>  	spinlock_t lock;
> @@ -199,6 +204,48 @@ static int max63xx_mmap_init(struct platform_device *p, struct max63xx_wdt *wdt)
>  	return 0;
>  }
>  
> +static void max63xx_gpio_ping(struct max63xx_wdt *wdt)
> +{
> +	gpio_set_value_cansleep(wdt->pdata->wdi, 1);
> +	gpio_set_value_cansleep(wdt->pdata->wdi, 0);
> +}
> +
> +static void max63xx_gpio_set(struct max63xx_wdt *wdt, u8 set)
> +{
> +	gpio_set_value_cansleep(wdt->pdata->set0, set & BIT(0));
> +	gpio_set_value_cansleep(wdt->pdata->set1, set & BIT(1));
> +	gpio_set_value_cansleep(wdt->pdata->set2, set & BIT(2));
> +}
> +
> +static int max63xx_gpio_init(struct platform_device *p, struct max63xx_wdt *wdt)
> +{
> +	int err;
> +
> +	err = devm_gpio_request_one(&p->dev, wdt->pdata->wdi,
> +				    GPIOF_OUT_INIT_LOW, "max63xx_wdt WDI");
> +	if (err)
> +		return err;
> +
> +	err = devm_gpio_request_one(&p->dev, wdt->pdata->set0,
> +				    GPIOF_OUT_INIT_LOW, "max63xx_wdt SET0");
> +	if (err)
> +		return err;
> +
> +	err = devm_gpio_request_one(&p->dev, wdt->pdata->set1,
> +				    GPIOF_OUT_INIT_LOW, "max63xx_wdt SET1");
> +	if (err)
> +		return err;
> +
> +	err = devm_gpio_request_one(&p->dev, wdt->pdata->set2,
> +				    GPIOF_OUT_INIT_LOW, "max63xx_wdt SET2");
> +	if (err)
> +		return err;
> +
> +	wdt->ping = max63xx_gpio_ping;
> +	wdt->set = max63xx_gpio_set;
> +	return 0;
> +}
> +
>  static int max63xx_wdt_probe(struct platform_device *pdev)
>  {
>  	struct max63xx_wdt *wdt;
> @@ -211,6 +258,8 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
>  
>  	table = (struct max63xx_timeout *)pdev->id_entry->driver_data;
>  
> +	wdt->pdata = dev_get_platdata(&pdev->dev);
> +
>  	if (heartbeat < 1 || heartbeat > MAX_HEARTBEAT)
>  		heartbeat = DEFAULT_HEARTBEAT;
>  
> @@ -221,7 +270,9 @@ static int max63xx_wdt_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	err = max63xx_mmap_init(pdev, wdt);
> +	/* GPIO or memory mapped? */
> +	err = wdt->pdata && wdt->pdata->wdi ? max63xx_gpio_init(pdev, wdt) :
> +		max63xx_mmap_init(pdev, wdt);

I would prefer something like

	if (wdt->pdata && wdt->pdata->wdi)
		err = max63xx_gpio_init(pdev, wdt);
	else
		err = max63xx_mmap_init(pdev, wdt);

because it is much easier to read.

Also, you might want to use gpio_is_valid(). pin number 0 is a valid pin
for at least some architectures.

Thanks,
Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
