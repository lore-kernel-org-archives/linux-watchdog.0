Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:45521 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932096AbcEKNni (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 11 May 2016 09:43:38 -0400
Date: Wed, 11 May 2016 06:43:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: ebc-c384_wdt: Simplify ebc_c384_wdt_start
 timeout computation
Message-ID: <20160511134327.GA8192@roeck-us.net>
References: <20160511130551.GA16032@sophia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160511130551.GA16032@sophia>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, May 11, 2016 at 09:05:51AM -0400, William Breathitt Gray wrote:
> The ebc_c384_wdt_set_timeout function already rounds up timeout values
> greater than 255 to a multiple of 60, so there is no need to round again
> in the ebc_c384_wdt_start function; a timeout value greater than 255 in
> ebc_c384_wdt_start will divide cleanly by 60.
> 
... except if the timeout is set with the module parameter, which is now
rounded down, which would be a problem since it would time out earlier than
expected (a timeout of 299 seconds, set with the module parameter, would
time out after 240 seconds). So you would have to do some calculations
on the timeout value set with the module parameter to ensure that it is
set to a correct value.

Guenter

> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/watchdog/ebc-c384_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
> index 77fda0b..948e687 100644
> --- a/drivers/watchdog/ebc-c384_wdt.c
> +++ b/drivers/watchdog/ebc-c384_wdt.c
> @@ -51,7 +51,7 @@ static int ebc_c384_wdt_start(struct watchdog_device *wdev)
>  
>  	/* resolution is in minutes for timeouts greater than 255 seconds */
>  	if (t > 255)
> -		t = DIV_ROUND_UP(t, 60);
> +		t /= 60;
>  
>  	outb(t, PET_ADDR);
>  
> -- 
> 2.7.3
> 
