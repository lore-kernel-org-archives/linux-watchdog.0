Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33735 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753794AbdL1Shh (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 28 Dec 2017 13:37:37 -0500
Subject: Re: [PATCH 2/3] watchdog: Change ISA_BUS_API dependency to selection
To: William Breathitt Gray <vilhelm.gray@gmail.com>,
        linus.walleij@linaro.org
Cc: mail@maciej.szmigiero.name, linux-gpio@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
References: <cover.1514475654.git.vilhelm.gray@gmail.com>
 <4035bdd9c6ff2b9686e69c27e5eb887fd8f9a2bf.1514475654.git.vilhelm.gray@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <839c0f58-408f-33c6-1438-236cd11adff0@roeck-us.net>
Date: Thu, 28 Dec 2017 10:37:34 -0800
MIME-Version: 1.0
In-Reply-To: <4035bdd9c6ff2b9686e69c27e5eb887fd8f9a2bf.1514475654.git.vilhelm.gray@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 12/28/2017 08:02 AM, William Breathitt Gray wrote:
> The ISA_BUS_API Kconfig option enables the compilation of the ISA bus
> driver. The ISA bus driver does not perform any hardware interaction,
> and is instead just a thin layer of software abstraction to eliminate
> boilerplate code common to ISA-style device drivers. Since ISA_BUS_API
> has no dependencies and does not jeopardize the integrity of the system
> when enabled, drivers should select it when the ISA bus driver
> functionality is needed.
> 
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ca200d1f310a..c05d5d20eebf 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -864,7 +864,8 @@ config ALIM7101_WDT
>   
>   config EBC_C384_WDT
>   	tristate "WinSystems EBC-C384 Watchdog Timer"
> -	depends on X86 && ISA_BUS_API
> +	depends on X86
> +	select ISA_BUS_API
>   	select WATCHDOG_CORE
>   	help
>   	  Enables watchdog timer support for the watchdog timer on the
> 

