Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from 19.mo1.mail-out.ovh.net ([178.32.97.206]:35917 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752569Ab2APMsM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 16 Jan 2012 07:48:12 -0500
Received: from mail99.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 5A1971000FB1
	for <linux-watchdog@vger.kernel.org>; Mon, 16 Jan 2012 10:11:26 +0100 (CET)
Message-ID: <4F13E964.5020207@sigfox.com>
Date: Mon, 16 Jan 2012 10:09:56 +0100
From: Marc Vertes <marc.vertes@sigfox.com>
MIME-Version: 1.0
To: Axel Lin <axel.lin@gmail.com>
CC: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: via_wdt: Staticise wdt_pci_table
References: <1326540874.12848.1.camel@phoenix>
In-Reply-To: <1326540874.12848.1.camel@phoenix>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Axel Lin wrote:

> It is only used in this driver, so no need to make the symbol global.
> 

Agree.

Acked-by: Marc Vertes <marc.vertes@sigfox.com>

> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
>  drivers/watchdog/via_wdt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
> index 026b4bb..8b24b00 100644
> --- a/drivers/watchdog/via_wdt.c
> +++ b/drivers/watchdog/via_wdt.c
> @@ -233,7 +233,7 @@ static void __devexit wdt_remove(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
>  
> -DEFINE_PCI_DEVICE_TABLE(wdt_pci_table) = {
> +static DEFINE_PCI_DEVICE_TABLE(wdt_pci_table) = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_CX700) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX800) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_VX855) },


