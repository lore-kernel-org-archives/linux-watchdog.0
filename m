Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44668 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbdKEPMg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 5 Nov 2017 10:12:36 -0500
Date: Sun, 5 Nov 2017 07:12:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: watchdog_dev: mark expected switch fall-through
Message-ID: <20171105151235.GA27007@roeck-us.net>
References: <20171103230327.GA4635@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103230327.GA4635@embeddedor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 03, 2017 at 06:03:27PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/watchdog_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
> index 1e971a5..a79ad5b 100644
> --- a/drivers/watchdog/watchdog_dev.c
> +++ b/drivers/watchdog/watchdog_dev.c
> @@ -720,7 +720,7 @@ static long watchdog_ioctl(struct file *file, unsigned int cmd,
>  		err = watchdog_ping(wdd);
>  		if (err < 0)
>  			break;
> -		/* Fall */
> +		/* fall through */
>  	case WDIOC_GETTIMEOUT:
>  		/* timeout == 0 means that we don't know the timeout */
>  		if (wdd->timeout == 0) {
