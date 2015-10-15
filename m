Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:49857 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbbJOOZd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 15 Oct 2015 10:25:33 -0400
Subject: Re: [PATCH V4 2/6] watchdog: Add support for Freescale Layerscape
 platforms
To: Zhiqiang Hou <B48286@freescale.com>,
	linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
	will.deacon@arm.com, linux-i2c@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-clk@vger.kernel.org
References: <1444911181-21696-1-git-send-email-B48286@freescale.com>
 <1444911181-21696-2-git-send-email-B48286@freescale.com>
Cc: mark.rutland@arm.com, wsa@the-dreams.de, wim@iguana.be,
	corbet@lwn.net, mturquette@baylibre.com, sboyd@codeaurora.org,
	Mingkai.Hu@freescale.com, Shaohui.Xie@freescale.com,
	scottwood@freescale.com, bhupesh.sharma@freescale.com,
	Wenbin.Song@freescale.com
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <561FB74F.5000302@roeck-us.net>
Date: Thu, 15 Oct 2015 07:25:19 -0700
MIME-Version: 1.0
In-Reply-To: <1444911181-21696-2-git-send-email-B48286@freescale.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 10/15/2015 05:12 AM, Zhiqiang Hou wrote:
> From: Shaohui Xie <Shaohui.Xie@freescale.com>
>
> Modify watchdog/Kconfig file to support Layerscape platforms.
>
> Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> Signed-off-by: Wenbin Song <Wenbin.Song@freescale.com>
> Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
> ---
> This patch has been acked in V3 by Guenter Roeck [linux@roeck-us.net].
>
Here it is again, but if there is no change, please just add the Ack
to subsequent versions of the patch.

Acked-by: Guenter Roeck <linux@roeck-us.net>


> V4: V3 V2
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

