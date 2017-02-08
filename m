Return-path: <robherring2@gmail.com>
Date: Wed, 8 Feb 2017 15:48:57 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@savoirfairelinux.com, linux@roeck-us.net,
	linus.walleij@linaro.org, fabio.estevam@nxp.com,
	mark@embeddedarm.com, kris@embeddedarm.com,
	horms+renesas@verge.net.au, treding@nvidia.com,
	jonathanh@nvidia.com, f.fainelli@gmail.com, kernel@pengutronix.de,
	shawnguo@kernel.org, linux@armlinux.org.uk, wim@iguana.be,
	mark.rutland@arm.com, damien.riegel@savoirfairelinux.com,
	lucile.quirion@savoirfairelinux.com, olof@lixom.net, arnd@arndb.de,
	suzuki.poulose@arm.com, will.deacon@arm.com,
	yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 3/6] dt-bindings: bus: Add documentation for the
 Technologic Systems NBUS
Message-ID: <20170208214857.snplcpp55daa47so@rob-hp-laptop>
References: <20170203194729.20995-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170203194729.20995-4-sebastien.bourdelin@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203194729.20995-4-sebastien.bourdelin@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Feb 03, 2017 at 02:47:26PM -0500, Sebastien Bourdelin wrote:
> Add binding documentation for the Technologic Systems NBUS that is used
> to interface with peripherals in the FPGA of the TS-4600 SoM.
> 
> ---
> Changes v1 -> v2:
>   - rebase on master
>   - remove the simple-bus compatibility as the root node will now
>   populate child nodes (suggested by Rob Herring)
>   - use the ts vendor prefix for gpios (suggested by Rob Herring)
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
>  Documentation/devicetree/bindings/bus/ts-nbus.txt | 50 +++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/ts-nbus.txt b/Documentation/devicetree/bindings/bus/ts-nbus.txt
> new file mode 100644
> index 000000000000..c8a1f2cbe6a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ts-nbus.txt
> @@ -0,0 +1,50 @@
> +Technologic Systems NBUS
> +
> +The NBUS is a bus used to interface with peripherals in the Technologic
> +Systems FPGA on the TS-4600 SoM.
> +
> +Required properties :
> + - compatible     : "technologic,ts-nbus"
> + - #address-cells : must be 1
> + - #size-cells    : must be 0
> + - pws            : The PWM binded to the FPGA

Should be pwms?

s/binded/bound/

> + - data-gpios	  : The GPIO pin connected to the data line on the FPGA

lines? How many? Always 8 like the example?

> + - csn-gpios	  : The GPIO pin connected to the csn line on the FPGA
> + - txrx-gpios	  : The GPIO pin connected to the txrx line on the FPGA
> + - strobe-gpios	  : The GPIO pin connected to the stobe line on the FPGA
> + - ale-gpios	  : The GPIO pin connected to the ale line on the FPGA
> + - rdy-gpios	  : The GPIO pin connected to the rdy line on the FPGA
> +
> +Child nodes:
> +
> +The NBUS node can contain zero or more child nodes representing peripherals
> +on the bus.
> +
> +Example:
> +
> +	nbus {
> +		compatible = "technologic,ts-nbus";
> +		pinctrl-0 = <&nbus_pins>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pwms = <&pwm 2 83>;
> +		ts-data-gpios   = <&gpio0 0 GPIO_ACTIVE_HIGH
> +				   &gpio0 1 GPIO_ACTIVE_HIGH
> +				   &gpio0 2 GPIO_ACTIVE_HIGH
> +				   &gpio0 3 GPIO_ACTIVE_HIGH
> +				   &gpio0 4 GPIO_ACTIVE_HIGH
> +				   &gpio0 5 GPIO_ACTIVE_HIGH
> +				   &gpio0 6 GPIO_ACTIVE_HIGH
> +				   &gpio0 7 GPIO_ACTIVE_HIGH>;
> +		ts-csn-gpios    = <&gpio0 16 GPIO_ACTIVE_HIGH>;
> +		ts-txrx-gpios   = <&gpio0 24 GPIO_ACTIVE_HIGH>;
> +		ts-strobe-gpios = <&gpio0 25 GPIO_ACTIVE_HIGH>;
> +		ts-ale-gpios    = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> +		ts-rdy-gpios    = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +
> +		watchdog@2a {
> +			compatible = "...";
> +
> +			/* ... */
> +		};
> +	};
> -- 
> 2.11.0
> 
