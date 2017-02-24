Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54212 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751332AbdBXWGP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 17:06:15 -0500
Subject: Re: [PATCH 5/7] watchdog: s3c2410: Constify local structures
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170224210746.12459-1-krzk@kernel.org>
 <20170224210746.12459-5-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7100fd29-a21d-25c0-b989-644e1358b34b@roeck-us.net>
Date: Fri, 24 Feb 2017 14:05:56 -0800
MIME-Version: 1.0
In-Reply-To: <20170224210746.12459-5-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/24/2017 01:07 PM, Krzysztof Kozlowski wrote:
> Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
> modified so they can be made const to increase code safeness.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Conflicts with "watchdog: constify watchdog_ops structures" in my tree.
I rebased my tree to v4.10 (which I should not really have done ;-), but
it still doesn't apply due to "fatal: sha1 information is lacking or useless"
and "error: could not build fake ancestor". The subsequent patches also don't
apply. You may have to wait until after -rc1, rebase your patches, and
resubmit.

Guenter

> ---
>  drivers/watchdog/s3c2410_wdt.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index a031842ffcb0..5eaec319e499 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -131,7 +131,7 @@ struct s3c2410_wdt {
>  	unsigned long		wtdat_save;
>  	struct watchdog_device	wdt_device;
>  	struct notifier_block	freq_transition;
> -	struct s3c2410_wdt_variant *drv_data;
> +	const struct s3c2410_wdt_variant *drv_data;
>  	struct regmap *pmureg;
>  };
>
> @@ -392,7 +392,7 @@ static const struct watchdog_info s3c2410_wdt_ident = {
>  	.identity         =	"S3C2410 Watchdog",
>  };
>
> -static struct watchdog_ops s3c2410wdt_ops = {
> +static const struct watchdog_ops s3c2410wdt_ops = {
>  	.owner = THIS_MODULE,
>  	.start = s3c2410wdt_start,
>  	.stop = s3c2410wdt_stop,
> @@ -401,7 +401,7 @@ static struct watchdog_ops s3c2410wdt_ops = {
>  	.restart = s3c2410wdt_restart,
>  };
>
> -static struct watchdog_device s3c2410_wdd = {
> +static const struct watchdog_device s3c2410_wdd = {
>  	.info = &s3c2410_wdt_ident,
>  	.ops = &s3c2410wdt_ops,
>  	.timeout = S3C2410_WATCHDOG_DEFAULT_TIME,
> @@ -507,15 +507,15 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>  	return 0;
>  }
>
> -static inline struct s3c2410_wdt_variant *
> +static inline const struct s3c2410_wdt_variant *
>  s3c2410_get_wdt_drv_data(struct platform_device *pdev)
>  {
>  	if (pdev->dev.of_node) {
>  		const struct of_device_id *match;
>  		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
> -		return (struct s3c2410_wdt_variant *)match->data;
> +		return (const struct s3c2410_wdt_variant *)match->data;
>  	} else {
> -		return (struct s3c2410_wdt_variant *)
> +		return (const struct s3c2410_wdt_variant *)
>  			platform_get_device_id(pdev)->driver_data;
>  	}
>  }
>

