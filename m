Return-Path: <lyude@redhat.com>
Return-path: <lyude@redhat.com>
Message-ID: <1516132557.18904.12.camel@redhat.com>
Subject: Re: [05/12] watchdog: sp5100_tco: Clean up sp5100_tco_setupdevice
From: Lyude Paul <lyude@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?=
	 <zboszor@pr.hu>
Date: Tue, 16 Jan 2018 14:55:57 -0500
In-Reply-To: <1514149457-20273-6-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-6-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Thank you for this cleanup, the gotos that were in this code are really
confusing to read through! I'd recommend one very small change described
below. Assuming you add that in the next version:

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2017-12-24 at 13:04 -0800, Guenter Roeck wrote:
> There are too many unnecessary goto statements in sp5100_tco_setupdevice().
> Rearrange the code and limit goto statements to error handling.
> 
> Cc: Zoltán Böszörményi <zboszor@pr.hu>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/sp5100_tco.c | 62 ++++++++++++++++++++------------------
> -----
>  1 file changed, 29 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 0e816f2cdb07..5a13ab483c50 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -396,48 +396,44 @@ static int sp5100_tco_setupdevice(void)
>  	pr_debug("Got 0x%04x from indirect I/O\n", val);
>  
>  	/* Check MMIO address conflict */
> -	if (request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
> -								dev_name))
> -		goto setup_wdt;
> -	else
> +	if (!request_mem_region_exclusive(val, SP5100_WDT_MEM_MAP_SIZE,
> +					  dev_name)) {
>  		pr_debug("MMIO address 0x%04x already in use\n", val);
> +		/*
> +		 * Secondly, Find the watchdog timer MMIO address
> +		 * from SBResource_MMIO register.
> +		 */
> +		if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
> +			/* Read SBResource_MMIO from PCI config(PCI_Reg:
> 9Ch) */
> +			pci_read_config_dword(sp5100_tco_pci,
> +					      SP5100_SB_RESOURCE_MMIO_BASE,
> +					      &val);
> +		} else {
> +			/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg:
> 24h) */
> +			val =
> sp5100_tco_read_pm_reg32(SB800_PM_ACPI_MMIO_EN);
> +		}
>  
> -	/*
> -	 * Secondly, Find the watchdog timer MMIO address
> -	 * from SBResource_MMIO register.
> -	 */
> -	if (tco_has_sp5100_reg_layout(sp5100_tco_pci)) {
> -		/* Read SBResource_MMIO from PCI config(PCI_Reg: 9Ch) */
> -		pci_read_config_dword(sp5100_tco_pci,
> -				      SP5100_SB_RESOURCE_MMIO_BASE, &val);
> -	} else {
> -		/* Read SBResource_MMIO from AcpiMmioEn(PM_Reg: 24h) */
> -		val = sp5100_tco_read_pm_reg32(SB800_PM_ACPI_MMIO_EN);
> -	}
> -
> -	/* The SBResource_MMIO is enabled and mapped memory space? */
> -	if ((val & (SB800_ACPI_MMIO_DECODE_EN | SB800_ACPI_MMIO_SEL)) ==
> +		/* The SBResource_MMIO is enabled and mapped memory space?
> */
> +		if ((val & (SB800_ACPI_MMIO_DECODE_EN |
> SB800_ACPI_MMIO_SEL)) !=
>  						  SB800_ACPI_MMIO_DECODE_EN
Re-align this line since you're changing the code around here anyway

> ) {
> +			pr_notice("failed to find MMIO address, giving
> up.\n");
> +			ret = -ENODEV;
> +			goto unreg_region;
> +		}
>  		/* Clear unnecessary the low twelve bits */
>  		val &= ~0xFFF;
>  		/* Add the Watchdog Timer offset to base address. */
>  		val += SB800_PM_WDT_MMIO_OFFSET;
>  		/* Check MMIO address conflict */
> -		if (request_mem_region_exclusive(val,
> SP5100_WDT_MEM_MAP_SIZE,
> -								   dev_name
> )) {
> -			pr_debug("Got 0x%04x from SBResource_MMIO
> register\n",
> -				val);
> -			goto setup_wdt;
> -		} else
> +		if (!request_mem_region_exclusive(val,
> SP5100_WDT_MEM_MAP_SIZE,
> +						  dev_name)) {
>  			pr_debug("MMIO address 0x%04x already in use\n",
> val);
> -	} else
> -		pr_debug("SBResource_MMIO is disabled(0x%04x)\n", val);
> -
> -	pr_notice("failed to find MMIO address, giving up.\n");
> -	ret = -ENODEV;
> -	goto  unreg_region;
> +			ret = -EBUSY;
> +			goto unreg_region;
> +		}
> +		pr_debug("Got 0x%04x from SBResource_MMIO register\n",
> val);
> +	}
>  
> -setup_wdt:
>  	tcobase_phys = val;
>  
>  	tcobase = ioremap(val, SP5100_WDT_MEM_MAP_SIZE);
> @@ -472,7 +468,7 @@ static int sp5100_tco_setupdevice(void)
>  	tco_timer_stop();
>  
>  	release_region(SP5100_IO_PM_INDEX_REG, SP5100_PM_IOPORTS_SIZE);
> -	/* Done */
> +
>  	return 0;
>  
>  unreg_mem_region:
-- 
Cheers,
	Lyude Paul
