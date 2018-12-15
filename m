Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43075 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbeLOQ0E (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sat, 15 Dec 2018 11:26:04 -0500
Date: Sat, 15 Dec 2018 08:26:01 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: wim@linux-watchdog.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org
Subject: Re: [v3,2/3] dt-bindings: watchdog: Add Qualcomm PM8916 watchdog
Message-ID: <20181215162601.GA8605@roeck-us.net>
References: <1542962678-13697-2-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542962678-13697-2-git-send-email-loic.poulain@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 23, 2018 at 09:44:37AM +0100, Loic Poulain wrote:
> Document support for the Watchdog Timer (WDT) Controller in the
> Qualcomm PM8916 PMIC module.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  v2: Add interrupts and timeout-sec props
>  v3: Reword props summary
> 
>  .../bindings/watchdog/qcom,pm8916-wdt.txt          | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> new file mode 100644
> index 0000000..6fb984f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> @@ -0,0 +1,28 @@
> +QCOM PM8916 watchdog timer controller
> +
> +This pm8916 watchdog timer controller must be under pm8916-pon node.
> +
> +Required properties:
> +- compatible: should be "qcom,pm8916-wdt"
> +
> +Optional properties :
> +- interrupts : Watchdog pre-timeout (bark) interrupt.
> +- timeout-sec : Watchdog timeout value in seconds.
> +
> +Example:
> +
> +	pm8916_0: pm8916@0 {
> +		compatible = "qcom,pm8916", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +
> +		pon@800 {
> +			compatible = "qcom,pm8916-pon";
> +			reg = <0x800>;
> +
> +			watchdog {
> +				compatible = "qcom,pm8916-wdt";
> +				interrupts = <0x0 0x8 6 IRQ_TYPE_EDGE_RISING>;
> +				timeout-sec = <10>;
> +			};
> +		};
> +	};
