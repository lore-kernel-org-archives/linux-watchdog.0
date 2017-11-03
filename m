Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:55917 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbdKCNeQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Nov 2017 09:34:16 -0400
Date: Fri, 3 Nov 2017 06:34:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: f71808e_wdt: mark expected switch fall-throughs
Message-ID: <20171103133414.GA14463@roeck-us.net>
References: <20171102192817.GA20042@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102192817.GA20042@embeddedor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 02, 2017 at 02:28:17PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/f71808e_wdt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
> index 8658dba..e0678c1 100644
> --- a/drivers/watchdog/f71808e_wdt.c
> +++ b/drivers/watchdog/f71808e_wdt.c
> @@ -627,7 +627,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>  
>  		if (new_options & WDIOS_ENABLECARD)
>  			return watchdog_start();
> -
> +		/* fall through */
>  
>  	case WDIOC_KEEPALIVE:
>  		watchdog_keepalive();
> @@ -641,7 +641,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>  			return -EINVAL;
>  
>  		watchdog_keepalive();
> -		/* Fall */
> +		/* fall through */
>  
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(watchdog.timeout, uarg.i);
