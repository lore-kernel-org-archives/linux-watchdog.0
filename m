Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:41241 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdJLORK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 12 Oct 2017 10:17:10 -0400
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux@roeck-us.net, wim@iguana.be, devicetree@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: mvebu: dts: connect interrupt for WD on armada-38x
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
        <20171011022958.31268-4-chris.packham@alliedtelesis.co.nz>
Date: Thu, 12 Oct 2017 16:16:58 +0200
In-Reply-To: <20171011022958.31268-4-chris.packham@alliedtelesis.co.nz> (Chris
        Packham's message of "Wed, 11 Oct 2017 15:29:58 +1300")
Message-ID: <874lr4bgdh.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Chris,
 
 On mer., oct. 11 2017, Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> The watchdog timer interrupt is available internally on the Armada-38x
> SoCs. Connect it so that we can have the orion_wdt_irq generate debug
> information when a watchdog timeout occurs.

Given the patch 2, when an interrupt is provided by the dt, then the
behavior of the watchdog changes. So we can't do it for all the
platform.

As you propose on your cover letter it is better to set it at board
level.

So instead of this patch you should update the binding documentation
with this new resources. Thanks to this each board developer will be
able to decide to use this feature or not.

Thanks,

Gregory

>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 7ff0811e61db..9ac76c54c9e5 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -408,6 +408,7 @@
>  				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
>  				clocks = <&coreclk 2>, <&refclk>;
>  				clock-names = "nbclk", "fixed";
> +				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  
>  			cpurst: cpurst@20800 {
> -- 
> 2.14.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
