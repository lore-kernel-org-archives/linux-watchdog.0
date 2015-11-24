Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51311 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbbKXOBF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 09:01:05 -0500
Subject: Re: [PATCH 2/2] sp5100_tco: Add AMD Carrizo platform support
To: Huang Rui <ray.huang@amd.com>, Wim Van Sebroeck <wim@iguana.be>
References: <1448273256-1793-1-git-send-email-ray.huang@amd.com>
 <1448273256-1793-2-git-send-email-ray.huang@amd.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	Denis Turischev <denis.turischev@compulab.co.il>,
	Borislav Petkov <bp@alien8.de>,
	Vincent Wan <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56546D9A.8060406@roeck-us.net>
Date: Tue, 24 Nov 2015 06:00:58 -0800
MIME-Version: 1.0
In-Reply-To: <1448273256-1793-2-git-send-email-ray.huang@amd.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/23/2015 02:07 AM, Huang Rui wrote:
> sp5100_tco watchdog is also supported on AMD KernCZ chipset of Carrizo
> platform.
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Cc: Denis Turischev <denis.turischev@compulab.co.il>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/sp5100_tco.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
> index c9dd419..6467b91 100644
> --- a/drivers/watchdog/sp5100_tco.c
> +++ b/drivers/watchdog/sp5100_tco.c
> @@ -308,6 +308,8 @@ static const struct pci_device_id sp5100_tco_pci_tbl[] = {
>   	  PCI_ANY_ID, },
>   	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
>   	  PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
>   	{ 0, },			/* End of list */
>   };
>   MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);
>

