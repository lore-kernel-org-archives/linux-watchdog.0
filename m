Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:52238 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750877AbdKJVAZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 10 Nov 2017 16:00:25 -0500
Date: Fri, 10 Nov 2017 13:00:23 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Eric Long <eric.long@spreadtrum.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, baolin.wang@linaro.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: watchdog: Add Spreadtrum watchdog
 documentation
Message-ID: <20171110210023.GA4591@roeck-us.net>
References: <555b315944a01b899d4f1efe20f0cd58b910a6d0.1509936580.git.eric.long@spreadtrum.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <555b315944a01b899d4f1efe20f0cd58b910a6d0.1509936580.git.eric.long@spreadtrum.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 06, 2017 at 10:46:27AM +0800, Eric Long wrote:
> This patch adds the documentation for Spreadtrum watchdog driver.
> 
> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes since v5:
> - No updates.
> 
> Changes since v4:
> - No updates.
> 
> Changes since v3:
> - No updates.
> 
> Changes since v2:
> - Add acked tag from Rob.
> 
> Changes since v1:
> - No updates.
> ---
>  .../devicetree/bindings/watchdog/sprd-wdt.txt         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt b/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
> new file mode 100644
> index 0000000..aeaf3e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/sprd-wdt.txt
> @@ -0,0 +1,19 @@
> +Spreadtrum SoCs Watchdog timer
> +
> +Required properties:
> +- compatible : Should be "sprd,sp9860-wdt".
> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : Exactly one interrupt specifier.
> +- timeout-sec : Contain the default watchdog timeout in seconds.
> +- clock-names : Contain the input clock names.
> +- clocks : Phandles to input clocks.
> +
> +Example:
> +	watchdog: watchdog@40310000 {
> +		compatible = "sprd,sp9860-wdt";
> +		reg = <0 0x40310000 0 0x1000>;
> +		interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +		timeout-sec = <12>;
> +		clock-names = "enable", "rtc_enable";
> +		clocks = <&clk_aon_apb_gates1 8>, <&clk_aon_apb_rtc_gates 9>;
> +	};
> -- 
> 1.9.1
> 
