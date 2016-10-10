Return-path: <robherring2@gmail.com>
Date: Mon, 10 Oct 2016 12:38:24 -0500
From: Rob Herring <robh@kernel.org>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Lee Jones <lee.jones@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>, Peter Rosin <peda@axentia.se>,
	Debjit Ghosh <dghosh@juniper.net>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <groeck@juniper.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 02/10] mfd: ptxpmb-cpld: Add documentation for PTXPMB CPLD
Message-ID: <20161010173824.GA3245@rob-hp-laptop>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1475853451-22121-3-git-send-email-pantelis.antoniou@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475853451-22121-3-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Oct 07, 2016 at 06:17:23PM +0300, Pantelis Antoniou wrote:
> From: Georgi Vlaev <gvlaev@juniper.net>
> 
> Add DT bindings document for the PTXPMB CPLD MFD device.
> 
> Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
> [Ported from Juniper kernel]
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> ---
>  .../devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt    | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt b/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
> new file mode 100644
> index 0000000..cc3cbb9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/jnx-ptxpmb-cpld.txt
> @@ -0,0 +1,76 @@
> +* Device tree bindings for Juniper's PTXPMB CPLD FPGA MFD driver
> +
> +The device supports a number I2C muxes, hardware watchdog and a gpio block.
> +Those devices bindings are described in the jnx-i2c-mux-ptxpmb-cpld,
> +jnx-ptxpmb-wdt and jnx-gpio-ptxpmb-cpld documents.
> +
> +Required properties:
> +
> +- compatible:		"jnx,ptxpmb-cpld", "jnx,ngpmb-bcpld". They differ

bcpld? looks like a typo?

> +			in the i2c-mux blocks.
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
> +cpld@0,0 {

What bus is this on? If just simple-bus, then just '...@0'

> +	compatible = "jnx,ptxpmb-cpld";
> +	reg = <0x0 0 0x10000>;
