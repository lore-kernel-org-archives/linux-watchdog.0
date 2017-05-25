Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36053 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdEYA6D (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 May 2017 20:58:03 -0400
Subject: Re: [PATCH v4 1/3] watchdog: bindings: dw_wdt: add reset lines
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
References: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
 <77954d7b338db9956e15298064f21c028c2070f3.1495443015.git-series.s.trumtrar@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <92c574e1-f435-6186-283a-304a54144085@roeck-us.net>
Date: Wed, 24 May 2017 17:57:58 -0700
MIME-Version: 1.0
In-Reply-To: <77954d7b338db9956e15298064f21c028c2070f3.1495443015.git-series.s.trumtrar@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/22/2017 01:51 AM, Steffen Trumtrar wrote:
> Document the reset lines holding the watchdog core in reset.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-watchdog@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/dw_wdt.txt | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> index 08e16f684f2d..eb0914420c7c 100644
> --- a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> +++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> @@ -10,6 +10,8 @@ Required Properties:
>   Optional Properties:
>   
>   - interrupts	: The interrupt used for the watchdog timeout warning.
> +- resets	: phandle pointing to the system reset controller with
> +		line index for the watchdog.
>   
>   Example:
>   
> @@ -18,4 +20,5 @@ Example:
>   		reg = <0xffd02000 0x1000>;
>   		interrupts = <0 171 4>;
>   		clocks = <&per_base_clk>;
> +		resets = <&rst WDT0_RESET>;
>   	};
> 

