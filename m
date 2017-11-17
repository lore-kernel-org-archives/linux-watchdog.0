Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42947 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933430AbdKQObx (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 17 Nov 2017 09:31:53 -0500
Subject: Re: [PATCH] watchdog: pcwd_usb: remove unneeded DRIVER_LICENSE
 #define
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-watchdog@vger.kernel.org
References: <20171117142203.GG17880@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <40fb6822-6797-cca7-763a-6c76b2bc4b66@roeck-us.net>
Date: Fri, 17 Nov 2017 06:31:50 -0800
MIME-Version: 1.0
In-Reply-To: <20171117142203.GG17880@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/17/2017 06:22 AM, Greg Kroah-Hartman wrote:
> There is no need to #define the license of the driver, just put it in
> the MODULE_LICENSE() line directly as a text string.
> 
> This allows tools that check that the module license matches the source
> code license to work properly, as there is no need to unwind the
> unneeded dereference, especially when it is defined just a few lines
> above from where it is used.
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/pcwd_usb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index b9e376c8e2e3..07a97708cb3a 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -49,12 +49,11 @@
>   #define DRIVER_VERSION "1.02"
>   #define DRIVER_AUTHOR "Wim Van Sebroeck <wim@iguana.be>"
>   #define DRIVER_DESC "Berkshire USB-PC Watchdog driver"
> -#define DRIVER_LICENSE "GPL"
>   #define DRIVER_NAME "pcwd_usb"
>   
>   MODULE_AUTHOR(DRIVER_AUTHOR);
>   MODULE_DESCRIPTION(DRIVER_DESC);
> -MODULE_LICENSE(DRIVER_LICENSE);
> +MODULE_LICENSE("GPL");
>   
>   #define WATCHDOG_HEARTBEAT 0	/* default heartbeat =
>   						delay-time from dip-switches */
> 

