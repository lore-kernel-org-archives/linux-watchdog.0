Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:33617 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389022AbeIUQgr (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 21 Sep 2018 12:36:47 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: marvell: armada-37xx: add nodes to support watchdog
References: <20180907130553.14271-1-marek.behun@nic.cz>
        <20180907130553.14271-5-marek.behun@nic.cz>
Date: Fri, 21 Sep 2018 12:48:26 +0200
In-Reply-To: <20180907130553.14271-5-marek.behun@nic.cz> ("Marek
 =?utf-8?Q?Beh=C3=BAn=22's?=
        message of "Fri, 7 Sep 2018 15:05:53 +0200")
Message-ID: <87pnx7i0sl.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Marek,
 
 On ven., sept. 07 2018, Marek Behún <marek.behun@nic.cz> wrote:

> This adds the system controller node for CPU Miscellaneous Registers
> (which is needed for the watchdog node) and the watchdog node.
>
> Signed-off-by: Marek Behún <marek.behun@nic.cz>


I just want to let you know that once you will modify the device tree
according to Rob's comment about the binding, I will apply this patch on
mvebu trees.

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index d9531e242eb4..048b072080c2 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -80,6 +80,18 @@
>  			/* 32M internal register @ 0xd000_0000 */
>  			ranges = <0x0 0x0 0xd0000000 0x2000000>;
>  
> +			wdt: watchdog-timer@8300 {
> +				compatible = "marvell,armada-3700-wdt";
> +				reg = <0x8300 0x40>;
> +				marvell,system-controller = <&cpu_misc>;
> +				clocks = <&xtalclk>;
> +			};
> +
> +			cpu_misc: system-controller@d000 {
> +				compatible = "syscon", "simple-mfd";
> +				reg = <0xd000 0x1000>;
> +			};
> +
>  			spi0: spi@10600 {
>  				compatible = "marvell,armada-3700-spi";
>  				#address-cells = <1>;
> -- 
> 2.16.4
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
