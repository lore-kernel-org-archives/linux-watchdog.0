Return-path: <narmstrong@baylibre.com>
Subject: Re: [PATCH] watchdog: core: Fix devres_alloc() allocation size
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
References: <1470807271-8723-1-git-send-email-linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <78e269eb-93c0-dc2c-7a65-75380242ce66@baylibre.com>
Date: Thu, 11 Aug 2016 10:36:22 +0200
MIME-Version: 1.0
In-Reply-To: <1470807271-8723-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 08/10/2016 07:34 AM, Guenter Roeck wrote:
> Coverity reports:
> 
> Passing argument 152UL /* sizeof (*wdd) */ to function __devres_alloc_node
> and then casting the return value to struct watchdog_device ** is
> suspicious.
> 
> Allocation size needs to be sizeof(*rcwdd), not sizeof(*wdd).
> 
> Fixes: 83fbae5a148c ("watchdog: Add a device managed API for ...")
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/watchdog/watchdog_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
> index 6abb83cd7681..74265b2f806c 100644
> --- a/drivers/watchdog/watchdog_core.c
> +++ b/drivers/watchdog/watchdog_core.c
> @@ -349,7 +349,7 @@ int devm_watchdog_register_device(struct device *dev,
>  	struct watchdog_device **rcwdd;
>  	int ret;
>  
> -	rcwdd = devres_alloc(devm_watchdog_unregister_device, sizeof(*wdd),
> +	rcwdd = devres_alloc(devm_watchdog_unregister_device, sizeof(*rcwdd),
>  			     GFP_KERNEL);
>  	if (!rcwdd)
>  		return -ENOMEM;
> 

My bad...

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
