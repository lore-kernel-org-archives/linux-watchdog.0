Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39464 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdH3DXt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 23:23:49 -0400
Date: Tue, 29 Aug 2017 20:22:54 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: zwanem@gmail.com, wim@iguana.be, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: watchdog: sc1200: constify pnp_device_id
Message-ID: <20170830032254.GA10447@roeck-us.net>
References: <aee38052d11c39f1f6957bfe9757665a0bd9976d.1502859040.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aee38052d11c39f1f6957bfe9757665a0bd9976d.1502859040.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 16, 2017 at 10:27:03AM +0530, Arvind Yadav wrote:
> pnp_device_id are not supposed to change at runtime. All functions
> working with pnp_device_id provided by <linux/pnp.h> work with
> const pnp_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sc1200wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
> index b34d3d5..8e4e2fc 100644
> --- a/drivers/watchdog/sc1200wdt.c
> +++ b/drivers/watchdog/sc1200wdt.c
> @@ -342,7 +342,7 @@ static int __init sc1200wdt_probe(void)
>  
>  #if defined CONFIG_PNP
>  
> -static struct pnp_device_id scl200wdt_pnp_devices[] = {
> +static const struct pnp_device_id scl200wdt_pnp_devices[] = {
>  	/* National Semiconductor PC87307/PC97307 watchdog component */
>  	{.id = "NSC0800", .driver_data = 0},
>  	{.id = ""},
