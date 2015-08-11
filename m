Return-path: <lee.jones@linaro.org>
Date: Tue, 11 Aug 2015 15:15:15 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Darren Hart <dvhart@infradead.org>,
	Matt Fleming <matt.fleming@intel.com>
Subject: Re: [PATCH v4 3/3] iTCO_wdt: Add support for TCO on Intel
 Sunrisepoint
Message-ID: <20150811141515.GK18282@x1>
References: <1438865186-25794-1-git-send-email-matt@codeblueprint.co.uk>
 <1438865186-25794-4-git-send-email-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1438865186-25794-4-git-send-email-matt@codeblueprint.co.uk>
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, 06 Aug 2015, Matt Fleming wrote:

> From: Matt Fleming <matt.fleming@intel.com>
> 
> The revision of the watchdog hardware in Sunrisepoint necessitates a new
> "version" inside the TCO watchdog driver because some of the register
> layouts have changed.
> 
> Also update the Kconfig entry to select both the LPC and SMBus drivers
> since the TCO device is on the SMBus in Sunrisepoint.
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>
> ---
> 
> v4:
>  - Explicitly list versions in iTCO_wdt_probe()
>  - Delete the now superfluous 'ret' variable in iTCO_wdt_unset_NO_REBOOT_bit()
> 
> v3:
>  - Added Guenter's Review tag
> 
> v2: 
>  - Explicitly list TCO versions and their "no reboot" bits in the switch
>    statement in no_reboot_bit()
>  - Use a switch/case statement when clearing status bits instead of
>    convoluted if/else branching
>  - Select both of the bus drivers instead of using depends
> 
>  drivers/watchdog/Kconfig    |  3 +-
>  drivers/watchdog/iTCO_wdt.c | 71 ++++++++++++++++++++++++++++-----------------
>  2 files changed, 46 insertions(+), 28 deletions(-)

Applied, thanks.

> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 241fafde42cb..55c4b5b0a317 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -797,7 +797,8 @@ config ITCO_WDT
>  	tristate "Intel TCO Timer/Watchdog"
>  	depends on (X86 || IA64) && PCI
>  	select WATCHDOG_CORE
> -	select LPC_ICH
> +	select LPC_ICH if !EXPERT
> +	select I2C_I801 if !EXPERT
>  	---help---
>  	  Hardware driver for the intel TCO timer based watchdog devices.
>  	  These drivers are included in the Intel 82801 I/O Controller
> diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
> index a94401b2deca..0acc6c5f729d 100644
> --- a/drivers/watchdog/iTCO_wdt.c
> +++ b/drivers/watchdog/iTCO_wdt.c
> @@ -145,59 +145,67 @@ static inline unsigned int ticks_to_seconds(int ticks)
>  	return iTCO_wdt_private.iTCO_version == 3 ? ticks : (ticks * 6) / 10;
>  }
>  
> +static inline u32 no_reboot_bit(void)
> +{
> +	u32 enable_bit;
> +
> +	switch (iTCO_wdt_private.iTCO_version) {
> +	case 3:
> +		enable_bit = 0x00000010;
> +		break;
> +	case 2:
> +		enable_bit = 0x00000020;
> +		break;
> +	case 4:
> +	case 1:
> +	default:
> +		enable_bit = 0x00000002;
> +		break;
> +	}
> +
> +	return enable_bit;
> +}
> +
>  static void iTCO_wdt_set_NO_REBOOT_bit(void)
>  {
>  	u32 val32;
>  
>  	/* Set the NO_REBOOT bit: this disables reboots */
> -	if (iTCO_wdt_private.iTCO_version == 3) {
> -		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		val32 |= 0x00000010;
> -		writel(val32, iTCO_wdt_private.gcs_pmc);
> -	} else if (iTCO_wdt_private.iTCO_version == 2) {
> +	if (iTCO_wdt_private.iTCO_version >= 2) {
>  		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		val32 |= 0x00000020;
> +		val32 |= no_reboot_bit();
>  		writel(val32, iTCO_wdt_private.gcs_pmc);
>  	} else if (iTCO_wdt_private.iTCO_version == 1) {
>  		pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> -		val32 |= 0x00000002;
> +		val32 |= no_reboot_bit();
>  		pci_write_config_dword(iTCO_wdt_private.pdev, 0xd4, val32);
>  	}
>  }
>  
>  static int iTCO_wdt_unset_NO_REBOOT_bit(void)
>  {
> -	int ret = 0;
> -	u32 val32;
> +	u32 enable_bit = no_reboot_bit();
> +	u32 val32 = 0;
>  
>  	/* Unset the NO_REBOOT bit: this enables reboots */
> -	if (iTCO_wdt_private.iTCO_version == 3) {
> -		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		val32 &= 0xffffffef;
> -		writel(val32, iTCO_wdt_private.gcs_pmc);
> -
> -		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		if (val32 & 0x00000010)
> -			ret = -EIO;
> -	} else if (iTCO_wdt_private.iTCO_version == 2) {
> +	if (iTCO_wdt_private.iTCO_version >= 2) {
>  		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		val32 &= 0xffffffdf;
> +		val32 &= ~enable_bit;
>  		writel(val32, iTCO_wdt_private.gcs_pmc);
>  
>  		val32 = readl(iTCO_wdt_private.gcs_pmc);
> -		if (val32 & 0x00000020)
> -			ret = -EIO;
>  	} else if (iTCO_wdt_private.iTCO_version == 1) {
>  		pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> -		val32 &= 0xfffffffd;
> +		val32 &= ~enable_bit;
>  		pci_write_config_dword(iTCO_wdt_private.pdev, 0xd4, val32);
>  
>  		pci_read_config_dword(iTCO_wdt_private.pdev, 0xd4, &val32);
> -		if (val32 & 0x00000002)
> -			ret = -EIO;
>  	}
>  
> -	return ret; /* returns: 0 = OK, -EIO = Error */
> +	if (val32 & enable_bit)
> +		return -EIO;
> +
> +	return 0;
>  }
>  
>  static int iTCO_wdt_start(struct watchdog_device *wd_dev)
> @@ -503,12 +511,21 @@ static int iTCO_wdt_probe(struct platform_device *dev)
>  		pdata->name, pdata->version, (u64)TCOBASE);
>  
>  	/* Clear out the (probably old) status */
> -	if (iTCO_wdt_private.iTCO_version == 3) {
> +	switch (iTCO_wdt_private.iTCO_version) {
> +	case 4:
> +		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
> +		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
> +		break;
> +	case 3:
>  		outl(0x20008, TCO1_STS);
> -	} else {
> +		break;
> +	case 2:
> +	case 1:
> +	default:
>  		outw(0x0008, TCO1_STS);	/* Clear the Time Out Status bit */
>  		outw(0x0002, TCO2_STS);	/* Clear SECOND_TO_STS bit */
>  		outw(0x0004, TCO2_STS);	/* Clear BOOT_STS bit */
> +		break;
>  	}
>  
>  	iTCO_wdt_watchdog_dev.bootstatus = 0;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
