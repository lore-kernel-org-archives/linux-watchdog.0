Return-path: <wimvs@spo001.leaseweb.nl>
Date: Fri, 4 Mar 2016 20:39:41 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH for-4.5] watchdog/rc32434_wdt: fix ioctl error handling
Message-ID: <20160304193941.GF6900@spo001.leaseweb.nl>
References: <1456674185-24670-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1456674185-24670-1-git-send-email-mst@redhat.com>
Sender: <wimvs@spo001.leaseweb.nl>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Michael,

> Calling return copy_to_user(...) in an ioctl will not do the right thing
> if there's a pagefault: copy_to_user returns the number of bytes not
> copied in this case.
> 
> Fix up watchdog/rc32434_wdt to do
> 	return copy_to_user(...)) ?  -EFAULT : 0;
> 
> instead.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> Untested.
> 
>  drivers/watchdog/rc32434_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/rc32434_wdt.c b/drivers/watchdog/rc32434_wdt.c
> index 71e78ef..3a75f3b 100644
> --- a/drivers/watchdog/rc32434_wdt.c
> +++ b/drivers/watchdog/rc32434_wdt.c
> @@ -237,7 +237,7 @@ static long rc32434_wdt_ioctl(struct file *file, unsigned int cmd,
>  			return -EINVAL;
>  		/* Fall through */
>  	case WDIOC_GETTIMEOUT:
> -		return copy_to_user(argp, &timeout, sizeof(int));
> +		return copy_to_user(argp, &timeout, sizeof(int)) ? -EFAULT : 0;
>  	default:
>  		return -ENOTTY;
>  	}
> -- 
> MST

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.
