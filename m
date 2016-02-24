Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58276 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbcBXPaG (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 24 Feb 2016 10:30:06 -0500
Subject: Re: [PATCH] watchdog: orion: Depend on 32-bit ARM
To: Thierry Reding <thierry.reding@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
References: <1456323726-20234-1-git-send-email-thierry.reding@gmail.com>
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56CDCC77.9040709@roeck-us.net>
Date: Wed, 24 Feb 2016 07:29:59 -0800
MIME-Version: 1.0
In-Reply-To: <1456323726-20234-1-git-send-email-thierry.reding@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/24/2016 06:22 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The driver uses the atomic_io_modify() function to update registers, but
> that function is only available on 32-bit ARM. Recent changes have added
> ARCH_MVEBU support to 64-bit ARM and hence allowed this driver to build
> on 64-bit ARM where this function isn't available and thereby causing
> allmodconfig builds to break.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 9289da313d98..cfec157488b1 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -399,6 +399,7 @@ config DAVINCI_WATCHDOG
>   config ORION_WATCHDOG
>   	tristate "Orion watchdog"
>   	depends on ARCH_ORION5X || ARCH_DOVE || MACH_DOVE || ARCH_MVEBU
> +	depends on ARM
>   	select WATCHDOG_CORE
>   	help
>   	  Say Y here if to include support for the watchdog timer
>

