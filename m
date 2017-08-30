Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56613 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751746AbdH3D0i (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 29 Aug 2017 23:26:38 -0400
Date: Tue, 29 Aug 2017 20:26:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: wim@iguana.be, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: watchdog: ziirave: constify i2c_device_id
Message-ID: <20170830032625.GA18560@roeck-us.net>
References: <41ddca0e60e2e4cd9773eccb39481e3da44878e4.1503334039.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41ddca0e60e2e4cd9773eccb39481e3da44878e4.1503334039.git.arvind.yadav.cs@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Aug 21, 2017 at 10:18:38PM +0530, Arvind Yadav wrote:
> i2c_device_id are not supposed to change at runtime. All functions
> working with i2c_device_id provided by <linux/i2c.h> work with
> const i2c_device_id. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/ziirave_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
> index b4e0cea..d3594aa 100644
> --- a/drivers/watchdog/ziirave_wdt.c
> +++ b/drivers/watchdog/ziirave_wdt.c
> @@ -737,7 +737,7 @@ static int ziirave_wdt_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static struct i2c_device_id ziirave_wdt_id[] = {
> +static const struct i2c_device_id ziirave_wdt_id[] = {
>  	{ "rave-wdt", 0 },
>  	{ }
>  };
