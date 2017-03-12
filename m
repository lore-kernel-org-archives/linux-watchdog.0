Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40218 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934692AbdCLVAz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 12 Mar 2017 17:00:55 -0400
Subject: Re: [PATCH v2 2/3] watchdog: s3c2410: Simplify getting driver data
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20170311174255.23327-1-krzk@kernel.org>
 <20170311174255.23327-3-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <60295052-72f2-6a04-f211-20c801df2ae9@roeck-us.net>
Date: Sun, 12 Mar 2017 14:00:50 -0700
MIME-Version: 1.0
In-Reply-To: <20170311174255.23327-3-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/11/2017 09:42 AM, Krzysztof Kozlowski wrote:
> Simplify the flow in helper function for getting the driver data by
> using of_device_get_match_data() and only one if() branch.
>
> The code should be equivalent.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/watchdog/s3c2410_wdt.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 5eaec319e499..d7ddee0668c3 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -37,6 +37,7 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/regmap.h>
>  #include <linux/delay.h>
> @@ -510,14 +511,16 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>  static inline const struct s3c2410_wdt_variant *
>  s3c2410_get_wdt_drv_data(struct platform_device *pdev)
>  {
> -	if (pdev->dev.of_node) {
> -		const struct of_device_id *match;
> -		match = of_match_node(s3c2410_wdt_match, pdev->dev.of_node);
> -		return (const struct s3c2410_wdt_variant *)match->data;
> -	} else {
> -		return (const struct s3c2410_wdt_variant *)
> -			platform_get_device_id(pdev)->driver_data;
> +	const struct s3c2410_wdt_variant *variant;
> +
> +	variant = of_device_get_match_data(&pdev->dev);
> +	if (!variant) {
> +		/* Device matched by platform_device_id */
> +		variant = (const struct s3c2410_wdt_variant *)

Please drop the const and rebase to the simplified patch 1/3.

> +			  platform_get_device_id(pdev)->driver_data;
>  	}
> +
> +	return variant;
>  }
>
>  static int s3c2410wdt_probe(struct platform_device *pdev)
>

