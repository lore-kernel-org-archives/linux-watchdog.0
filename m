Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49358 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754016AbcLZQkA (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 26 Dec 2016 11:40:00 -0500
Subject: Re: [PATCH] drivers: watchdog: constify watchdog_info structures
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
        wim@iguana.be, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        support.opensource@diasemi.com, baruch@tkos.co.il,
        manabian@gmail.com, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1482760069-8959-1-git-send-email-bhumirks@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3c2d3788-cc70-c3fb-1194-cbf3b594a546@roeck-us.net>
Date: Mon, 26 Dec 2016 08:39:53 -0800
MIME-Version: 1.0
In-Reply-To: <1482760069-8959-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/26/2016 05:47 AM, Bhumika Goyal wrote:
> Declare watchdog_info structures as const as they are only stored in the
> info field of watchdog_device structures. This field is of type const
> struct watchdog_info *, so watchdog_info structures having this property
> can be declared const too.
> Done using Coccinelle:
>
> @r1 disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct watchdog_info i@p={...};
>
> @ok@
> identifier r1.i;
> position p;
> struct watchdog_device obj;
> @@
> obj.info=&i@p;
>
> @bad@
> position p!={r1.p,ok.p};
> identifier r1.i;
> @@
> i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r1.i;
> @@
> +const
> struct watchdog_info i;
>
> Size details:
>
>    text	   data	    bss	    dec	    hex	filename
>
>    1882	    249	      0	   2131	    853	drivers/watchdog/bcm7038_wdt.o
>    1938	    193	      0	   2131	    853	drivers/watchdog/bcm7038_wdt.o
>
>    1673	    720	      8	   2401	    961	drivers/watchdog/bcm_kona_wdt.o
>    1729	    656	      8	   2393	    959	drivers/watchdog/bcm_kona_wdt.o
>
>    2370	    760	      8	   3138	    c42	drivers/watchdog/cadence_wdt.o
>    2434	    704	      8	   3146	    c4a	drivers/watchdog/cadence_wdt.o
>
>    1448	    248	      0	   1696	    6a0	drivers/watchdog/da9052_wdt.o
>    1512	    192	      0	   1704	    6a8	drivers/watchdog/da9052_wdt.o
>
>    1077	    249	      0	   1326	    52e	drivers/watchdog/da9055_wdt.o
>    1141	    193	      0	   1334	    536	drivers/watchdog/da9055_wdt.o
>
>    1416	    544	     12	   1972	    7b4	drivers/watchdog/digicolor_wdt.o
>    1480	    480	     12	   1972	    7b4	drivers/watchdog/digicolor_wdt.o
>
>    2653	    249	      4	   2906	    b5a	drivers/watchdog/imgpdc_wdt.o
>    2717	    193	      4	   2914	    b62	drivers/watchdog/imgpdc_wdt.o
>
>    2923	    257	      4	   3184	    c70	drivers/watchdog/kempld_wdt.o
>    2987	    201	      4	   3192	    c78	drivers/watchdog/kempld_wdt.o
>
>    2469	    249	     20	   2738	    ab2	drivers/watchdog/lpc18xx_wdt.o
>    2533	    193	     20	   2746	    aba	drivers/watchdog/lpc18xx_wdt.o
>
>    1119	    249	      4	   1372	    55c	drivers/watchdog/rn5t618_wdt.o
>    1183	    193	      4	   1380	    564	drivers/watchdog/rn5t618_wdt.o
>
>    1218	    528	      8	   1754	    6da	drivers/watchdog/softdog.o
>    1282	    464	      8	   1754	    6da	drivers/watchdog/softdog.o
>
>    2934	    249	     24	   3207	    c87	drivers/watchdog/w83627hf_wdt.o
>    2998	    185	     24	   3207	    c87	drivers/watchdog/w83627hf_wdt.o
>

The size details are quite irrelevant for the commit log. Also, please drop "drivers:"
from the subject line.

Guenter

> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/watchdog/bcm7038_wdt.c   | 2 +-
>  drivers/watchdog/bcm_kona_wdt.c  | 2 +-
>  drivers/watchdog/cadence_wdt.c   | 2 +-
>  drivers/watchdog/da9052_wdt.c    | 2 +-
>  drivers/watchdog/da9055_wdt.c    | 2 +-
>  drivers/watchdog/digicolor_wdt.c | 2 +-
>  drivers/watchdog/imgpdc_wdt.c    | 2 +-
>  drivers/watchdog/kempld_wdt.c    | 2 +-
>  drivers/watchdog/lpc18xx_wdt.c   | 2 +-
>  drivers/watchdog/rn5t618_wdt.c   | 2 +-
>  drivers/watchdog/sbsa_gwdt.c     | 2 +-
>  drivers/watchdog/w83627hf_wdt.c  | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
> index e238df4..37c6a49 100644
> --- a/drivers/watchdog/bcm7038_wdt.c
> +++ b/drivers/watchdog/bcm7038_wdt.c
> @@ -101,7 +101,7 @@ static unsigned int bcm7038_wdt_get_timeleft(struct watchdog_device *wdog)
>  	return time_left / wdt->rate;
>  }
>
> -static struct watchdog_info bcm7038_wdt_info = {
> +static const struct watchdog_info bcm7038_wdt_info = {
>  	.identity	= "Broadcom BCM7038 Watchdog Timer",
>  	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>  				WDIOF_MAGICCLOSE
> diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
> index e0c9842..76b0080 100644
> --- a/drivers/watchdog/bcm_kona_wdt.c
> +++ b/drivers/watchdog/bcm_kona_wdt.c
> @@ -274,7 +274,7 @@ static int bcm_kona_wdt_stop(struct watchdog_device *wdog)
>  	.get_timeleft =	bcm_kona_wdt_get_timeleft,
>  };
>
> -static struct watchdog_info bcm_kona_wdt_info = {
> +static const struct watchdog_info bcm_kona_wdt_info = {
>  	.options =	WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
>  			WDIOF_KEEPALIVEPING,
>  	.identity =	"Broadcom Kona Watchdog Timer",
> diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
> index 98acef7..8d61e8b 100644
> --- a/drivers/watchdog/cadence_wdt.c
> +++ b/drivers/watchdog/cadence_wdt.c
> @@ -262,7 +262,7 @@ static irqreturn_t cdns_wdt_irq_handler(int irq, void *dev_id)
>   * Info structure used to indicate the features supported by the device
>   * to the upper layers. This is defined in watchdog.h header file.
>   */
> -static struct watchdog_info cdns_wdt_info = {
> +static const struct watchdog_info cdns_wdt_info = {
>  	.identity	= "cdns_wdt watchdog",
>  	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>  			  WDIOF_MAGICCLOSE,
> diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
> index 2fc19a3..d86a57e 100644
> --- a/drivers/watchdog/da9052_wdt.c
> +++ b/drivers/watchdog/da9052_wdt.c
> @@ -140,7 +140,7 @@ static int da9052_wdt_ping(struct watchdog_device *wdt_dev)
>  	return ret;
>  }
>
> -static struct watchdog_info da9052_wdt_info = {
> +static const struct watchdog_info da9052_wdt_info = {
>  	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity	= "DA9052 Watchdog",
>  };
> diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
> index 8377c43..4f30818 100644
> --- a/drivers/watchdog/da9055_wdt.c
> +++ b/drivers/watchdog/da9055_wdt.c
> @@ -108,7 +108,7 @@ static int da9055_wdt_stop(struct watchdog_device *wdt_dev)
>  	return da9055_wdt_set_timeout(wdt_dev, 0);
>  }
>
> -static struct watchdog_info da9055_wdt_info = {
> +static const struct watchdog_info da9055_wdt_info = {
>  	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity	= "DA9055 Watchdog",
>  };
> diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
> index 77df772..dfe7294 100644
> --- a/drivers/watchdog/digicolor_wdt.c
> +++ b/drivers/watchdog/digicolor_wdt.c
> @@ -105,7 +105,7 @@ static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
>  	.restart        = dc_wdt_restart,
>  };
>
> -static struct watchdog_info dc_wdt_info = {
> +static const struct watchdog_info dc_wdt_info = {
>  	.options	= WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE
>  			| WDIOF_KEEPALIVEPING,
>  	.identity	= "Conexant Digicolor Watchdog",
> diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
> index 516fbef..6ed39de 100644
> --- a/drivers/watchdog/imgpdc_wdt.c
> +++ b/drivers/watchdog/imgpdc_wdt.c
> @@ -161,7 +161,7 @@ static int pdc_wdt_restart(struct watchdog_device *wdt_dev,
>  	return 0;
>  }
>
> -static struct watchdog_info pdc_wdt_info = {
> +static const struct watchdog_info pdc_wdt_info = {
>  	.identity	= "IMG PDC Watchdog",
>  	.options	= WDIOF_SETTIMEOUT |
>  			  WDIOF_KEEPALIVEPING |
> diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
> index 8e302d0..73c46b3 100644
> --- a/drivers/watchdog/kempld_wdt.c
> +++ b/drivers/watchdog/kempld_wdt.c
> @@ -422,7 +422,7 @@ static int kempld_wdt_probe_stages(struct watchdog_device *wdd)
>  	return 0;
>  }
>
> -static struct watchdog_info kempld_wdt_info = {
> +static const struct watchdog_info kempld_wdt_info = {
>  	.identity	= "KEMPLD Watchdog",
>  	.options	= WDIOF_SETTIMEOUT |
>  			WDIOF_KEEPALIVEPING |
> diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
> index fd171e6..3b8bb59 100644
> --- a/drivers/watchdog/lpc18xx_wdt.c
> +++ b/drivers/watchdog/lpc18xx_wdt.c
> @@ -181,7 +181,7 @@ static int lpc18xx_wdt_restart(struct watchdog_device *wdt_dev,
>  	return 0;
>  }
>
> -static struct watchdog_info lpc18xx_wdt_info = {
> +static const struct watchdog_info lpc18xx_wdt_info = {
>  	.identity	= "NXP LPC18xx Watchdog",
>  	.options	= WDIOF_SETTIMEOUT |
>  			  WDIOF_KEEPALIVEPING |
> diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
> index 0805ee2..e60f557 100644
> --- a/drivers/watchdog/rn5t618_wdt.c
> +++ b/drivers/watchdog/rn5t618_wdt.c
> @@ -130,7 +130,7 @@ static int rn5t618_wdt_ping(struct watchdog_device *wdt_dev)
>  				  RN5T618_PWRIRQ_IR_WDOG, 0);
>  }
>
> -static struct watchdog_info rn5t618_wdt_info = {
> +static const struct watchdog_info rn5t618_wdt_info = {
>  	.options	= WDIOF_SETTIMEOUT | WDIOF_MAGICCLOSE |
>  			  WDIOF_KEEPALIVEPING,
>  	.identity	= DRIVER_NAME,
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index ce0c38b..e9966bc 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -207,7 +207,7 @@ static irqreturn_t sbsa_gwdt_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>
> -static struct watchdog_info sbsa_gwdt_info = {
> +static const struct watchdog_info sbsa_gwdt_info = {
>  	.identity	= WATCHDOG_NAME,
>  	.options	= WDIOF_SETTIMEOUT |
>  			  WDIOF_KEEPALIVEPING |
> diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
> index ef2ecaf..98fd186 100644
> --- a/drivers/watchdog/w83627hf_wdt.c
> +++ b/drivers/watchdog/w83627hf_wdt.c
> @@ -297,7 +297,7 @@ static unsigned int wdt_get_time(struct watchdog_device *wdog)
>   *	Kernel Interfaces
>   */
>
> -static struct watchdog_info wdt_info = {
> +static const struct watchdog_info wdt_info = {
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
>  	.identity = "W83627HF Watchdog",
>  };
>

