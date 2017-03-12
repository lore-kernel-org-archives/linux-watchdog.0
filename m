Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37976 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935168AbdCLUuT (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 12 Mar 2017 16:50:19 -0400
Subject: Re: [PATCH v2 5/8] ARM: dts: exynos: Enable watchdog on all Exynos4
 boards
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-6-krzk@kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3934457a-7bd7-d380-aacd-d901d8bec361@roeck-us.net>
Date: Sun, 12 Mar 2017 13:50:15 -0700
MIME-Version: 1.0
In-Reply-To: <20170311172527.16368-6-krzk@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 03/11/2017 09:25 AM, Krzysztof Kozlowski wrote:
> Watchdog module does not have external dependencies so it can be safely
> enabled in exynos4.dtsi thus making it available for all Exynos4-based
> boards.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/exynos4210-origen.dts         | 4 ----
>  arch/arm/boot/dts/exynos4210.dtsi               | 1 -
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 4 ----
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi | 4 ----
>  arch/arm/boot/dts/exynos4412-origen.dts         | 4 ----
>  arch/arm/boot/dts/exynos4412.dtsi               | 1 -
>  6 files changed, 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index a2c6a13fe67b..312650e2450f 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -328,7 +328,3 @@
>  &tmu {
>  	status = "okay";
>  };
> -
> -&watchdog {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 8bff2253acca..9d51d4d62d94 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -125,7 +125,6 @@
>  		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&clock CLK_WDT>;
>  		clock-names = "watchdog";
> -		status = "disabled";
>  	};
>
>  	clock: clock-controller@10030000 {
> diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> index a36cd36a26b8..4cd62487bb16 100644
> --- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
> @@ -495,7 +495,3 @@
>  	vtmu-supply = <&ldo16_reg>;
>  	status = "okay";
>  };
> -
> -&watchdog {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index 78f118cb73d4..0f1ff792fe44 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -555,7 +555,3 @@
>  	vtmu-supply = <&ldo10_reg>;
>  	status = "okay";
>  };
> -
> -&watchdog {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> index a1ab6f94bb64..7a83e2df18a6 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -541,7 +541,3 @@
>  &serial_3 {
>  	status = "okay";
>  };
> -
> -&watchdog {
> -	status = "okay";
> -};
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 6f47988a1ab5..cc69466f17c0 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -222,7 +222,6 @@
>  		clocks = <&clock CLK_WDT>;
>  		clock-names = "watchdog";
>  		samsung,syscon-phandle = <&pmu_system_controller>;
> -		status = "disabled";
>  	};
>
>  	adc: adc@126C0000 {
>

