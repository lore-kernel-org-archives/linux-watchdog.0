Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60542 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbcF3NnF (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jun 2016 09:43:05 -0400
Subject: Re: [PATCH v3 1/3] watchdog: qcom: update device tree bindings
To: Thomas Pedersen <twp@codeaurora.org>,
	linux-watchdog@vger.kernel.org
References: <1467222602-18362-1-git-send-email-twp@codeaurora.org>
Cc: Matthew McClintock <mmcclint@codeaurora.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Russell King <linux@armlinux.org.uk>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <577521D5.6000800@roeck-us.net>
Date: Thu, 30 Jun 2016 06:42:45 -0700
MIME-Version: 1.0
In-Reply-To: <1467222602-18362-1-git-send-email-twp@codeaurora.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 06/29/2016 10:50 AM, Thomas Pedersen wrote:
> From: Matthew McClintock <mmcclint@codeaurora.org>
>
> Update the compatible string to align with driver and also
> add SoC specific string to DTS.
>
> CC: linux-watchdog@vger.kernel.org
> Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
> Signed-off-by: Thomas Pedersen <twp@codeaurora.org>
>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
> Keep SoC specific compatible and add it to DTS.
> ---
>   Documentation/devicetree/bindings/watchdog/qcom-wdt.txt | 2 ++
>   arch/arm/boot/dts/qcom-apq8064.dtsi                     | 3 ++-
>   arch/arm/boot/dts/qcom-ipq8064.dtsi                     | 3 ++-
>   arch/arm/boot/dts/qcom-msm8960.dtsi                     | 3 ++-
>   4 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> index 4726924..6b7b5ce 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.txt
> @@ -7,6 +7,8 @@ Required properties :
>   			"qcom,kpss-wdt-msm8960"
>   			"qcom,kpss-wdt-apq8064"
>   			"qcom,kpss-wdt-ipq8064"
> +			"qcom,kpss-timer"
> +			"qcom,scss-timer"
>
>   - reg : shall contain base register location and length
>   - clocks : shall contain the input clock
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index df96ccd..e318d04 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -247,7 +247,8 @@
>   		};
>
>   		timer@200a000 {
> -			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			compatible = "qcom,kpss-timer",
> +				     "qcom,kpss-wdt-apq8064", "qcom,msm-timer";
>   			interrupts = <1 1 0x301>,
>   				     <1 2 0x301>,
>   				     <1 3 0x301>;
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index 2601a90..2e37557 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -122,7 +122,8 @@
>   		};
>
>   		timer@200a000 {
> -			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			compatible = "qcom,kpss-timer",
> +				     "qcom,kpss-wdt-ipq8064", "qcom,msm-timer";
>   			interrupts = <1 1 0x301>,
>   				     <1 2 0x301>,
>   				     <1 3 0x301>,
> diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
> index da05e28..288f56e 100644
> --- a/arch/arm/boot/dts/qcom-msm8960.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
> @@ -87,7 +87,8 @@
>   		};
>
>   		timer@200a000 {
> -			compatible = "qcom,kpss-timer", "qcom,msm-timer";
> +			compatible = "qcom,kpss-timer",
> +				     "qcom,kpss-wdt-msm8960", "qcom,msm-timer";
>   			interrupts = <1 1 0x301>,
>   				     <1 2 0x301>,
>   				     <1 3 0x301>;
>

