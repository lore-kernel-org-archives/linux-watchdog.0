Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33402 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeHJQIt (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 10 Aug 2018 12:08:49 -0400
Date: Fri, 10 Aug 2018 06:38:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 11/24] watchdog: jz4740: Drop dependency on
 MACH_JZ47xx, use COMPILE_TEST
Message-ID: <20180810133850.GD29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-12-paul@crapouillou.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 09, 2018 at 11:44:01PM +0200, Paul Cercueil wrote:
> Depending on MACH_JZ47xx prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> On other architectures, this driver can still be built, thanks to
> COMPILE_TEST. This is used by automated tools to find bugs, for
> instance.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
>  v5: New patch
> 
>  v6: No change
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 834222abbbdb..13a46cfa69b0 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1475,7 +1475,7 @@ config INDYDOG
>  
>  config JZ4740_WDT
>  	tristate "Ingenic jz4740 SoC hardware watchdog"
> -	depends on MACH_JZ4740 || MACH_JZ4780
> +	depends on MIPS || COMPILE_TEST
>  	depends on COMMON_CLK
>  	select WATCHDOG_CORE
>  	select INGENIC_TIMER
> -- 
> 2.11.0
> 
