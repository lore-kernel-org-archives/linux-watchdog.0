Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43488 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbdJVQNf (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 22 Oct 2017 12:13:35 -0400
Date: Sun, 22 Oct 2017 09:13:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be, joel@jms.id.au,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-aspeed@lists.ozlabs.org, ryan_chen@aspeedtech.com
Subject: Re: [v2,4/4] watchdog: aspeed: Move init to arch_initcall
Message-ID: <20171022161333.GA20816@roeck-us.net>
References: <20170920053020.6860-5-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170920053020.6860-5-andrew@aj.id.au>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 20, 2017 at 03:00:20PM +0930, Andrew Jeffery wrote:
> Probing at device_initcall time lead to perverse cases where the
> watchdog was probed after, say, I2C devices, which then leaves a
> potentially running watchdog at the mercy of I2C device behaviour and
> bus conditions.
> 
> Load the watchdog driver early to ensure that the kernel is patting it
> well before initialising peripherals.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

At some point we'll need to come up with a generic means to handle those
situations. Until then, I don't have a better idea.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/aspeed_wdt.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index 6c6dd3f4c48d..ca5b91e2eb92 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -316,7 +316,18 @@ static struct platform_driver aspeed_watchdog_driver = {
>  		.of_match_table = of_match_ptr(aspeed_wdt_of_table),
>  	},
>  };
> -module_platform_driver(aspeed_watchdog_driver);
> +
> +static int __init aspeed_wdt_init(void)
> +{
> +	return platform_driver_register(&aspeed_watchdog_driver);
> +}
> +arch_initcall(aspeed_wdt_init);
> +
> +static void __exit aspeed_wdt_exit(void)
> +{
> +	platform_driver_unregister(&aspeed_watchdog_driver);
> +}
> +module_exit(aspeed_wdt_exit);
>  
>  MODULE_DESCRIPTION("Aspeed Watchdog Driver");
>  MODULE_LICENSE("GPL");
