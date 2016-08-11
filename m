Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:43139 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbcHKXjk (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 11 Aug 2016 19:39:40 -0400
Date: Thu, 11 Aug 2016 16:39:37 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: linux-usb@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_usb: don't print error when allocating
 urb fails
Message-ID: <20160811233937.GA31639@roeck-us.net>
References: <1470950620-26397-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470950620-26397-2-git-send-email-wsa-dev@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1470950620-26397-2-git-send-email-wsa-dev@sang-engineering.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 11, 2016 at 11:23:40PM +0200, Wolfram Sang wrote:
> kmalloc will print enough information in case of failure.
> 
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/pcwd_usb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index 68952d9ccf8394..99ebf6ea3de648 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -666,10 +666,8 @@ static int usb_pcwd_probe(struct usb_interface *interface,
>  
>  	/* allocate the urb's */
>  	usb_pcwd->intr_urb = usb_alloc_urb(0, GFP_KERNEL);
> -	if (!usb_pcwd->intr_urb) {
> -		pr_err("Out of memory\n");
> +	if (!usb_pcwd->intr_urb)
>  		goto error;
> -	}
>  
>  	/* initialise the intr urb's */
>  	usb_fill_int_urb(usb_pcwd->intr_urb, udev, pipe,
> -- 
> 2.8.1
> 
