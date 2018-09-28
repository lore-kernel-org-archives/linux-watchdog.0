Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.bootlin.com ([62.4.15.54]:46493 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbeI1OX6 (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 28 Sep 2018 10:23:58 -0400
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Marek =?utf-8?Q?Beh=C3=BAn?= <marek.behun@nic.cz>
Cc: linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 4/4] arm64: dts: marvell: armada-37xx: add nodes to support watchdog
References: <20180924110654.7329-1-marek.behun@nic.cz>
        <20180924110654.7329-5-marek.behun@nic.cz>
Date: Fri, 28 Sep 2018 10:01:15 +0200
In-Reply-To: <20180924110654.7329-5-marek.behun@nic.cz> ("Marek
 =?utf-8?Q?Beh=C3=BAn=22's?=
        message of "Mon, 24 Sep 2018 13:06:54 +0200")
Message-ID: <871s9edp9w.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Marek,
 
 On lun., sept. 24 2018, Marek Behún <marek.behun@nic.cz> wrote:

> This adds the system controller node for CPU Miscellaneous Registers
> (which is needed for the watchdog node) and the watchdog node.
>
> Signed-off-by: Marek Behún <marek.behun@nic.cz>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index d9531e242eb4..f5eaec531aa8 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -80,6 +80,19 @@
>  			/* 32M internal register @ 0xd000_0000 */
>  			ranges = <0x0 0x0 0xd0000000 0x2000000>;
>  
> +			wdt: watchdog@8300 {
> +				compatible = "marvell,armada-3700-wdt";
> +				reg = <0x8300 0x40>;
> +				marvell,system-controller = <&cpu_misc>;
> +				clocks = <&xtalclk>;
> +			};
> +
> +			cpu_misc: system-controller@d000 {
> +				compatible = "marvell,armada-3700-cpu-misc",
> +					     "syscon";
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
