Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36364 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751208AbdBXPZo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 24 Feb 2017 10:25:44 -0500
Date: Fri, 24 Feb 2017 17:25:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 3/8] ARM: dts: exynos: Fix watchdog reset on Exynos4412
Message-ID: <20170224152538.3zwgoa3oreuqkx6m@kozik-lap>
References: <20170224151122.12142-1-krzk@kernel.org>
 <20170224151122.12142-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170224151122.12142-4-krzk@kernel.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 24, 2017 at 05:11:17PM +0200, Krzysztof Kozlowski wrote:
> The Exynos4412 has the same watchdog as newer SoCs (e.g. Exynos5250).
> Just like the others, for working it requires additional steps in Power
> Management Unit: unmasking the reset request and enabling the system
> reset.  Without these additional steps in PMU, the watchdog will not be
> able to reset the system on expiration event.
> 
> Change the compatible of Exynos4412 watchdog device node to
> samsung,exynos5250-wdt which includes the additional PMU steps.
> 
> This will also fix infinite watchdog interrupt in soft mode (lack of
> interrupt clear) because it is also included in samsung,exynos5250-wdt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/exynos4.dtsi    |  9 ---------
>  arch/arm/boot/dts/exynos4210.dtsi |  9 +++++++++
>  arch/arm/boot/dts/exynos4412.dtsi | 10 ++++++++++
>  3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 18def1c774d5..71e2cdae6068 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -283,15 +283,6 @@
>  		};
>  	};
>  
> -	watchdog: watchdog@10060000 {
> -		compatible = "samsung,s3c2410-wdt";
> -		reg = <0x10060000 0x100>;
> -		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&clock CLK_WDT>;
> -		clock-names = "watchdog";
> -		status = "disabled";
> -	};
> -
>  	rtc: rtc@10070000 {
>  		compatible = "samsung,s3c6410-rtc";
>  		reg = <0x10070000 0x100>;
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index f9408188f97f..e126357aba9a 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -119,6 +119,15 @@
>  		};
>  	};
>  
> +	watchdog: watchdog@10060000 {
> +		compatible = "samsung,s3c6410-wdt";

My mistake - here it should still remain at samsung,s3c2410-wdt because
I am just copying existing nodes to Exynso4210. The compatible should be
changed in patch 6/8.


Best regards,
Krzysztof

