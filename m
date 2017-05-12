Return-path: <robherring2@gmail.com>
Date: Fri, 12 May 2017 10:17:11 -0500
From: Rob Herring <robh@kernel.org>
To: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	kernel@savoirfairelinux.com, linux@roeck-us.net,
	linus.walleij@linaro.org, shawnguo@kernel.org,
	fabio.estevam@nxp.com, mark@embeddedarm.com, kris@embeddedarm.com
Subject: Re: [PATCH v3 3/6] dt-bindings: bus: Add documentation for the
 Technologic Systems NBUS
Message-ID: <20170512151711.plggiqffktsa3xuv@rob-hp-laptop>
References: <20170505193259.16517-1-sebastien.bourdelin@savoirfairelinux.com>
 <20170505193259.16517-4-sebastien.bourdelin@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170505193259.16517-4-sebastien.bourdelin@savoirfairelinux.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, May 05, 2017 at 03:32:56PM -0400, Sebastien Bourdelin wrote:
> Add binding documentation for the Technologic Systems NBUS that is used
> to interface with peripherals in the FPGA of the TS-4600 SoM.
> 
> Signed-off-by: Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
> ---
> Changes v2 -> v3:
>   - rebase on master
>   - fix typo (suggested by Rob Herring)
> 
> Changes v1 -> v2:
>   - rebase on master
>   - remove the simple-bus compatibility as the root node will now
>   populate child nodes (suggested by Rob Herring)
>   - use the ts vendor prefix for gpios (suggested by Rob Herring)
> ---
>  Documentation/devicetree/bindings/bus/ts-nbus.txt | 50 +++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/ts-nbus.txt b/Documentation/devicetree/bindings/bus/ts-nbus.txt
> new file mode 100644
> index 000000000000..905600adfb64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ts-nbus.txt
> @@ -0,0 +1,50 @@
> +Technologic Systems NBUS
> +
> +The NBUS is a bus used to interface with peripherals in the Technologic
> +Systems FPGA on the TS-4600 SoM.
> +
> +Required properties :
> + - compatible		: "technologic,ts-nbus"
> + - #address-cells	: must be 1
> + - #size-cells		: must be 0
> + - pwms			: The PWM bound to the FPGA
> + - ts-data-gpios	: The 8 GPIO pins connected to the data lines on the FPGA
> + - ts-csn-gpios		: The GPIO pin connected to the csn line on the FPGA
> + - ts-txrx-gpios	: The GPIO pin connected to the txrx line on the FPGA
> + - ts-strobe-gpios	: The GPIO pin connected to the stobe line on the FPGA
> + - ts-ale-gpios		: The GPIO pin connected to the ale line on the FPGA
> + - ts-rdy-gpios		: The GPIO pin connected to the rdy line on the FPGA

Vendor prefixes are in the form <vendor>,<propname>. So ts,rdy-gpios.

Rob
