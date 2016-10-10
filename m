Return-path: <robherring2@gmail.com>
Date: Mon, 10 Oct 2016 15:10:31 -0500
From: Rob Herring <robh@kernel.org>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] mfd: ptxpmb-ext-cpld: Add documentation for PTXPMB
 extended CPLD
Message-ID: <20161010201031.GA31318@rob-hp-laptop>
References: <1475853574-22339-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1475853574-22339-3-git-send-email-pantelis.antoniou@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475853574-22339-3-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Oct 07, 2016 at 06:19:32PM +0300, Pantelis Antoniou wrote:
> From: Georgi Vlaev <gvlaev@juniper.net>
> 
> Add DT bindings document for the PTXPMB extended CPLD device.
> 
> Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
> [Ported from Juniper kernel]
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> ---
>  .../bindings/mfd/jnx-ptxpmb-ext-cpld.txt           | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/jnx-ptxpmb-ext-cpld.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-ext-cpld.txt b/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-ext-cpld.txt
> new file mode 100644
> index 0000000..098a548a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-ext-cpld.txt
> @@ -0,0 +1,35 @@
> +* Device tree bindings for Juniper's PTXPMB Extended CPLD FPGA MFD driver
> +
> +The device supports a gpio block which is described in the
> +jnx-gpio-ptxpmb-ext-cpld document.
> +
> +Required properties:
> +
> +- compatible:		"jnx,ptxpmb-ext-cpld"
> +
> +- reg:			contains offset/length value for device state control
> +			registers space.
> +
> +Optional properties:
> +
> +- interrupts:		The interrupt line(s) the /IRQ signal(s) for the device is
> +			connected to.
> +
> +- interrupt-parent:	The parent interrupt controller.
> +
> +Example:
> +
> +ext-cpld@1,0 {
> +	compatible = "jnx,ptxpmb-ext-cpld";
> +	reg = <0x1 0 0x1000>;

What's the bus type here? Unit address is probably wrong.

> +	interrupt-parent = <&mpic>;
> +	interrupts = <7 2>, <8 2>;
> +
> +	gpio_ext_cpld: cpld-ext-gpio {
> +		compatible = "jnx,gpio-ptxpmb-ext-cpld";
> +		#gpio-cells = <2>;
> +		#interrupt-cells = <2>;
> +		gpio-controller;
> +		interrupt-controller;
> +	};
> +};
> -- 
> 1.9.1
> 
