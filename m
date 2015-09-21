Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:54035 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757054AbbIUPEi (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 21 Sep 2015 11:04:38 -0400
Subject: Re: [PATCH 2/6] watchdog: Add support for Freescale Layerscape
 platforms
To: Zhiqiang Hou <B48286@freescale.com>,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will.deacon@arm.com, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org
References: <1442838158-2964-1-git-send-email-B48286@freescale.com>
 <1442838158-2964-3-git-send-email-B48286@freescale.com>
Cc: wsa@the-dreams.de, wim@iguana.be, corbet@lwn.net,
	mturquette@baylibre.com, sboyd@codeaurora.org,
	Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com,
	Wenbin.Song@freescale.com, scottwood@freescale.com,
	bhupesh.sharma@freescale.com, leoli@freescale.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56001C7D.4050408@roeck-us.net>
Date: Mon, 21 Sep 2015 08:04:29 -0700
MIME-Version: 1.0
In-Reply-To: <1442838158-2964-3-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/21/2015 05:22 AM, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>
> Modify watchdog/Kconfig file to support Layerscape platforms.
>
"Enable IMX2+ watchdog for Layerscape platforms" would be a better
description.

Nitpick, so

Acked-by: Guenter Roeck <linux@roeck-us.net>

> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c68edc1..2862219 100644
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

