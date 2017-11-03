Return-Path: <wim@iguana.be>
Return-path: <wim@iguana.be>
Date: Fri, 3 Nov 2017 16:04:23 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_pci: mark expected switch fall-through
Message-ID: <20171103150423.GA10138@infomag.iguana.be>
References: <20171103144915.GA6243@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103144915.GA6243@embeddedor.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Gustavo,

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> ---
>  drivers/watchdog/pcwd_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
> index c0d07ee..c882252 100644
> --- a/drivers/watchdog/pcwd_pci.c
> +++ b/drivers/watchdog/pcwd_pci.c
> @@ -545,7 +545,7 @@ static long pcipcwd_ioctl(struct file *file, unsigned int cmd,
>  			return -EINVAL;
>  
>  		pcipcwd_keepalive();
> -		/* Fall */
> +		/* fall through */
>  	}
>  
>  	case WDIOC_GETTIMEOUT:
> -- 
> 2.7.4
> 

Shouldn't the /* fall through */ come after the } ?

Kind regards,
Wim.
