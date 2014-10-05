Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48969 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbaJEBvq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 4 Oct 2014 21:51:46 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XaazB-003UTP-Nr
	for linux-watchdog@vger.kernel.org; Sun, 05 Oct 2014 01:51:45 +0000
Message-ID: <5430A427.2090303@roeck-us.net>
Date: Sat, 04 Oct 2014 18:51:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Chen Gang <gang.chen.5i5j@gmail.com>, wim@iguana.be
CC: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] watchdog: Let XILINX_WATCHDOG and TEGRA_WATCHDOG depend
 on HAS_IOMEM
References: <542FC064.1030604@gmail.com> <54309EC1.6040801@gmail.com>
In-Reply-To: <54309EC1.6040801@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/04/2014 06:28 PM, Chen Gang wrote:
> They need HAS_IOMEM, so let them depend on it, the related error (with
> allmodconfig under um):
>
>      MODPOST 1205 modules
>    ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] undefined!
>    ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko] undefined!
>
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index a51ccf3..d0ddf90 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -132,6 +132,7 @@ config WM8350_WATCHDOG
>
>   config XILINX_WATCHDOG
>   	tristate "Xilinx Watchdog timer"
> +	depends on HAS_IOMEM
>   	select WATCHDOG_CORE
>   	help
>   	  Watchdog driver for the xps_timebase_wdt ip core.
> @@ -472,7 +473,7 @@ config SIRFSOC_WATCHDOG
>
>   config TEGRA_WATCHDOG
>   	tristate "Tegra watchdog"
> -	depends on ARCH_TEGRA || COMPILE_TEST
> +	depends on (ARCH_TEGRA || COMPILE_TEST) && HAS_IOMEM
>   	select WATCHDOG_CORE
>   	help
>   	  Say Y here to include support for the watchdog timer
>

