Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33212 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753849AbdFWWPd (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Jun 2017 18:15:33 -0400
Date: Fri, 23 Jun 2017 17:15:31 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v5 08/16] MIPS: lantiq: Convert the fpi bus driver to a
 platform_driver
Message-ID: <20170623221531.o5vvuoobwjvokjms@rob-hp-laptop>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-9-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620223743.13735-9-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 21, 2017 at 12:37:35AM +0200, Hauke Mehrtens wrote:
> Instead of hacking the configuration of the FPI bus into the arch code
> add an own bus driver for this internal bus. The FPI bus is the main
> bus of the SoC. This bus driver makes sure the bus is configured
> correctly before the child drivers are getting initialized. This driver
> will probably also be used on different SoC later.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../devicetree/bindings/mips/lantiq/fpi-bus.txt    | 31 ++++++++
>  MAINTAINERS                                        |  1 +
>  arch/mips/lantiq/xway/reset.c                      |  4 -
>  arch/mips/lantiq/xway/sysctrl.c                    | 41 -----------
>  drivers/soc/Makefile                               |  1 +
>  drivers/soc/lantiq/Makefile                        |  1 +
>  drivers/soc/lantiq/fpi-bus.c                       | 85 ++++++++++++++++++++++
>  7 files changed, 119 insertions(+), 45 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
>  create mode 100644 drivers/soc/lantiq/Makefile
>  create mode 100644 drivers/soc/lantiq/fpi-bus.c
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
> new file mode 100644
> index 000000000000..80555b76fd34
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/fpi-bus.txt
> @@ -0,0 +1,31 @@
> +Lantiq XWAY SoC FPI BUS binding
> +============================
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: Should be one of
> +				"lantiq,xrx200-fpi"
> +- reg		: The address and length of the XBAR configuration register.
> +		  Address and length of the FPI bus itself
> +
> +Optional properties:
> +- regmap		: A phandle to the RCU syscon

"lantiq,rcu" instead.

> +- offset-endianness	: Offset of the endianness configuration register

lantiq,offset-endianness

> +
> +-------------------------------------------------------------------------------
> +Example for the FPI on the xrx200 SoCs:
> +	fpi@10000000 {
> +		compatible = "lantiq,xrx200-fpi", "simple-bus";

Drop simple-bus.

> +		ranges = <0x0 0x10000000 0xf000000>;
> +		reg =	<0x1f400000 0x1000>,
> +			<0x10000000 0xf000000>;
> +		regmap = <&rcu0>;
> +		offset-endianness = <0x4c>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		gptu@e100a00 {
> +			......
> +		};
> +	};
