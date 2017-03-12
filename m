Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57181 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935168AbdCLUuq (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 12 Mar 2017 16:50:46 -0400
Subject: Re: [PATCH v2 6/8] ARM: dts: exynos: Fix infinite interrupt in soft
 mode on Exynos4210 and Exynos5440
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-7-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <cd593e3b-79ca-0813-b2c1-10e2ae3aab63@roeck-us.net>
Date: Sun, 12 Mar 2017 13:50:42 -0700
MIME-Version: 1.0
In-Reply-To: <20170311172527.16368-7-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/11/2017 09:25 AM, Krzysztof Kozlowski wrote:
> In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
> of an interrupt.  The interrupt has to be cleared, because otherwise
> system enters infinite interrupt handling loop.
>
> Use a samsung,s3c6410-wdt compatible to select appropriate quirk for
> clearing the watchdog interrupt.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 +-
>  arch/arm/boot/dts/exynos5440.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 9d51d4d62d94..e6e62103a71f 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -120,7 +120,7 @@
>  	};
>
>  	watchdog: watchdog@10060000 {
> -		compatible = "samsung,s3c2410-wdt";
> +		compatible = "samsung,s3c6410-wdt";
>  		reg = <0x10060000 0x100>;
>  		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&clock CLK_WDT>;
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index 77d35bb92950..abfe054b2187 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -189,7 +189,7 @@
>  	};
>
>  	watchdog@110000 {
> -		compatible = "samsung,s3c2410-wdt";
> +		compatible = "samsung,s3c6410-wdt";
>  		reg = <0x110000 0x1000>;
>  		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&clock CLK_B_125>;
>

