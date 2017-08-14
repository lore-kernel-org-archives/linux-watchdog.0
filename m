Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53067 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdHNOtQ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 14 Aug 2017 10:49:16 -0400
Date: Mon, 14 Aug 2017 07:49:14 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_usb: constify usb_device_id
Message-ID: <20170814144914.GD14491@roeck-us.net>
References: <22fa8ca67a6d4a59997f463bf241ed56596fbcfa.1502526524.git.arvind.yadav.cs@gmail.com>
 <137fce0c4bacbbd395cb56ee9360ae677e74e401.1502526524.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <137fce0c4bacbbd395cb56ee9360ae677e74e401.1502526524.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Aug 12, 2017 at 02:09:45PM +0530, Arvind Yadav wrote:
> usb_device_id are not supposed to change at runtime. All functions
> working with usb_device_id provided by <linux/usb.h> work with
> const usb_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/pcwd_usb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index 5615f40..b9e376c 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -74,7 +74,7 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
>  #define USB_PCWD_PRODUCT_ID	0x1140
>  
>  /* table of devices that work with this driver */
> -static struct usb_device_id usb_pcwd_table[] = {
> +static const struct usb_device_id usb_pcwd_table[] = {
>  	{ USB_DEVICE(USB_PCWD_VENDOR_ID, USB_PCWD_PRODUCT_ID) },
>  	{ }					/* Terminating entry */
>  };
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
