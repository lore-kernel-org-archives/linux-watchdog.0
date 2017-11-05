Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:52023 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750742AbdKEPKr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 5 Nov 2017 10:10:47 -0500
Date: Sun, 5 Nov 2017 07:10:46 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: watchdog: pcwd_usb: mark expected switch fall-through
Message-ID: <20171105151046.GA26811@roeck-us.net>
References: <20171103145341.GA6518@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103145341.GA6518@embeddedor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 03, 2017 at 09:53:41AM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Notice that in this particular case I replaced "Fall" with a proper
> "fall through" comment, which is what GCC is expecting to find.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/pcwd_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index b9e376c..47fe4c5 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -456,8 +456,8 @@ static long usb_pcwd_ioctl(struct file *file, unsigned int cmd,
>  			return -EINVAL;
>  
>  		usb_pcwd_keepalive(usb_pcwd_device);
> -		/* Fall */
>  	}
> +		/* fall through */
>  
>  	case WDIOC_GETTIMEOUT:
>  		return put_user(heartbeat, p);
