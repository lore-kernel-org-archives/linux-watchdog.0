Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45275 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeBVB0j (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 21 Feb 2018 20:26:39 -0500
Subject: Re: [PATCH 11/13] watchdog: imgpdc: Drop METAG dependency
To: James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
References: <20180221233825.10024-1-jhogan@kernel.org>
 <20180221233825.10024-12-jhogan@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <220ed087-9a1a-eb4a-3a51-2cd3a0905b8c@roeck-us.net>
Date: Wed, 21 Feb 2018 17:26:35 -0800
MIME-Version: 1.0
In-Reply-To: <20180221233825.10024-12-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 02/21/2018 03:38 PM, James Hogan wrote:
> Now that arch/metag/ has been removed, remove the METAG dependency from
> the IMG IR device driver. The hardware is also present on MIPS SoCs so
> the driver still has value.
> 
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-watchdog@vger.kernel.org
> Cc: linux-metag@vger.kernel.org

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index aff773bcebdb..152268010c45 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1602,7 +1602,7 @@ config BCM7038_WDT
>   config IMGPDC_WDT
>   	tristate "Imagination Technologies PDC Watchdog Timer"
>   	depends on HAS_IOMEM
> -	depends on METAG || MIPS || COMPILE_TEST
> +	depends on MIPS || COMPILE_TEST
>   	select WATCHDOG_CORE
>   	help
>   	  Driver for Imagination Technologies PowerDown Controller
> 

