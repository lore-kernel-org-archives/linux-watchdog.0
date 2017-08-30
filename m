Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:59623 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751440AbdH3D1x (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 23:27:53 -0400
Date: Tue, 29 Aug 2017 20:27:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: watchdog: sp805: constify amba_id
Message-ID: <20170830032730.GA6693@roeck-us.net>
References: <5ed165409809ce4f450748e667a12bdcebd6b3f4.1503505965.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed165409809ce4f450748e667a12bdcebd6b3f4.1503505965.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 23, 2017 at 10:04:08PM +0530, Arvind Yadav wrote:
> amba_id are not supposed to change at runtime. All functions
> working with const amba_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/sp805_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index e7a715e..03805bc 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -281,7 +281,7 @@ static int __maybe_unused sp805_wdt_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(sp805_wdt_dev_pm_ops, sp805_wdt_suspend,
>  		sp805_wdt_resume);
>  
> -static struct amba_id sp805_wdt_ids[] = {
> +static const struct amba_id sp805_wdt_ids[] = {
>  	{
>  		.id	= 0x00141805,
>  		.mask	= 0x00ffffff,
