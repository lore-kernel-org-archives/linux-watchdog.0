Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:50850 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352Ab3KQC3U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 16 Nov 2013 21:29:20 -0500
Message-ID: <528829FF.8090803@roeck-us.net>
Date: Sat, 16 Nov 2013 18:29:19 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>,
	Santosh Shilimkar <santosh.shilimkar@ti.com>, wim@iguana.be,
	nsekhar@ti.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org
CC: grant.likely@linaro.org, rob.herring@calxeda.com,
	pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org,
	galak@kernel.crashing.org, ijc+devicetree@hellion.org.uk,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: Fwd: [PATCH 8/8] arm: dts: keystone: add watchdog entry
References: <1383680783-12114-9-git-send-email-ivan.khoronzhuk@ti.com> <527A28F0.6050406@ti.com>
In-Reply-To: <527A28F0.6050406@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 11/06/2013 03:33 AM, ivan.khoronzhuk wrote:
> Add watchdog entry to keystone device tree.
>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   arch/arm/boot/dts/keystone.dts |    6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/keystone.dts b/arch/arm/boot/dts/keystone.dts
> index 100bdf5..a6e5f91 100644
> --- a/arch/arm/boot/dts/keystone.dts
> +++ b/arch/arm/boot/dts/keystone.dts
> @@ -179,5 +179,11 @@
>   			interrupts = <GIC_SPI 300 IRQ_TYPE_EDGE_RISING>;
>   			clocks = <&clkspi>;
>   		};
> +
> +		wdt: wdt@022f0080 {
> +			compatible = "ti,keystone-wdt";
> +			reg = <0x022f0080 0x80>;
> +			clocks = <&clkwdtimer0>;
> +		};
>   	};
>   };
>

