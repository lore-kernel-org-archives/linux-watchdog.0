Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34675 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255AbbKYGNw (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 25 Nov 2015 01:13:52 -0500
Date: Wed, 25 Nov 2015 14:13:15 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	robh+dt@kernel.org, kernel@pengutronix.de, wim@iguana.be,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	Arnd Bergmann <arnd@arndb.de>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v5 5/5] ARM: dts: TS-4800: add basic device tree
Message-ID: <20151125061315.GG11999@tiger>
References: <1448388053-30661-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448388053-30661-6-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448388053-30661-6-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 24, 2015 at 01:00:53PM -0500, Damien Riegel wrote:
> This device tree adds support for TS-4800 by Technologic Systems. This
> board is based on MX51-babbage, but there are some subtle differences in
> the pins used, and there is an additional FPGA that is memory-mapped.
> 
> More details here:
>   http://wiki.embeddedarm.com/wiki/TS-4800
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  .../devicetree/bindings/arm/technologic.txt        |   6 +

Please put binding doc into a separate patch, and have device tree
maintainers and list on copy of that patch.

>  arch/arm/boot/dts/Makefile                         |   3 +-
>  arch/arm/boot/dts/imx51-ts4800.dts                 | 190 +++++++++++++++++++++
>  3 files changed, 198 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
>  create mode 100644 arch/arm/boot/dts/imx51-ts4800.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/technologic.txt b/Documentation/devicetree/bindings/arm/technologic.txt
> new file mode 100644
> index 0000000..8422988
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/technologic.txt
> @@ -0,0 +1,6 @@
> +Technologic Systems Platforms Device Tree Bindings
> +--------------------------------------------------
> +
> +TS-4800 board
> +Required root node properties:
> +	- compatible = "technologic,imx51-ts4800", "fsl,imx51";
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bb8fa02..41b9985 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -258,7 +258,8 @@ dtb-$(CONFIG_SOC_IMX51) += \
>  	imx51-apf51dev.dtb \
>  	imx51-babbage.dtb \
>  	imx51-digi-connectcore-jsk.dtb \
> -	imx51-eukrea-mbimxsd51-baseboard.dtb
> +	imx51-eukrea-mbimxsd51-baseboard.dtb \
> +	imx51-ts4800.dtb
>  dtb-$(CONFIG_SOC_IMX53) += \
>  	imx53-ard.dtb \
>  	imx53-m53evk.dtb \
> diff --git a/arch/arm/boot/dts/imx51-ts4800.dts b/arch/arm/boot/dts/imx51-ts4800.dts
> new file mode 100644
> index 0000000..fac2058
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx51-ts4800.dts
> @@ -0,0 +1,190 @@
> +/*
> + * Copyright 2015 Savoir-faire Linux
> + *
> + * This device tree is based on imx51-babbage.dts
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx51.dtsi"
> +
> +/ {
> +	model = "Technologic Systems TS-4800";
> +	compatible = "technologic,imx51-ts4800", "fsl,imx51";
> +
> +	chosen {
> +		stdout-path = &uart1;
> +	};
> +
> +	memory {
> +		reg = <0x90000000 0x10000000>;
> +	};
> +
> +	soc {
> +		fpga {

For node with 'reg' property, it should be named in form of
name@unit-adderss.

> +			compatible = "simple-bus";
> +			reg = <0xb0000000 0x1d000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			syscon: syscon@b0010000 {
> +				compatible = "syscon", "simple-mfd";
> +				reg = <0xb0010000 0x3d>;
> +				bus-width = <16>;
> +
> +				wdt@e {
> +					compatible = "technologic,ts4800-wdt";
> +					syscon = <&syscon 0xe>;
> +				};
> +			};
> +		};
> +	};
> +
> +	clocks {
> +		ckih1 {
> +			clock-frequency = <22579200>;
> +		};
> +
> +		ckih2 {
> +			clock-frequency = <24576000>;
> +		};
> +	};
> +};
> +
> +&esdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_esdhc1>;
> +	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "mii";
> +	phy-reset-gpios = <&gpio2 14 GPIO_ACTIVE_LOW>;
> +	phy-reset-duration = <1>;
> +	status = "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&uart3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart3>;
> +	status = "okay";
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	status = "okay";
> +
> +	rtc: m41t00@68 {
> +		compatible = "stm,m41t00";
> +		reg = <0x68>;
> +	};
> +};

We generally sort device nodes alphabetically expect pin controller.
That said, &i2c2 should be put after &fec.

> +
> +
> +&iomuxc {
> +	imx51-ts4800 {

With commit 5fcdf6a7ed95 (pinctrl: imx: Allow parsing DT without function
nodes) in place, we should be able to save this level of node.

Shawn

> +
> +		pinctrl_ecspi1: ecspi1grp {
> +			fsl,pins = <
> +				MX51_PAD_CSPI1_MISO__ECSPI1_MISO	0x185
> +				MX51_PAD_CSPI1_MOSI__ECSPI1_MOSI	0x185
> +				MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK	0x185
> +				MX51_PAD_CSPI1_SS0__GPIO4_24		0x85 /* CS0 */
> +			>;
> +		};
> +
> +		pinctrl_esdhc1: esdhc1grp {
> +			fsl,pins = <
> +				MX51_PAD_SD1_CMD__SD1_CMD		0x400020d5
> +				MX51_PAD_SD1_CLK__SD1_CLK		0x20d5
> +				MX51_PAD_SD1_DATA0__SD1_DATA0		0x20d5
> +				MX51_PAD_SD1_DATA1__SD1_DATA1		0x20d5
> +				MX51_PAD_SD1_DATA2__SD1_DATA2		0x20d5
> +				MX51_PAD_SD1_DATA3__SD1_DATA3		0x20d5
> +				MX51_PAD_GPIO1_0__GPIO1_0		0x100
> +				MX51_PAD_GPIO1_1__GPIO1_1		0x100
> +			>;
> +		};
> +
> +		pinctrl_fec: fecgrp {
> +			fsl,pins = <
> +				MX51_PAD_EIM_EB2__FEC_MDIO		0x000001f5
> +				MX51_PAD_EIM_EB3__FEC_RDATA1		0x00000085
> +				MX51_PAD_EIM_CS2__FEC_RDATA2		0x00000085
> +				MX51_PAD_EIM_CS3__FEC_RDATA3		0x00000085
> +				MX51_PAD_EIM_CS4__FEC_RX_ER		0x00000180
> +				MX51_PAD_EIM_CS5__FEC_CRS		0x00000180
> +				MX51_PAD_DISP2_DAT10__FEC_COL		0x00000180
> +				MX51_PAD_DISP2_DAT11__FEC_RX_CLK		0x00000180
> +				MX51_PAD_DISP2_DAT14__FEC_RDATA0		0x00002180
> +				MX51_PAD_DISP2_DAT15__FEC_TDATA0		0x00002004
> +				MX51_PAD_NANDF_CS2__FEC_TX_ER		0x00002004
> +				MX51_PAD_DI2_PIN2__FEC_MDC		0x00002004
> +				MX51_PAD_DISP2_DAT6__FEC_TDATA1		0x00002004
> +				MX51_PAD_DISP2_DAT7__FEC_TDATA2		0x00002004
> +				MX51_PAD_DISP2_DAT8__FEC_TDATA3		0x00002004
> +				MX51_PAD_DISP2_DAT9__FEC_TX_EN		0x00002004
> +				MX51_PAD_DISP2_DAT13__FEC_TX_CLK	0x00002180
> +				MX51_PAD_DISP2_DAT12__FEC_RX_DV		0x000020a4
> +				MX51_PAD_EIM_A20__GPIO2_14		0x00000085 /* Phy Reset */
> +			>;
> +		};
> +
> +		pinctrl_i2c2: i2c2grp {
> +			fsl,pins = <
> +				MX51_PAD_KEY_COL4__I2C2_SCL		0x400001ed
> +				MX51_PAD_KEY_COL5__I2C2_SDA		0x400001ed
> +			>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX51_PAD_UART1_RXD__UART1_RXD		0x1c5
> +				MX51_PAD_UART1_TXD__UART1_TXD		0x1c5
> +				MX51_PAD_UART1_RTS__UART1_RTS		0x1c5
> +				MX51_PAD_UART1_CTS__UART1_CTS		0x1c5
> +			>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX51_PAD_UART2_RXD__UART2_RXD		0x1c5
> +				MX51_PAD_UART2_TXD__UART2_TXD		0x1c5
> +			>;
> +		};
> +
> +		pinctrl_uart3: uart3grp {
> +			fsl,pins = <
> +				MX51_PAD_EIM_D25__UART3_RXD		0x1c5
> +				MX51_PAD_EIM_D26__UART3_TXD		0x1c5
> +				MX51_PAD_EIM_D27__UART3_RTS		0x1c5
> +				MX51_PAD_EIM_D24__UART3_CTS		0x1c5
> +			>;
> +		};
> +
> +	};
> +};
> -- 
> 2.5.0
> 
> 
