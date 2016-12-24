Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44706 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751995AbcLXQTS (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 24 Dec 2016 11:19:18 -0500
Subject: Re: [PATCH] drivers: watchdog: booke_wdt: add __ro_after_init to
 booke_wdt_info
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr,
        wim@iguana.be, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1482595652-29029-1-git-send-email-bhumirks@gmail.com>
Cc: keescook@chromium.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <191213e2-2053-982f-fb24-8b05b96d594d@roeck-us.net>
Date: Sat, 24 Dec 2016 08:19:15 -0800
MIME-Version: 1.0
In-Reply-To: <1482595652-29029-1-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/24/2016 08:07 AM, Bhumika Goyal wrote:
> The object booke_wdt_info of watchdog_info structure is not
> modified after getting initialized by booke_wdt_init. Apart from getting
> referenced in init it is also stored in the info field of watchdog_device
> structure which is of type const struct watchdog_info *info. So, it
> becomes read only after init and therefore add __ro_after_init to it's
> declaration.
>
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/booke_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
> index 04da4b6..ae034bb 100644
> --- a/drivers/watchdog/booke_wdt.c
> +++ b/drivers/watchdog/booke_wdt.c
> @@ -192,7 +192,7 @@ static int booke_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  	return 0;
>  }
>
> -static struct watchdog_info booke_wdt_info = {
> +static struct watchdog_info booke_wdt_info __ro_after_init = {
>  	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
>  	.identity = "PowerPC Book-E Watchdog",
>  };
>

