Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50493 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755583AbcDDOBA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 4 Apr 2016 10:01:00 -0400
Date: Mon, 4 Apr 2016 07:00:57 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-watchdog@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64: dts: r8a7795: Add RWDT node
Message-ID: <20160404140057.GA27688@roeck-us.net>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <1459511786-4286-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1459511786-4286-3-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Apr 01, 2016 at 01:56:24PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This patch adds the RWDT device node for r8a7795.
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

I assume the dts patches will go through the an arm64 tree.
Is this correct ?

Thanks,
Guenter

> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index bccd52e0462b92..ab0d20b7cb6f7b 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -167,6 +167,14 @@
>  					(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		};
>  
> +		wdt0: watchdog@e6020000 {
> +			compatible = "renesas,r8a7795-wdt", "renesas,rcar-gen3-wdt";
> +			reg = <0 0xe6020000 0 0x0c>;
> +			clocks = <&cpg CPG_MOD 402>;
> +			power-domains = <&cpg>;
> +			status = "disabled";
> +		};
> +
>  		gpio0: gpio@e6050000 {
>  			compatible = "renesas,gpio-r8a7795",
>  				     "renesas,gpio-rcar";
> -- 
> 2.7.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
