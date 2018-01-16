Return-Path: <lyude@redhat.com>
Return-path: <lyude@redhat.com>
Message-ID: <1516132695.18904.13.camel@redhat.com>
Subject: Re: [06/12] watchdog: sp5100_tco: Match PCI device early
From: Lyude Paul <lyude@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?ISO-8859-1?Q?Zolt=E1n_B=F6sz=F6rm=E9nyi?=
	 <zboszor@pr.hu>
Date: Tue, 16 Jan 2018 14:58:15 -0500
In-Reply-To: <1514149457-20273-7-git-send-email-linux@roeck-us.net>
References: <1514149457-20273-7-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2017-12-24 at 13:04 -0800, Guenter Roeck wrote:
> Match PCI device in module init function, not in the probe function.
> It is pointless trying to probe if we can determine early that the device
> is not supported.
> 
> Cc: Zoltán Böszörményi <zboszor@pr.hu>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/sp5100_tco.c | 66 ++++++++++++++++++++------------------
> -----
>  1 file changed, 31 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index 5a13ab483c50..5868c6b6bf17 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -312,25 +312,6 @@ static struct miscdevice sp5100_tco_miscdev = {
>  	.fops =		&sp5100_tco_fops,
>  };
>  
> -/*
> - * Data for PCI driver interface
> - *
> - * This data only exists for exporting the supported
> - * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
> - * register a pci_driver, because someone else might
> - * want to register another driver on the same PCI id.
> - */
> -static const struct pci_device_id sp5100_tco_pci_tbl[] = {
> -	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
> -	  PCI_ANY_ID, },
> -	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
> -	  PCI_ANY_ID, },
> -	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
> -	  PCI_ANY_ID, },
> -	{ 0, },			/* End of list */
> -};
> -MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
> -
>  static u8 sp5100_tco_read_pm_reg32(u8 index)
>  {
>  	u32 val = 0;
> @@ -347,27 +328,11 @@ static u8 sp5100_tco_read_pm_reg32(u8 index)
>   */
>  static int sp5100_tco_setupdevice(void)
>  {
> -	struct pci_dev *dev = NULL;
>  	const char *dev_name = NULL;
>  	u32 val;
>  	u8 base_addr;
>  	int ret;
>  
> -	/* Match the PCI device */
> -	for_each_pci_dev(dev) {
> -		if (pci_match_id(sp5100_tco_pci_tbl, dev) != NULL) {
> -			sp5100_tco_pci = dev;
> -			break;
> -		}
> -	}
> -
> -	if (!sp5100_tco_pci)
> -		return -ENODEV;
> -
> -	pr_info("PCI Vendor ID: 0x%x, Device ID: 0x%x, Revision ID:
> 0x%x\n",
> -		sp5100_tco_pci->vendor, sp5100_tco_pci->device,
> -		sp5100_tco_pci->revision);
> -
>  	/*
>  	 * Determine type of southbridge chipset.
>  	 */
> @@ -557,10 +522,41 @@ static struct platform_driver sp5100_tco_driver = {
>  	},
>  };
>  
> +/*
> + * Data for PCI driver interface
> + *
> + * This data only exists for exporting the supported
> + * PCI ids via MODULE_DEVICE_TABLE.  We do not actually
> + * register a pci_driver, because someone else might
> + * want to register another driver on the same PCI id.
> + */
> +static const struct pci_device_id sp5100_tco_pci_tbl[] = {
> +	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
> +	{ 0, },			/* End of list */
> +};
> +MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
> +
>  static int __init sp5100_tco_init_module(void)
>  {
> +	struct pci_dev *dev = NULL;
>  	int err;
>  
> +	/* Match the PCI device */
> +	for_each_pci_dev(dev) {
> +		if (pci_match_id(sp5100_tco_pci_tbl, dev) != NULL) {
> +			sp5100_tco_pci = dev;
> +			break;
> +		}
> +	}
> +
> +	if (!sp5100_tco_pci)
> +		return -ENODEV;
> +
>  	pr_info("SP5100/SB800 TCO WatchDog Timer Driver v%s\n",
> TCO_VERSION);
>  
>  	err = platform_driver_register(&sp5100_tco_driver);
-- 
Cheers,
	Lyude Paul
