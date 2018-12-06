Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43806 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbeLFR5K (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 6 Dec 2018 12:57:10 -0500
Date: Thu, 6 Dec 2018 09:57:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Jerry Hoemann <jerry.hoemann@hpe.com>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog/hpwdt: Exclude via blacklist
Message-ID: <20181206175708.GB11808@roeck-us.net>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
 <1544056943-79958-2-git-send-email-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544056943-79958-2-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 05, 2018 at 05:42:21PM -0700, Jerry Hoemann wrote:
> Instead of having explicit if statments excluding devices,
> use a pci_device_id table of devices to blacklist.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/hpwdt.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
> index 9356230..eecd014 100644
> --- a/drivers/watchdog/hpwdt.c
> +++ b/drivers/watchdog/hpwdt.c
> @@ -50,6 +50,10 @@
>  };
>  MODULE_DEVICE_TABLE(pci, hpwdt_devices);
>  
> +static const struct pci_device_id hpwdt_blacklist[] = {
> +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP, 0x1979) }, /* auxilary iLO */
> +	{0},			/* terminate list */
> +};
>  
>  /*
>   *	Watchdog operations
> @@ -274,12 +278,10 @@ static int hpwdt_init_one(struct pci_dev *dev,
>  		return -ENODEV;
>  	}
>  
> -	/*
> -	 * Ignore all auxilary iLO devices with the following PCI ID
> -	 */
> -	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP &&
> -	    dev->subsystem_device == 0x1979)
> +	if (pci_match_id(hpwdt_blacklist, dev)) {
> +		dev_dbg(&dev->dev, "Not supported on this device\n");
>  		return -ENODEV;
> +	}
>  
>  	if (pci_enable_device(dev)) {
>  		dev_warn(&dev->dev,
> -- 
> 1.8.3.1
> 
