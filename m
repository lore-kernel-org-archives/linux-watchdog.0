Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43644 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752442AbbL0TpO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 14:45:14 -0500
Date: Sun, 27 Dec 2015 20:44:30 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Denis Turischev <denis.turischev@compulab.co.il>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sp5100_tco: Add AMD Mullins platform support
Message-ID: <20151227194430.GA24655@spo001.leaseweb.nl>
References: <564D9CB0.1090209@compulab.co.il> <5652C765.8030302@compulab.co.il> <5653449C.5060909@roeck-us.net> <565423D4.5060509@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565423D4.5060509@compulab.co.il>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Denis,

> AMD Mullins watchdog is fully compatible to the previous Hudson chipset,
> reuse the existent sp5100_tco driver.
> 
> v2: rebased to v4.4-rc2
> v3: fixed trailing whitespace
> 
> Signed-off-by: Denis Turischev <denis.turischev@compulab.co.il>
> 
> diff -Nru linux-4.4-rc2.orig/drivers/watchdog/sp5100_tco.c linux-4.4-rc2/drivers/watchdog/sp5100_tco.c
> --- linux-4.4-rc2.orig/drivers/watchdog/sp5100_tco.c	2015-11-23 02:45:59.000000000 +0200
> +++ linux-4.4-rc2/drivers/watchdog/sp5100_tco.c	2015-11-23 09:51:48.701245853 +0200
> @@ -306,6 +306,8 @@
>  static const struct pci_device_id sp5100_tco_pci_tbl[] = {
>  	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS, PCI_ANY_ID,
>  	  PCI_ANY_ID, },
> +	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, PCI_ANY_ID,
> +	  PCI_ANY_ID, },
>  	{ 0, },			/* End of list */
>  };
>  MODULE_DEVICE_TABLE(pci, sp5100_tco_pci_tbl);

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

