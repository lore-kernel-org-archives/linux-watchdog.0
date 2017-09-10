Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33959 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750927AbdIJPSW (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Sun, 10 Sep 2017 11:18:22 -0400
Subject: Re: [PATCH v2 3/3] arm64: dts: realtek: Add watchdog node for RTD1295
To: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org
References: <20170904231602.29787-1-afaerber@suse.de>
 <20170904231602.29787-4-afaerber@suse.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <bf49f284-de9a-4990-a551-45aef2b4d0f2@roeck-us.net>
Date: Sun, 10 Sep 2017 08:18:20 -0700
MIME-Version: 1.0
In-Reply-To: <20170904231602.29787-4-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/04/2017 04:16 PM, Andreas Färber wrote:
> Add the watchdog node to the RTD1295 Device Tree.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andreas Färber <afaerber@suse.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Depends on the pending clock nodes patch.
>   
>   v1 -> v2: Unchanged
>   
>   arch/arm64/boot/dts/realtek/rtd1295.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> index fbbd6456079e..f39ab63f879d 100644
> --- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> +++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
> @@ -123,6 +123,12 @@
>   			#interrupt-cells = <1>;
>   		};
>   
> +		watchdog@98007680 {
> +			compatible = "realtek,rtd1295-watchdog";
> +			reg = <0x98007680 0x100>;
> +			clocks = <&osc27M>;
> +		};
> +
>   		uart0: serial@98007800 {
>   			compatible = "snps,dw-apb-uart";
>   			reg = <0x98007800 0x400>;
> 

