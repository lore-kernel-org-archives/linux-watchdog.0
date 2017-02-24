Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54572 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdBXV7E (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 16:59:04 -0500
Subject: Re: [PATCH 3/7] watchdog: s3c2410: Enable COMPILE_TEST
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170224210746.12459-1-krzk@kernel.org>
 <20170224210746.12459-3-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <4e246dd4-d46a-ae33-c1e4-a2e6854e2fc2@roeck-us.net>
Date: Fri, 24 Feb 2017 13:58:31 -0800
MIME-Version: 1.0
In-Reply-To: <20170224210746.12459-3-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/24/2017 01:07 PM, Krzysztof Kozlowski wrote:
> Driver can be compile tested on other architectures as well so use it to
> increase build coverage.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Already submitted as part of 'watchdog: Enable COMPILE_TEST where possible'.

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 338c5bc46f73..82d5f07b5e64 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -333,7 +333,7 @@ config HAVE_S3C2410_WATCHDOG
>
>  config S3C2410_WATCHDOG
>  	tristate "S3C2410 Watchdog"
> -	depends on HAVE_S3C2410_WATCHDOG
> +	depends on HAVE_S3C2410_WATCHDOG || COMPILE_TEST
>  	select WATCHDOG_CORE
>  	select MFD_SYSCON if ARCH_EXYNOS
>  	help
>

