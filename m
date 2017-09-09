Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34151 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757209AbdIIBcg (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 8 Sep 2017 21:32:36 -0400
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
To: Mathieu Malaterre <malat@debian.org>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <65d7a551-9496-c0ef-f4a2-5dacc4678326@roeck-us.net>
Date: Fri, 8 Sep 2017 18:32:31 -0700
MIME-Version: 1.0
In-Reply-To: <20170908183558.1537-2-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/08/2017 11:35 AM, Mathieu Malaterre wrote:
> This driver works for jz4740 & jz4780
> 
> Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index c722cbfdc7e6..ca200d1f310a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1460,7 +1460,7 @@ config INDYDOG
>   
>   config JZ4740_WDT
>   	tristate "Ingenic jz4740 SoC hardware watchdog"
> -	depends on MACH_JZ4740
> +	depends on MACH_JZ4740 || MACH_JZ4780
>   	select WATCHDOG_CORE
>   	help
>   	  Hardware driver for the built-in watchdog timer on Ingenic jz4740 SoCs.
> 

