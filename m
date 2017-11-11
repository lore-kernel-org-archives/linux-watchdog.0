Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45943 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751722AbdKKQlC (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 11 Nov 2017 11:41:02 -0500
Received: by mail-pf0-f193.google.com with SMTP id d28so8872115pfe.2
        for <linux-watchdog@vger.kernel.org>; Sat, 11 Nov 2017 08:41:02 -0800 (PST)
Date: Sat, 11 Nov 2017 08:40:58 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Radu Rendec <rrendec@arista.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
Subject: Re: [v2,1/2] watchdog: xen_wdt: use the watchdog subsystem
Message-ID: <20171111164058.GA11701@roeck-us.net>
References: <20171106190412.10023-2-rrendec@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171106190412.10023-2-rrendec@arista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 06, 2017 at 07:04:11PM +0000, Radu Rendec wrote:
> Change the xen_wdt driver to use the watchdog subsystem instead of
> registering and manipulating the char device directly through the misc
> API. This is mainly getting rid of the "write" and "ioctl" methods and
> part of the watchdog control logic (which are all implemented by the
> watchdog subsystem).
> 
> Even though the watchdog subsystem supports registering and handling
> multiple watchdog devices at the same time, the xen_wdt driver has an
> inherent limitation of only one device due to the way the Xen hypervisor
> exposes watchdog functionality. However, the driver can now coexist with
> other watchdog devices (supported by different drivers).
> 
> Signed-off-by: Radu Rendec <rrendec@arista.com>

I just noticed this escaped my attention, possibly because it was sent
as reply to v1. Doesn't it say samewhere that you should not do that ?

> ---
>  drivers/watchdog/xen_wdt.c | 239 ++++++++++-----------------------------------
>  1 file changed, 49 insertions(+), 190 deletions(-)
> 
> diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
> index 5dd5c3494d55..5513047b70c9 100644
> --- a/drivers/watchdog/xen_wdt.c
> +++ b/drivers/watchdog/xen_wdt.c

[ ... ]

> -static int xen_wdt_probe(struct platform_device *dev)
> +static int xen_wdt_probe(struct platform_device *pdev)
>  {
>  	struct sched_watchdog wd = { .id = ~0 };
>  	int ret = HYPERVISOR_sched_op(SCHEDOP_watchdog, &wd);
>  
> -	switch (ret) {
> -	case -EINVAL:
> -		if (!timeout) {
> -			timeout = WATCHDOG_TIMEOUT;
> -			pr_info("timeout value invalid, using %d\n", timeout);
> -		}
> -
> -		ret = misc_register(&xen_wdt_miscdev);
> -		if (ret) {
> -			pr_err("cannot register miscdev on minor=%d (%d)\n",
> -			       WATCHDOG_MINOR, ret);
> -			break;
> -		}
> -
> -		pr_info("initialized (timeout=%ds, nowayout=%d)\n",
> -			timeout, nowayout);
> -		break;
> -
> -	case -ENOSYS:
> -		pr_info("not supported\n");
> -		ret = -ENODEV;
> -		break;
> -
> -	default:
> -		pr_info("bogus return value %d\n", ret);
> -		break;
> +	if (ret == -ENOSYS) {
> +		pr_err("watchdog not supported by hypervisor\n");
> +		return -ENODEV;
>  	}
>  
> -	return ret;
> -}
> +	if (ret != -EINVAL) {
> +		pr_err("unexpected hypervisor error (%d)\n", ret);
> +		return -ENODEV;
> +	}
>  
> -static int xen_wdt_remove(struct platform_device *dev)
> -{
> -	/* Stop the timer before we leave */
> -	if (!nowayout)
> -		xen_wdt_stop();
> +	if (watchdog_init_timeout(&xen_wdt_dev, timeout, NULL))
> +		pr_info("timeout value invalid, using %d\n",
> +			xen_wdt_dev.timeout);

dev_info has that odd "wdt: " header because DRV_NAME is set to "wdt",
which doesn't really make much sense. Please use something more sensible
for DRV_NAME and use dev_info.

Guenter
