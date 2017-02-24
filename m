Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:35673 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbdBXV6H (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 16:58:07 -0500
Subject: Re: [PATCH 2/7] watchdog: s3c2410: Select MFD_SYSCON on all Exynos
 platforms
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170224210746.12459-1-krzk@kernel.org>
 <20170224210746.12459-2-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b8ece30e-ceef-459a-a71d-d439d222a37e@roeck-us.net>
Date: Fri, 24 Feb 2017 13:57:15 -0800
MIME-Version: 1.0
In-Reply-To: <20170224210746.12459-2-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/24/2017 01:07 PM, Krzysztof Kozlowski wrote:
> Syscon is used not only on Exynos5 SoCs but also on Exynos3250,
> Exynos4412 and ARMv8 versions (Exynos5433, Exynos7).
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index acb00b53a520..338c5bc46f73 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -335,7 +335,7 @@ config S3C2410_WATCHDOG
>  	tristate "S3C2410 Watchdog"
>  	depends on HAVE_S3C2410_WATCHDOG
>  	select WATCHDOG_CORE
> -	select MFD_SYSCON if ARCH_EXYNOS5
> +	select MFD_SYSCON if ARCH_EXYNOS
>  	help
>  	  Watchdog timer block in the Samsung SoCs. This will reboot
>  	  the system when the timer expires with the watchdog enabled.
>

