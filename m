Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34514 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdKTRok (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Nov 2017 12:44:40 -0500
Date: Mon, 20 Nov 2017 09:44:38 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: ib700wdt: mark expected switch fall-through
Message-ID: <20171120174438.GD28658@roeck-us.net>
References: <20171120172221.GA18165@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120172221.GA18165@embeddedor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 20, 2017 at 11:22:21AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/ib700wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
> index f2e4e1e..cc26228 100644
> --- a/drivers/watchdog/ib700wdt.c
> +++ b/drivers/watchdog/ib700wdt.c
> @@ -218,7 +218,7 @@ static long ibwdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  		if (ibwdt_set_heartbeat(new_margin))
>  			return -EINVAL;
>  		ibwdt_ping();
> -		/* Fall */
> +		/* fall through */
>  
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(timeout, p);
> -- 
> 2.7.4
> 
