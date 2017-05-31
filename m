Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35544 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdEaUyk (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 May 2017 16:54:40 -0400
Date: Wed, 31 May 2017 15:54:39 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v3 08/16] MIPS: lantiq: Convert the fpi bus driver to a
 platform_driver
Message-ID: <20170531205439.l5fiatf4v3kp43yq@rob-hp-laptop>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-9-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170528184006.31668-9-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, May 28, 2017 at 08:39:58PM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/fpi-bus.txt    | 33 ++++++++
>  MAINTAINERS                                        |  1 +
>  arch/mips/lantiq/xway/reset.c                      |  4 -
>  arch/mips/lantiq/xway/sysctrl.c                    | 41 ----------
>  drivers/soc/Makefile                               |  1 +
>  drivers/soc/lantiq/Makefile                        |  1 +
>  drivers/soc/lantiq/fpi-bus.c                       | 91 ++++++++++++++++++++++
>  7 files changed, 127 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/fpi-bus.c
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
> new file mode 100644
> index 000000000000..52d4bb9d2ffa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
> @@ -0,0 +1,33 @@
> +Lantiq XWAY SoC FPI BUS binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be one of
> +				"lantiq,fpi-xrx200"
> +- reg		: The address and length of the XBAR configuration register.
> +		  Address and length of the FPI bus itself
> +
> +Optional properties:
> +- regmap		: A phandle to the RCU syscon
> +- offset-endianness	: Offset of the endianness configuration register
> +
> +
> +-------------------------------------------------------------------------------
> +Example for the FPI on the xrx200 SoCs:
> +	fpi@10000000 {
> +		compatible = "lantiq,fpi-xrx200", "simple-bus";
> +		ranges = <0x0 0x10000000 0xF000000>;

lowercase hex please.

> +		reg =	<0x1F400000 0x1000>,
> +			<0x10000000 0xF000000>;
> +		regmap = <&rcu0>;
> +		offset-endianness = <0x4c>;

Presumably, this is for endianness of the children. So this needs to be 
configured before probing the children. If so, then you should not call 
this a "simple-bus".

> +		big-endian;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		gptu@E100A00 {

lowercase hex.

> +			......
> +		};
> +	};
