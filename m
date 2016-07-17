Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43803 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751138AbcGQUUy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 17 Jul 2016 16:20:54 -0400
Date: Sun, 17 Jul 2016 22:20:52 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Thomas Pedersen <twp@codeaurora.org>
Cc: linux-watchdog@vger.kernel.org,
	Matthew McClintock <mmcclint@codeaurora.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 1/3] watchdog: qcom: update device tree bindings
Message-ID: <20160717202052.GB916@spo001.leaseweb.nl>
References: <1467222602-18362-1-git-send-email-twp@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467222602-18362-1-git-send-email-twp@codeaurora.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Matthew,

> From: Matthew McClintock <mmcclint@codeaurora.org>
> 
> Update the compatible string to align with driver and also
> add SoC specific string to DTS.
> 
> CC: linux-watchdog@vger.kernel.org
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
> 
> ---
> v2:
> Keep SoC specific compatible and add it to DTS.
> ---
>  Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 2 ++
>  arch/arm/boot/dts/qcom-apq8064.dtsi                     | 3 ++-
>  arch/arm/boot/dts/qcom-ipq8064.dtsi                     | 3 ++-
>  arch/arm/boot/dts/qcom-msm8960.dtsi                     | 3 ++-
>  4 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> index 4726924..6b7b5ce 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> @@ -7,6 +7,8 @@ Required properties :
>  			"qcom,kpss-wdt-msm8960"
>  			"qcom,kpss-wdt-apq8064"
>  			"qcom,kpss-wdt-ipq8064"
> +			"qcom,kpss-timer"
> +			"qcom,scss-timer"
>  
>  - reg : shall contain base register location and length
>  - clocks : shall contain the input clock
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index df96ccd..e318d04 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -247,7 +247,8 @@
>  		};
>  
>  		timer@200a000 {
> -			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			compatible = "qcom,kpss-timer",
> +				     "qcom,kpss-wdt-apq8064", "qcom,msm-timer";
>  			interrupts = <1 1 0x301>,
>  				     <1 2 0x301>,
>  				     <1 3 0x301>;
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 2601a90..2e37557 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -122,7 +122,8 @@
>  		};
>  
>  		timer@200a000 {
> -			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			compatible = "qcom,kpss-timer",
> +				     "qcom,kpss-wdt-ipq8064", "qcom,msm-timer";
>  			interrupts = <1 1 0x301>,
>  				     <1 2 0x301>,
>  				     <1 3 0x301>,
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index da05e28..288f56e 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -87,7 +87,8 @@
>  		};
>  
>  		timer@200a000 {
> -			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			compatible = "qcom,kpss-timer",
> +				     "qcom,kpss-wdt-msm8960", "qcom,msm-timer";
>  			interrupts = <1 1 0x301>,
>  				     <1 2 0x301>,
>  				     <1 3 0x301>;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.

