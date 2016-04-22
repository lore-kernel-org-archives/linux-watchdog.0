Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39290 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031AbcDVNvQ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Apr 2016 09:51:16 -0400
Subject: Re: [PATCH v2] watchdog: f71808e_wdt: Add F81865 support
To: Knud Poulsen <knpo@ieee.org>
References: <571A0F95.6000509@ieee.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Linux Watchdog <linux-watchdog@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <571A2C4F.8020304@roeck-us.net>
Date: Fri, 22 Apr 2016 06:51:11 -0700
MIME-Version: 1.0
In-Reply-To: <571A0F95.6000509@ieee.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 04/22/2016 04:48 AM, Knud Poulsen wrote:
> Adds watchdog support for Fintek F81865 Super-IO chip to
> Fintek wdt driver (f71808e_wdt)
>
> Tested and verified on Lanner LEC-3030 Industrial PC
>
> Datasheet references:
> http://www.hardwaresecrets.com/datasheets/F81865_V028P.pdf
> http://www.alldatasheet.com/datasheet-pdf/pdf/406317/FINTEK/F81865.html
>
> Signed-off-by: Knud Poulsen <knpo@ieee.org>
> ---
>   drivers/watchdog/f71808e_wdt.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 016bd93..4133cd3 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -59,6 +59,7 @@
>   #define SIO_F71869A_ID		0x1007	/* Chipset ID */
>   #define SIO_F71882_ID		0x0541	/* Chipset ID */
>   #define SIO_F71889_ID		0x0723	/* Chipset ID */
> +#define SIO_F81865_ID		0x0704	/* Chipset ID */
>
>   #define F71808FG_REG_WDO_CONF		0xf0
>   #define F71808FG_REG_WDT_CONF		0xf5
> @@ -71,6 +72,10 @@
>   #define F71808FG_FLAG_WD_PULSE		4
>   #define F71808FG_FLAG_WD_UNIT		3
>
> +#define F81865_REG_WDO_CONF		0xfa
> +#define F81865_FLAG_WDOUT_EN		0
> +#define F81865_FLAG_WDTMOUT_STS		6
> +
>   /* Default values */
>   #define WATCHDOG_TIMEOUT	60	/* 1 minute default timeout */
>   #define WATCHDOG_MAX_TIMEOUT	(60 * 255)
> @@ -112,7 +117,7 @@ module_param(start_withtimeout, uint, 0);
>   MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
>   	" given initial timeout. Zero (default) disables this feature.");
>
> -enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg };
> +enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865 };
>
>   static const char *f71808e_names[] = {
>   	"f71808fg",
> @@ -121,6 +126,7 @@ static const char *f71808e_names[] = {
>   	"f71869",
>   	"f71882fg",
>   	"f71889fg",
> +	"f81865",
>   };
>
>   /* Super-I/O Function prototypes */
> @@ -360,6 +366,11 @@ static int watchdog_start(void)
>   			superio_inb(watchdog.sioaddr, SIO_REG_MFUNCT3) & 0xcf);
>   		break;
>
> +	case f81865:
> +		/* Set pin 70 to WDTRST# */
> +		superio_clear_bit(watchdog.sioaddr, SIO_REG_MFUNCT3, 5);
> +		break;
> +
>   	default:
>   		/*
>   		 * 'default' label to shut up the compiler and catch
> @@ -371,8 +382,13 @@ static int watchdog_start(void)
>
>   	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
>   	superio_set_bit(watchdog.sioaddr, SIO_REG_ENABLE, 0);
> -	superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDO_CONF,
> -			F71808FG_FLAG_WDOUT_EN);
> +
> +	if (watchdog.type == f81865)
> +		superio_set_bit(watchdog.sioaddr, F81865_REG_WDO_CONF,
> +				F81865_FLAG_WDOUT_EN);
> +	else
> +		superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDO_CONF,
> +				F71808FG_FLAG_WDOUT_EN);
>
>   	superio_set_bit(watchdog.sioaddr, F71808FG_REG_WDT_CONF,
>   			F71808FG_FLAG_WD_EN);
> @@ -655,7 +671,11 @@ static int __init watchdog_init(int sioaddr)
>   	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
>
>   	wdt_conf = superio_inb(sioaddr, F71808FG_REG_WDT_CONF);
> -	watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
> +
> +	if (watchdog.type == f81865)
> +		watchdog.caused_reboot = wdt_conf & F81865_FLAG_WDTMOUT_STS;
> +	else
> +		watchdog.caused_reboot = wdt_conf & F71808FG_FLAG_WDTMOUT_STS;
>
Are you sure this one is correct ? The bit configuration is exactly the same
as with other chips supported by this driver. Actually, I don't see an indication
in any of the datasheets I have which would suggest that reading bit 5 means
that the last reboot occurred due to a watchdog timeout. As far as I can see,
it just means that the watchdog is enabled.

Am I missing something here ?

Thanks,
Guenter

>   	superio_exit(sioaddr);
>
> @@ -770,6 +790,9 @@ static int __init f71808e_find(int sioaddr)
>   		/* Confirmed (by datasheet) not to have a watchdog. */
>   		err = -ENODEV;
>   		goto exit;
> +	case SIO_F81865_ID:
> +		watchdog.type = f81865;
> +		break;
>   	default:
>   		pr_info("Unrecognized Fintek device: %04x\n",
>   			(unsigned int)devid);
>

