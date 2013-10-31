Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:42128 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab3JaMJy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 31 Oct 2013 08:09:54 -0400
From: Tomasz Figa <t.figa@samsung.com>
To: Leela Krishna Amudala <l.krishna@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com,
	wim@iguana.be, devicetree@vger.kernel.org, dianders@chromium.org,
	linux-watchdog@vger.kernel.org, cpgs@samsung.com,
	sachin.kamat@linaro.org
Subject: Re: [PATCH V5 2/3] ARM: dts: add watchdog device nodes for Exynos5250
 and Exynos5420
Date: Thu, 31 Oct 2013 13:09:50 +0100
Message-id: <7363021.FRzpFKVCjA@amdc1227>
In-reply-to: <1383199250-15405-3-git-send-email-l.krishna@samsung.com>
References: <1383199250-15405-1-git-send-email-l.krishna@samsung.com>
 <1383199250-15405-3-git-send-email-l.krishna@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset=us-ascii
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Leela,

On Thursday 31 of October 2013 11:30:49 Leela Krishna Amudala wrote:
> Adds watchdog device nodes to the DT device list for Exynos5250 and Exynos5420
> 
> Signed-off-by: Leela Krishna Amudala <l.krishna@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi    |    7 -------
>  arch/arm/boot/dts/exynos5250.dtsi |    7 ++++++-
>  arch/arm/boot/dts/exynos5420.dtsi |   10 ++++++++++
>  3 files changed, 16 insertions(+), 8 deletions(-)
[snip]
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index c4a8662..7e4867f 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -158,9 +158,14 @@
>  		interrupts = <0 47 0>;
>  	};
>  
> -	watchdog {
> +	watchdog@101D0000 {
> +		compatible = "samsung,exynos5250-wdt";
> +		reg = <0x101D0000 0x100>;
> +		interrupts = <0 42 0>;
>  		clocks = <&clock 336>;
>  		clock-names = "watchdog";
> +		samsung,syscon-phandle = <&pmu_syscon>;
> +		status = "okay";

You can drop the status property here, as it's "okay" by default.

>  	};
>  
>  	g2d@10850000 {
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 6ffefd1..8585fe7 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -369,4 +369,14 @@
>  		clock-names = "gscl";
>  		samsung,power-domain = <&gsc_pd>;
>  	};
> +
> +        watchdog@101D0000 {

Is it just my mail client or there is an indentation issue here?

> +		compatible = "samsung,exynos5420-wdt";
> +		reg = <0x101D0000 0x100>;
> +		interrupts = <0 42 0>;
> +		clocks = <&clock 316>;
> +		clock-names = "watchdog";
> +		samsung,syscon-phandle = <&pmu_syscon>;
> +		status = "okay";

Status property can be dropped.

> +        };

Wrong indentation?

Best regards,
Tomasz

