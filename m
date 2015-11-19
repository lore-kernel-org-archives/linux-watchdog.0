Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:46430 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbbKSQNZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 19 Nov 2015 11:13:25 -0500
Subject: Re: [PATCH] sp5100_tco: Add AMD Mullins platform support
To: Denis Turischev <denis.turischev@compulab.co.il>,
	Wim Van Sebroeck <wim@iguana.be>
References: <564D9CB0.1090209@compulab.co.il>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <564DF521.3010007@roeck-us.net>
Date: Thu, 19 Nov 2015 08:13:21 -0800
MIME-Version: 1.0
In-Reply-To: <564D9CB0.1090209@compulab.co.il>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/19/2015 01:56 AM, Denis Turischev wrote:
> AMD Mullins watchdog is fully compatible to the previous Hudson chipset,
> reuse the existent sp5100_tco driver.
>
> Signed-off-by: Denis Turischev <denis.turischev@compulab.co.il>
>
> diff -Nru linux-4.3.orig/drivers/watchdog/sp5100_tco.c linux-4.3/drivers/watchdog/sp5100_tco.c
> --- linux-4.3.orig/drivers/watchdog/sp5100_tco.c	2015-11-02 02:05:25.000000000 +0200
> +++ linux-4.3/drivers/watchdog/sp5100_tco.c	2015-11-19 11:08:06.272777718 +0200
> @@ -306,6 +306,8 @@
>   static const struct pci_device_id sp5100_tco_pci_tbl[] = {
>   	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
>   	  PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
>   	{ 0, },			/* End of list */
>   };
>   MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);	
> --

Your patch does not apply to the latest kernel. Can you rebase to v4.4-rc1 and resubmit ?

Thanks,
Guenter

