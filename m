Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43651 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752442AbbL0TqJ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 14:46:09 -0500
Date: Sun, 27 Dec 2015 20:46:04 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Huang Rui <ray.huang@amd.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Denis Turischev <denis.turischev@compulab.co.il>,
	Borislav Petkov <bp@alien8.de>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>
Subject: Re: [PATCH 2/2] sp5100_tco: Add AMD Carrizo platform support
Message-ID: <20151227194604.GC24655@spo001.leaseweb.nl>
References: <1448273256-1793-1-git-send-email-ray.huang@amd.com> <1448273256-1793-2-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448273256-1793-2-git-send-email-ray.huang@amd.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Rui,

> sp5100_tco watchdog is also supported on AMD KernCZ chipset of Carrizo
> platform.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Cc: Denis Turischev <denis.turischev@compulab.co.il>
> ---
>  drivers/watchdog/sp5100_tco.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index c9dd419..6467b91 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -308,6 +308,8 @@ static const struct pci_device_id sp5100_tco_pci_tbl[] = {
>  	  PCI_ANY_ID, },
>  	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
>  	  PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
>  	{ 0, },			/* End of list */
>  };
>  MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
> -- 
> 1.9.1
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

