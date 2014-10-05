Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:42846 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbaJEASW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 4 Oct 2014 20:18:22 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XaZWn-001jcu-Uc
	for linux-watchdog@vger.kernel.org; Sun, 05 Oct 2014 00:18:22 +0000
Message-ID: <54308E48.6020809@roeck-us.net>
Date: Sat, 04 Oct 2014 17:18:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Chen Gang <gang.chen.5i5j@gmail.com>, wim@iguana.be,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/watchdog/Kconfig: Let XILINX_WATCHDOG and TEGRA_WATCHDOG
 depend on HAS_IOMEM
References: <542FC064.1030604@gmail.com>
In-Reply-To: <542FC064.1030604@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/04/2014 02:39 AM, Chen Gang wrote:
> They need HAS_IOMEM, so let them depend on it, the related error (with
> allmodconfig under um):
>
>      MODPOST 1205 modules
>    ERROR: "syscall" [fs/hostfs/hostfs.ko] undefined!
>    ERROR: "devm_ioremap_resource" [drivers/watchdog/tegra_wdt.ko] undefined!
>    ERROR: "devm_ioremap_resource" [drivers/watchdog/of_xilinx_wdt.ko] undefined!
>
Headline is a bit excessive ("watchdog: ..." would have been sufficient,
the first error is irrelevant as you found out yourself, and you got an
extra empty line here. Otherwise looks good.

Can you resubmit with that fixed ?

On a side note, guess the conclusion was to not provide a dummy for
devm_ioremap_resource if HAS_IOMEM is not defined. Too bad.

Guenter

>
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
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

