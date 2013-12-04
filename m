Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:65075 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab3LDQbV (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 4 Dec 2013 11:31:21 -0500
Received: by mail-pd0-f176.google.com with SMTP id w10so22457077pde.7
        for <linux-watchdog@vger.kernel.org>; Wed, 04 Dec 2013 08:31:21 -0800 (PST)
Date: Wed, 4 Dec 2013 08:31:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Alan <gnomes@lxorguk.ukuu.org.uk>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] sc1200_wdt: Fix oops
Message-ID: <20131204163118.GA1299@roeck-us.net>
References: <20131204153135.32175.35874.stgit@alan.etchedpixels.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131204153135.32175.35874.stgit@alan.etchedpixels.co.uk>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Dec 04, 2013 at 03:31:52PM +0000, Alan wrote:
> If loaded with isapnp = 0 the driver explodes. This is catching
> people out now and then. What should happen in the working case is
> a complete mystery and the code appears terminally confused, but we

Looks like it uses the pnp infrastructure only to auto-detect the
"io" address, and assumes that pnp_register_driver() calls the
pnp probe function immediately. Afterwards it unregisters and
works (or is supposed to work) outside the pnp subsystem. Brr.

> can at least make the error path work properly.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Partially-Resolves-bug: https://bugzilla.kernel.org/show_bug.cgi?id=53991

Actually, I think it fully resolves it, because the other part (sc520 driver
not working on SC1100 CPU) isn't a bug. It isn't working on an ARM or PPC CPU
either, nor on any Intel CPU.

Anyway,

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sc1200wdt.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
> index 3b9fff9..131193a 100644
> --- a/drivers/watchdog/sc1200wdt.c
> +++ b/drivers/watchdog/sc1200wdt.c
> @@ -409,8 +409,9 @@ static int __init sc1200wdt_init(void)
>  #if defined CONFIG_PNP
>  	/* now that the user has specified an IO port and we haven't detected
>  	 * any devices, disable pnp support */
> +	if (isapnp)
> +		pnp_unregister_driver(&scl200wdt_pnp_driver);
>  	isapnp = 0;
> -	pnp_unregister_driver(&scl200wdt_pnp_driver);
>  #endif
>  
>  	if (!request_region(io, io_len, SC1200_MODULE_NAME)) {
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
