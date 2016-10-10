Return-path: <robherring2@gmail.com>
Date: Mon, 10 Oct 2016 12:41:18 -0500
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
Subject: Re: [PATCH 04/10] watchdog: ptxpmb-wdt: Add ptxpmb-wdt device tree
 bindings
Message-ID: <20161010174117.GA16611@rob-hp-laptop>
References: <1475853451-22121-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1475853451-22121-5-git-send-email-pantelis.antoniou@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475853451-22121-5-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Oct 07, 2016 at 06:17:25PM +0300, Pantelis Antoniou wrote:
> From: Georgi Vlaev <gvlaev@juniper.net>
> 
> Add binding document for the watchdog driver of PTXPMB CPLD.
> 
> Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
> [Ported from Juniper kernel]
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> ---
>  .../devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt     | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt b/Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt
> new file mode 100644
> index 0000000..34b64f6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/jnx-ptxpmb-wdt.txt
> @@ -0,0 +1,17 @@
> +Juniper's PTXPMB FPGA watchdog driver
> +
> +Required properties:
> +
> +- compatible:	Should be "jnx,ptxpmb-wdt"
> +
> +Optional properties:
> +
> +- reg : Specifies base physical address and size of the registers. It is
> +  optional since the MFD parent driver supplies it, but can be overridden.

What the driver does is irrelevant. It should be required or there's no 
point to have the node. If the parent knows the address, then it knows 
the type of device too and DT is not needed.

> +
> +Example:
> +
> +wdt {

s/wdt/watchdog/

> +	compatible = "jnx,ptxpmb-wdt";
> +	/* no properties defined */
> +};
> -- 
> 1.9.1
> 
