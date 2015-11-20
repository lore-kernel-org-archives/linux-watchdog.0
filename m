Return-path: <Ray.Huang@amd.com>
Date: Fri, 20 Nov 2015 10:33:23 +0800
From: Huang Rui <ray.huang@amd.com>
To: Denis Turischev <denis.turischev@compulab.co.il>, Guenter Roeck
	<linux@roeck-us.net>
CC: Wim Van Sebroeck <wim@iguana.be>, "linux-watchdog@vger.kernel.org"
	<linux-watchdog@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Vincent Wan
	<vincent.wan@amd.com>
Subject: Re: [PATCH] sp5100_tco: Add AMD Mullins platform support
Message-ID: <20151120023322.GB21619@hr-amur2>
References: <564D9CB0.1090209@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <564D9CB0.1090209@compulab.co.il>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Denis,

On Thu, Nov 19, 2015 at 05:56:00PM +0800, Denis Turischev wrote:
> AMD Mullins watchdog is fully compatible to the previous Hudson chipset,
> reuse the existent sp5100_tco driver.
> 

Thank you to add this support!
Actually, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS is only the SMBus device id
on AMD mullins but also on many other AMD platforms. Could you please
share some test method to me, that I am glad to do some quick tests. :)

Thanks,
Rui

> Signed-off-by: Denis Turischev <denis.turischev@compulab.co.il>
> 
> diff -Nru linux-4.3.orig/drivers/watchdog/sp5100_tco.c linux-4.3/drivers/watchdog/sp5100_tco.c
> --- linux-4.3.orig/drivers/watchdog/sp5100_tco.c	2015-11-02 02:05:25.000000000 +0200
> +++ linux-4.3/drivers/watchdog/sp5100_tco.c	2015-11-19 11:08:06.272777718 +0200
> @@ -306,6 +306,8 @@
>  static const struct pci_device_id sp5100_tco_pci_tbl[] = {
>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
>  	  PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
>  	{ 0, },			/* End of list */
>  };
>  MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);	
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
