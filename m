Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56470 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbbJNOGi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 14 Oct 2015 10:06:38 -0400
Subject: Re: [PATCH V3 2/6] watchdog: Add support for Freescale Layerscape
 platforms
To: Zhiqiang Hou <B48286@freescale.com>,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will.deacon@arm.com, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org, mark.rutland@arm.com
References: <1444822498-16477-1-git-send-email-B48286@freescale.com>
 <1444822498-16477-3-git-send-email-B48286@freescale.com>
Cc: Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com,
	scottwood@freescale.com, bhupesh.sharma@freescale.com,
	leoli@freescale.com, wsa@the-dreams.de, wim@iguana.be,
	corbet@lwn.net, mturquette@baylibre.com, sboyd@codeaurora.org,
	Wenbin.Song@freescale.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <561E6169.2000509@roeck-us.net>
Date: Wed, 14 Oct 2015 07:06:33 -0700
MIME-Version: 1.0
In-Reply-To: <1444822498-16477-3-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/14/2015 04:34 AM, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>
> Modify watchdog/Kconfig file to support Layerscape platforms.
>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> V3:
>   - No change.
>
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 79e1aa1..448dbaf 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -446,7 +446,7 @@ config MAX63XX_WATCHDOG
>
>   config IMX2_WDT
>   	tristate "IMX2+ Watchdog"
> -	depends on ARCH_MXC
> +	depends on ARCH_MXC || ARCH_LAYERSCAPE
>   	select REGMAP_MMIO
>   	select WATCHDOG_CORE
>   	help
>

