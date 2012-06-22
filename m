Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53029 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756167Ab2FVQ75 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 22 Jun 2012 12:59:57 -0400
Date: Fri, 22 Jun 2012 09:53:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jan Beulich <JBeulich@suse.com>
Cc: wim@iguana.be, sameo@linux.intel.com,
	linux-watchdog@vger.kernel.org, asierra@xes-inc.com
Subject: Re: [PATCH] iTCO_wdt: add platform driver module alias
Message-ID: <20120622165323.GA8374@roeck-us.net>
References: <4FE4AE2C020000780008B78A@nat28.tlf.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4FE4AE2C020000780008B78A@nat28.tlf.novell.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jun 22, 2012 at 04:41:00PM +0100, Jan Beulich wrote:
> The recent conversion of iTCO_wdt resulted in the driver no longer
> getting loaded automatically, since it no longer has a
> MODULE_DEVICE_TABLE() included. As the lpc_ich driver now creates a
> platform device, auto-loading can easily be done by having a respective
> module alias in place.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Cc: Aaron Sierra <asierra@xes-inc.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> 
Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/iTCO_wdt.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- 3.5-rc3/drivers/watchdog/iTCO_wdt.c
> +++ 3.5-rc3-iTCO_wdt-autoload/drivers/watchdog/iTCO_wdt.c
> @@ -699,3 +699,4 @@ MODULE_DESCRIPTION("Intel TCO WatchDog T
>  MODULE_VERSION(DRV_VERSION);
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS_MISCDEV(WATCHDOG_MINOR);
> +MODULE_ALIAS("platform:" DRV_NAME);
> 
> 
> 
> 
