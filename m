Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35634 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751571AbdBXV7E (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 16:59:04 -0500
Subject: Re: [PATCH 4/7] watchdog: s3c2410: Add prefix to local function
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170224210746.12459-1-krzk@kernel.org>
 <20170224210746.12459-4-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <d86371e6-bc16-d4d5-cdca-af72a0a3d3d6@roeck-us.net>
Date: Fri, 24 Feb 2017 13:58:54 -0800
MIME-Version: 1.0
In-Reply-To: <20170224210746.12459-4-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/24/2017 01:07 PM, Krzysztof Kozlowski wrote:
> Functions marked static inline might not be inlined so a driver-specific
> prefix for function name helps when looking through call backtrace.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/s3c2410_wdt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
> index f7aad19d20ff..a031842ffcb0 100644
> --- a/drivers/watchdog/s3c2410_wdt.c
> +++ b/drivers/watchdog/s3c2410_wdt.c
> @@ -507,9 +507,8 @@ static inline unsigned int s3c2410wdt_get_bootstatus(struct s3c2410_wdt *wdt)
>  	return 0;
>  }
>
> -/* s3c2410_get_wdt_driver_data */
>  static inline struct s3c2410_wdt_variant *
> -get_wdt_drv_data(struct platform_device *pdev)
> +s3c2410_get_wdt_drv_data(struct platform_device *pdev)
>  {
>  	if (pdev->dev.of_node) {
>  		const struct of_device_id *match;
> @@ -541,7 +540,7 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
>  	spin_lock_init(&wdt->lock);
>  	wdt->wdt_device = s3c2410_wdd;
>
> -	wdt->drv_data = get_wdt_drv_data(pdev);
> +	wdt->drv_data = s3c2410_get_wdt_drv_data(pdev);
>  	if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
>  		wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
>  						"samsung,syscon-phandle");
>

