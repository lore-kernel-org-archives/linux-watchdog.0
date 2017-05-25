Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:41205 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754836AbdEYA7I (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 May 2017 20:59:08 -0400
Subject: Re: [PATCH v4 3/3] ARM: socfpga: dtsi: add dw-wdt reset lines
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dinh Nguyen <dinguyen@opensource.altera.com>,
        linux-arm-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
References: <cover.50aaf23e8fbe9028f711a67e39b96910c986e8b0.1495443015.git-series.s.trumtrar@pengutronix.de>
 <1606b1da6758142628496ae85b15b3f89f0f928d.1495443015.git-series.s.trumtrar@pengutronix.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <b373e06d-ecd9-0c22-5c6c-043bb0e395fa@roeck-us.net>
Date: Wed, 24 May 2017 17:59:04 -0700
MIME-Version: 1.0
In-Reply-To: <1606b1da6758142628496ae85b15b3f89f0f928d.1495443015.git-series.s.trumtrar@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 05/22/2017 01:51 AM, Steffen Trumtrar wrote:
> Add the reset lines to both watchdogs.
> 
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Dinh Nguyen <dinguyen@opensource.altera.com>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/socfpga.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> index b2674bdb8e6a..547b2720abf5 100644
> --- a/arch/arm/boot/dts/socfpga.dtsi
> +++ b/arch/arm/boot/dts/socfpga.dtsi
> @@ -924,6 +924,7 @@
>   			reg = <0xffd02000 0x1000>;
>   			interrupts = <0 171 4>;
>   			clocks = <&osc1>;
> +			resets = <&rst L4WD0_RESET>;
>   			status = "disabled";
>   		};
>   
> @@ -932,6 +933,7 @@
>   			reg = <0xffd03000 0x1000>;
>   			interrupts = <0 172 4>;
>   			clocks = <&osc1>;
> +			resets = <&rst L4WD1_RESET>;
>   			status = "disabled";
>   		};
>   	};
> 

