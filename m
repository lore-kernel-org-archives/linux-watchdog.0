Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43756 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751486AbcGQUE7 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:04:59 -0400
Date: Sun, 17 Jul 2016 22:04:54 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
	tom_tsai@fintek.com.tw,
	"Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: Re: [PATCH V2] watchdog: f71808e_wdt: Add F81866 support
Message-ID: <20160717200454.GF32751@spo001.leaseweb.nl>
References: <1465369070-22808-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1465369070-22808-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Ji-Ze,

> Adds watchdog enable support for Fintek F81866 Super-IO chip to
> Fintek wdt driver (f71808e_wdt)
> 
> Tested and verified on iBASE MI802 Industrial PC
> 
> Datasheet references:
> http://www.alldatasheet.com/datasheet-pdf/pdf/459085/FINTEK/F81866AD-I.html
> 
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
> Change Log:
> V2:
> 	1. Put the newer F81866 registers in order with olds.
> 	2. Set the register from constant value to BIT() marco
> 
>  drivers/watchdog/f71808e_wdt.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index d4ba262..3b2de11 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -45,9 +45,11 @@
>  #define SIO_REG_DEVREV		0x22	/* Device revision */
>  #define SIO_REG_MANID		0x23	/* Fintek ID (2 bytes) */
>  #define SIO_REG_ROM_ADDR_SEL	0x27	/* ROM address select */
> +#define SIO_F81866_REG_PORT_SEL	0x27	/* F81866 Multi-Function Register */
>  #define SIO_REG_MFUNCT1		0x29	/* Multi function select 1 */
>  #define SIO_REG_MFUNCT2		0x2a	/* Multi function select 2 */
>  #define SIO_REG_MFUNCT3		0x2b	/* Multi function select 3 */
> +#define SIO_F81866_REG_GPIO1	0x2c	/* F81866 GPIO1 Enable Register */
>  #define SIO_REG_ENABLE		0x30	/* Logical device enable */
>  #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
>  
> @@ -60,6 +62,7 @@
>  #define SIO_F71882_ID		0x0541	/* Chipset ID */
>  #define SIO_F71889_ID		0x0723	/* Chipset ID */
>  #define SIO_F81865_ID		0x0704	/* Chipset ID */
> +#define SIO_F81866_ID		0x1010	/* Chipset ID */
>  
>  #define F71808FG_REG_WDO_CONF		0xf0
>  #define F71808FG_REG_WDT_CONF		0xf5
> @@ -116,7 +119,8 @@ module_param(start_withtimeout, uint, 0);
>  MODULE_PARM_DESC(start_withtimeout, "Start watchdog timer on module load with"
>  	" given initial timeout. Zero (default) disables this feature.");
>  
> -enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865 };
> +enum chips { f71808fg, f71858fg, f71862fg, f71869, f71882fg, f71889fg, f81865,
> +	     f81866};
>  
>  static const char *f71808e_names[] = {
>  	"f71808fg",
> @@ -126,6 +130,7 @@ static const char *f71808e_names[] = {
>  	"f71882fg",
>  	"f71889fg",
>  	"f81865",
> +	"f81866",
>  };
>  
>  /* Super-I/O Function prototypes */
> @@ -370,6 +375,22 @@ static int watchdog_start(void)
>  		superio_clear_bit(watchdog.sioaddr, SIO_REG_MFUNCT3, 5);
>  		break;
>  
> +	case f81866:
> +		/* Set pin 70 to WDTRST# */
> +		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
> +				  BIT(3) | BIT(0));
> +		superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
> +				BIT(2));
> +		/*
> +		 * GPIO1 Control Register when 27h BIT3:2 = 01 & BIT0 = 0.
> +		 * The PIN 70(GPIO15/WDTRST) is controlled by 2Ch:
> +		 *     BIT5: 0 -> WDTRST#
> +		 *           1 -> GPIO15
> +		 */
> +		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1,
> +				  BIT(5));
> +		break;
> +
>  	default:
>  		/*
>  		 * 'default' label to shut up the compiler and catch
> @@ -382,7 +403,7 @@ static int watchdog_start(void)
>  	superio_select(watchdog.sioaddr, SIO_F71808FG_LD_WDT);
>  	superio_set_bit(watchdog.sioaddr, SIO_REG_ENABLE, 0);
>  
> -	if (watchdog.type == f81865)
> +	if (watchdog.type == f81865 || watchdog.type == f81866)
>  		superio_set_bit(watchdog.sioaddr, F81865_REG_WDO_CONF,
>  				F81865_FLAG_WDOUT_EN);
>  	else
> @@ -788,6 +809,9 @@ static int __init f71808e_find(int sioaddr)
>  	case SIO_F81865_ID:
>  		watchdog.type = f81865;
>  		break;
> +	case SIO_F81866_ID:
> +		watchdog.type = f81866;
> +		break;
>  	default:
>  		pr_info("Unrecognized Fintek device: %04x\n",
>  			(unsigned int)devid);
> -- 
> 1.9.1
> 

This patch has been added to linux-watchog-next.

Kind regards,
Wim.

