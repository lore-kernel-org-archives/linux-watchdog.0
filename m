Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40921 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdKTRo0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 20 Nov 2017 12:44:26 -0500
Date: Mon, 20 Nov 2017 09:44:24 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: eurotechwdt: mark expected switch fall-through
Message-ID: <20171120174424.GC28658@roeck-us.net>
References: <20171120170645.GA17678@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120170645.GA17678@embeddedor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 20, 2017 at 11:06:45AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/eurotechwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
> index 38e9671..47f77a6 100644
> --- a/drivers/watchdog/eurotechwdt.c
> +++ b/drivers/watchdog/eurotechwdt.c
> @@ -290,7 +290,7 @@ static long eurwdt_ioctl(struct file *file,
>  		eurwdt_timeout = time;
>  		eurwdt_set_timeout(time);
>  		spin_unlock(&eurwdt_lock);
> -		/* Fall */
> +		/* fall through */
>  
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(eurwdt_timeout, p);
> -- 
> 2.7.4
> 
