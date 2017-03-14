Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:40322 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdCNNrz (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 14 Mar 2017 09:47:55 -0400
Subject: Re: [PATCH v3 1/3] watchdog: s3c2410: Constify local structures
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20170313190726.2988-1-krzk@kernel.org>
 <20170313190726.2988-2-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7b5ab910-2d3b-e36f-8418-25e2ffc0d647@roeck-us.net>
Date: Tue, 14 Mar 2017 06:47:51 -0700
MIME-Version: 1.0
In-Reply-To: <20170313190726.2988-2-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/13/2017 12:07 PM, Krzysztof Kozlowski wrote:
> Structures watchdog_device, watchdog_ops and s3c2410_wdt_variant are not
> modified so they can be made const to increase code safeness.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/s3c2410_wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index 6ed97596ca80..52b66bcdd1ef 100644
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
> @@ -401,7 +401,7 @@ static const struct watchdog_ops s3c2410wdt_ops = {
>  	.restart = s3c2410wdt_restart,
>  };
>
> -static struct watchdog_device s3c2410_wdd = {
> +static const struct watchdog_device s3c2410_wdd = {
>  	.info = &s3c2410_wdt_ident,
>  	.ops = &s3c2410wdt_ops,
>  	.timeout = S3C2410_WATCHDOG_DEFAULT_TIME,
> @@ -507,7 +507,7 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>  	return 0;
>  }
>
> -static inline struct s3c2410_wdt_variant *
> +static inline const struct s3c2410_wdt_variant *
>  s3c2410_get_wdt_drv_data(struct platform_device *pdev)
>  {
>  	if (pdev->dev.of_node) {
>

