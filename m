Return-Path: <mark.rutland@arm.com>
Date: Mon, 21 Oct 2013 12:05:33 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: "dinguyen@altera.com" <dinguyen@altera.com>
Cc: "dinh.linux@gmail.com" <dinh.linux@gmail.com>,
   Guenter Roeck <linux@roeck-us.net>, Jamie Iles <jamie@jamieiles.com>,
   Viresh Kumar <viresh.linux@gmail.com>, Wim Van Sebroeck <wim@iguana.be>,
   Pavel Machek <pavel@denx.de>,
   "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
   Pawel Moll <Pawel.Moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>,
   Ian Campbell <ian.campbell@citrix.com>,
   "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
   "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
Subject: Re: [RESEND PATCHv2] watchdog: dw: Enable OF support for DW watchdog
 timer.
Message-ID: <20131021110532.GA8144@kartoffel>
References: <1380739472-26172-1-git-send-email-dinguyen@altera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1380739472-26172-1-git-send-email-dinguyen@altera.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Oct 02, 2013 at 07:44:32PM +0100, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Add device tree support to the DW watchdog timer.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jamie Iles <jamie@jamieiles.com>
> Cc: Viresh Kumar <viresh.linux@gmail.com>
> Cc: Wim Van Sebroeck <wim@iguana.be>
> Cc: Pavel Machek <pavel@denx.de>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-watchdog@vger.kernel.org
> ---
> v2:
> - Use of_match_ptr() for of_match_table
> ---
>  .../devicetree/bindings/watchdog/dw_wdt.txt        |   16 ++++++++++++++++
>  drivers/watchdog/dw_wdt.c                          |    8 ++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/dw_wdt.txt b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> new file mode 100644
> index 0000000..29e150b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/dw_wdt.txt
> @@ -0,0 +1,16 @@
> +Synopsys Designware Watchdog Timer
> +
> +Required Properties:
> +
> +- Compatiblity	: "snps,dw-wdt"

This should presumably be:

- compatbile: should contain "snps,dw-wdt"

> +- reg		: Base address of the watchdog timer register.

And the size...

> +
> +Example:
> +
> +	watchdog0: wd@ffd02000 {
> +		compatible = "snps,dw-wdt";
> +		reg = <0xffd02000 0x1000>;
> +		interrupts = <0 171 4>;

This wasn't mentioned.

Is it necessary?

Is it the only interrupt?

> +		clocks = <&per_base_clk>;

Similarly, is this the only clock?

Is it necessary?

> +		status = "okay";

This is unnecessary.

Thanks,
Mark.
