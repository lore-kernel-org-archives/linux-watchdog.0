Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44147 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729559AbeKWCbd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 22 Nov 2018 21:31:33 -0500
Date: Thu, 22 Nov 2018 07:51:36 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: wim@linux-watchdog.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, andy.gross@linaro.org
Subject: Re: [PATCH v2 2/3] dt-bindings: watchdog: Add Qualcomm PM8916
 watchdog
Message-ID: <20181122155136.GA27764@roeck-us.net>
References: <1542821264-9200-1-git-send-email-loic.poulain@linaro.org>
 <1542821264-9200-2-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542821264-9200-2-git-send-email-loic.poulain@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 21, 2018 at 06:27:43PM +0100, Loic Poulain wrote:
> Document support for the Watchdog Timer (WDT) Controller in the
> Qualcomm PM8916 PMIC module.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: Add interrupts and timeout-sec props
> 
>  .../bindings/watchdog/qcom,pm8916-wdt.txt          | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> new file mode 100644
> index 0000000..8a0d304
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/qcom,pm8916-wdt.txt
> @@ -0,0 +1,29 @@
> +QCOM PM8916 watchdog timer controller
> +
> +This pm8916 watchdog timer controller must be under pm8916-pon node.
> +
> +Required properties:
> +- compatible: should be "qcom,pm8916-wdt"
> +
> +Optional properties :
> +- interrupts : interrupt for pre-timeout (bark)
> +- timeout-sec : shall contain the default watchdog timeout in seconds,
> +                if unset, the default timeout is 30 seconds

Nitpick: For whatever reason, the driver selects a default timeout of
32 seconds. However, I don't think the default timeout value should be
mentioned here in the first place.

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
> -- 
> 2.7.4
> 
