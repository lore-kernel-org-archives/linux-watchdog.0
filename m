Return-path: <robherring2@gmail.com>
Date: Mon, 10 Oct 2016 15:07:04 -0500
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
	Florian Fainelli <f.fainelli@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>, Peter Rosin <peda@axentia.se>,
	Debjit Ghosh <dghosh@juniper.net>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Maryam Seraj <mseraj@juniper.net>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-watchdog@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 08/10] mtd: flash-sam: Bindings for Juniper's SAM FPGA
 flash
Message-ID: <20161010200704.GA28870@rob-hp-laptop>
References: <1475853518-22264-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1475853518-22264-9-git-send-email-pantelis.antoniou@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475853518-22264-9-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

gOn Fri, Oct 07, 2016 at 06:18:36PM +0300, Pantelis Antoniou wrote:
> From: Georgi Vlaev <gvlaev@juniper.net>
> 
> Add binding document for Junipers Flash IP block present
> in the SAM FPGA on PTX series of routers.
> 
> Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
> [Ported from Juniper kernel]
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> ---
>  .../devicetree/bindings/mtd/flash-sam.txt          | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/flash-sam.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/flash-sam.txt b/Documentation/devicetree/bindings/mtd/flash-sam.txt
> new file mode 100644
> index 0000000..bdf1d78
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/flash-sam.txt
> @@ -0,0 +1,31 @@
> +Flash device on a Juniper SAM FPGA
> +
> +These flash chips are found in the PTX series of Juniper routers.
> +
> +They are regular CFI compatible (Intel or AMD extended) flash chips with
> +some special write protect/VPP bits that can be controlled by the machine's
> +system controller.

And where's the description of the sys ctrlr?

> +
> +Required properties:
> +- compatible : must be "jnx,flash-sam"
> +
> +Optional properties:
> +- reg : memory address for the flash chip, note that this is not
> +required since usually the device is a subdevice of the SAM MFD
> +driver which fills in the register fields.
> +
> +For the rest of the properties, see mtd-physmap.txt.
> +
> +The device tree may optionally contain sub-nodes describing partitions of the
> +address space. See partition.txt for more detail.
> +
> +Example:
> +
> +flash_sam {
> +	compatible = "jnx,flash-sam";
> +	partition@0 {

This should have a heirarchy of a controller node, a flash child node, 
partitions child node, and partition child nodes.

> +		reg = <0x0 0x400000>;
> +		label = "pic0-golden";
> +		read-only;
> +	};
> +};
> -- 
> 1.9.1
> 
