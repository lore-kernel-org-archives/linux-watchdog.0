Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51421 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755506AbcDDOFY (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 10:05:24 -0400
Date: Mon, 4 Apr 2016 07:05:27 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] arm64: defconfig: enable Renesas Watchdog Timer
Message-ID: <20160404140527.GA10556@roeck-us.net>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <1459511786-4286-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459511786-4286-5-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Apr 01, 2016 at 01:56:26PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index f78360c08c1eca..795d40e810ff95 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -168,6 +168,8 @@ CONFIG_POWER_RESET_SYSCON=y
>  CONFIG_THERMAL=y
>  CONFIG_THERMAL_EMULATION=y
>  CONFIG_EXYNOS_THERMAL=y
> +CONFIG_WATCHDOG=y
> +CONFIG_RENESAS_WDT=y
>  CONFIG_MFD_SPMI_PMIC=y
>  CONFIG_MFD_SEC_CORE=y
>  CONFIG_REGULATOR=y
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
