Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44636 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbcFGOHI (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 7 Jun 2016 10:07:08 -0400
Subject: Re: [PATCH] watchdog: f71808e_wdt: Add F81866 support
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>, wim@iguana.be
References: <1465196330-9410-1-git-send-email-hpeter+linux_kernel@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	peter_hong@fintek.com.tw, tom_tsai@fintek.com.tw,
	"Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <5756D4FD.4090109@roeck-us.net>
Date: Tue, 7 Jun 2016 07:06:53 -0700
MIME-Version: 1.0
In-Reply-To: <1465196330-9410-1-git-send-email-hpeter+linux_kernel@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/05/2016 11:58 PM, Ji-Ze Hong (Peter Hong) wrote:
> Adds watchdog enable support for Fintek F81866 Super-IO chip to
> Fintek wdt driver (f71808e_wdt)
>
> Tested and verified on iBASE MI802 Industrial PC
>
> Datasheet references:
> http://www.alldatasheet.com/datasheet-pdf/pdf/459085/FINTEK/F81866AD-I.html
>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>   drivers/watchdog/f71808e_wdt.c | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index d4ba262..bb905da 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -51,6 +51,17 @@
>   #define SIO_REG_ENABLE		0x30	/* Logical device enable */
>   #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
>
> +#define SIO_REG_PORT_SEL	0x27	/* F81866 Multi-Function Register */
> +#define SIO_REG_GPIO1		0x2c	/*
> +					 * GPIO1 Control Register when 27h
> +					 * BIT3:2 = 01 & BIT0 = 0
> +					 *
> +					 * The PIN 70(GPIO15/WDTRST) is
> +					 * controlled by 2Ch:
> +					 * BIT5: 0 -> WDTRST#
> +					 *       1 -> GPIO15
> +					 */
> +
Please keep register defines in order, and move the explanation
to where the register values are set.

>   #define SIO_FINTEK_ID		0x1934	/* Manufacturers ID */
>   #define SIO_F71808_ID		0x0901	/* Chipset ID */
>   #define SIO_F71858_ID		0x0507	/* Chipset ID */
> @@ -60,6 +71,7 @@
>   #define SIO_F71882_ID		0x0541	/* Chipset ID */
>   #define SIO_F71889_ID		0x0723	/* Chipset ID */
>   #define SIO_F81865_ID		0x0704	/* Chipset ID */
> +#define SIO_F81866_ID		0x1010	/* Chipset ID */
>
>   #define F71808FG_REG_WDO_CONF		0xf0
>   #define F71808FG_REG_WDT_CONF		0xf5
> @@ -116,7 +128,8 @@ module_param(start_withtimeout, uint, 0);
>   MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
>   	" given initial timeout. Zero (default) disables this feature.");
>
> -enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865 };
> +enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865,
> +	     f81866};
>
>   static const char *f71808e_names[] = {
>   	"f71808fg",
> @@ -126,6 +139,7 @@ static const char *f71808e_names[] = {
>   	"f71882fg",
>   	"f71889fg",
>   	"f81865",
> +	"f81866",
>   };
>
>   /* Super-I/O Function prototypes */
> @@ -370,6 +384,13 @@ static int watchdog_start(void)
>   		superio_clear_bit(watchdog.sioaddr, SIO_REG_MFUNCT3, 5);
>   		break;
>
> +	case f81866:
> +		/* Set pin 70 to WDTRST# */
> +		superio_clear_bit(watchdog.sioaddr, SIO_REG_PORT_SEL, 9);
> +		superio_set_bit(watchdog.sioaddr, SIO_REG_PORT_SEL, 4);
> +		superio_clear_bit(watchdog.sioaddr, SIO_REG_GPIO1, 0x20);

Using BIT() here would be a bit nicer. Yes, I know, it isn't done everywhere
in this driver, but that doesn't mean we should not do it in added code.

> +		break;
> +
>   	default:
>   		/*
>   		 * 'default' label to shut up the compiler and catch
> @@ -382,7 +403,7 @@ static int watchdog_start(void)
>   	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
>   	superio_set_bit(watchdog.sioaddr, SIO_REG_ENABLE, 0);
>
> -	if (watchdog.type == f81865)
> +	if (watchdog.type == f81865 || watchdog.type == f81866)
>   		superio_set_bit(watchdog.sioaddr, F81865_REG_WDO_CONF,
>   				F81865_FLAG_WDOUT_EN);
>   	else
> @@ -788,6 +809,9 @@ static int __init f71808e_find(int sioaddr)
>   	case SIO_F81865_ID:
>   		watchdog.type = f81865;
>   		break;
> +	case SIO_F81866_ID:
> +		watchdog.type = f81866;
> +		break;
>   	default:
>   		pr_info("Unrecognized Fintek device: %04x\n",
>   			(unsigned int)devid);
>

