Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751087AbdHEBtH (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 4 Aug 2017 21:49:07 -0400
Date: Sat, 5 Aug 2017 09:47:55 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@savoirfairelinux.com, robh@kernel.org, linux@roeck-us.net,
        linus.walleij@linaro.org, fabio.estevam@nxp.com,
        mark@embeddedarm.com, kris@embeddedarm.com
Subject: Re: [PATCH v5 2/8] ARM: dts: TS-4600: add basic device tree
Message-ID: <20170805014749.GL31819@dragon>
References: <20170714203218.14409-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170714203218.14409-3-sebastien.bourdelin@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170714203218.14409-3-sebastien.bourdelin@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jul 14, 2017 at 04:32:12PM -0400, Sebastien Bourdelin wrote:
> These device trees add support for the TS-4600 by Technologic Systems.
> 
> More details here:
>   http://wiki.embeddedarm.com/wiki/TS-4600
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
> Changes v4 -> v5:
>   - fix missing signed off
> 
> Changes v3 -> v4:
>   - rebase on master
> 
> Changes v2 -> v3:
>   - rebase on master
> 
> Changes v1 -> v2:
>   - rebase on master
> ---
>  arch/arm/boot/dts/Makefile                 |  2 +
>  arch/arm/boot/dts/imx28-ts4600-common.dtsi | 78 ++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/imx28-ts4600-rev-a.dts   | 22 +++++++++
>  arch/arm/boot/dts/imx28-ts4600-rev-b.dts   | 22 +++++++++
>  4 files changed, 124 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx28-ts4600-common.dtsi
>  create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-a.dts
>  create mode 100644 arch/arm/boot/dts/imx28-ts4600-rev-b.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 4b17f35dc9a7..a3c8b7af192b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -525,6 +525,8 @@ dtb-$(CONFIG_ARCH_MXS) += \
>  	imx28-m28cu3.dtb \
>  	imx28-m28evk.dtb \
>  	imx28-sps1.dtb \
> +	imx28-ts4600-rev-a.dtb \
> +	imx28-ts4600-rev-b.dtb \
>  	imx28-tx28.dtb
>  dtb-$(CONFIG_ARCH_NOMADIK) += \
>  	ste-nomadik-s8815.dtb \
> diff --git a/arch/arm/boot/dts/imx28-ts4600-common.dtsi b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
> new file mode 100644
> index 000000000000..04bd5a5c0cb4
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-ts4600-common.dtsi
> @@ -0,0 +1,78 @@
> +/*
> + * Copyright (C) 2016 Savoir-Faire Linux
> + * Author: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx28.dtsi"
> +#include "dt-bindings/gpio/gpio.h"
> +
> +/ {
> +
> +	compatible = "technologic,imx28-ts4600", "fsl,imx28";
> +
> +	apb@80000000 {
> +		apbh@80000000 {
> +			ssp0: ssp@80010000 {
> +				compatible = "fsl,imx28-mmc";
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&mmc0_4bit_pins_a
> +					     &mmc0_sck_cfg
> +					     &en_sd_pwr>;
> +				broken-cd = <1>;
> +				bus-width = <4>;
> +				vmmc-supply = <&reg_vddio_sd0>;
> +				status = "okay";
> +			};
> +
> +			pinctrl@80018000 {
> +				pinctrl-names = "default";

This line shouldn't be needed here.

> +
> +				en_sd_pwr: en_sd_pwr {

Please have a look at bindings/pinctrl/fsl,mxs-pinctrl.txt.  The node
without 'reg' property will be treated as a pure configuration rather
than pinmux node.  You should really have a 'reg' property for it.

Also, we prefer to use hyphen than underscore in node name.

> +					fsl,pinmux-ids = <
> +						MX28_PAD_PWM3__GPIO_3_28
> +					>;
> +					fsl,drive-strength = <MXS_DRIVE_4mA>;
> +					fsl,voltage = <MXS_VOLTAGE_HIGH>;
> +					fsl,pull-up = <MXS_PULL_DISABLE>;
> +				};
> +
> +			};
> +		};
> +
> +		apbx@80040000 {
> +			pwm: pwm@80064000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pwm2_pins_a>;
> +				status = "okay";
> +			};
> +
> +			duart: serial@80074000 {
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&duart_pins_a>;
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +
> +		reg_vddio_sd0: vddio-sd0 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "vddio-sd0";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-boot-on;
> +			gpio = <&gpio3 28 0>;

Please use the defines in include/dt-bindings/gpio/gpio.h for polarity
here?

> +		};
> +	};

We are asked by DT maintainers to put fixed regulator directly under
root instead of having a fake bus container node.  We prefer to use the
following naming schema:

	reg_xxx: regulator-xxx {
		...
	};

Shawn

> +
> +};
> diff --git a/arch/arm/boot/dts/imx28-ts4600-rev-a.dts b/arch/arm/boot/dts/imx28-ts4600-rev-a.dts
> new file mode 100644
> index 000000000000..e8cb72988fcf
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-ts4600-rev-a.dts
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2016 Savoir-Faire Linux
> + * Author: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include "imx28-ts4600-common.dtsi"
> +
> +/ {
> +	model = "Technologic Systems i.MX28 TS-4600 Rev A";
> +
> +	memory {
> +		reg = <0x40000000 0x08000000>;   /* 128MB */
> +	};
> +
> +};
> diff --git a/arch/arm/boot/dts/imx28-ts4600-rev-b.dts b/arch/arm/boot/dts/imx28-ts4600-rev-b.dts
> new file mode 100644
> index 000000000000..a115f831fe2b
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx28-ts4600-rev-b.dts
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2016 Savoir-Faire Linux
> + * Author: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include "imx28-ts4600-common.dtsi"
> +
> +/ {
> +	model = "Technologic Systems i.MX28 TS-4600 Rev B";
> +
> +	memory {
> +		reg = <0x40000000 0x10000000>;   /* 256MB */
> +	};
> +
> +};
> -- 
> 2.13.0
> 
