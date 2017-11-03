Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:54889 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755859AbdKCNc2 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Nov 2017 09:32:28 -0400
Date: Fri, 3 Nov 2017 06:32:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: advantechwdt: mark expected switch fall-through
Message-ID: <20171103133226.GA14257@roeck-us.net>
References: <20171102192136.GA19474@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171102192136.GA19474@embeddedor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 02, 2017 at 02:21:36PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/advantechwdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
> index 7d7db0c..f619443 100644
> --- a/drivers/watchdog/advantechwdt.c
> +++ b/drivers/watchdog/advantechwdt.c
> @@ -181,7 +181,7 @@ static long advwdt_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  		if (advwdt_set_heartbeat(new_timeout))
>  			return -EINVAL;
>  		advwdt_ping();
> -		/* Fall */
> +		/* fall through */
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(timeout, p);
>  	default:
