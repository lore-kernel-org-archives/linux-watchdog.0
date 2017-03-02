Return-path: <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: r7s72100: Add watchdog timer
To: Chris Brandt <chris.brandt@renesas.com>, Wim Van Sebroeck
 <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <20170301225455.22818-1-chris.brandt@renesas.com>
 <20170301225455.22818-4-chris.brandt@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-watchdog@vger.kernel.org
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <3944a62e-b061-eb4b-5351-da155a68852e@cogentembedded.com>
Date: Thu, 2 Mar 2017 12:08:40 +0300
MIME-Version: 1.0
In-Reply-To: <20170301225455.22818-4-chris.brandt@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello!

On 3/2/2017 1:54 AM, Chris Brandt wrote:

> Add watchdog timer support for RZ/A1.
> For the RZ/A1, the only way to do a reset is to overflow the WDT, so this
> is useful even if you don't need the watchdog functionality.
>
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
> * added Reviewed-by
> v2:
> * changed "renesas,r7s72100-reset" to "renesas,r7s72100-wdt"
> * changed "renesas,wdt-reset" to "renesas,rza-wdt"
> * added interupt property (even though it is not used)
> * added clocks property
> ---
>  arch/arm/boot/dts/r7s72100.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
> index ed62e19..6ecee72 100644
> --- a/arch/arm/boot/dts/r7s72100.dtsi
> +++ b/arch/arm/boot/dts/r7s72100.dtsi
> @@ -382,6 +382,13 @@
>  		cache-level = <2>;
>  	};
>
> +	wdt: timer@fcfe0000 {

    Why not watchdog@...? That name is standardized in ePAPR...

> +		compatible = "renesas,r7s72100-wdt", "renesas,rza-wdt";
> +		reg = <0xfcfe0000 0x6>;
> +		interrupts = <GIC_SPI 106 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&p0_clk>;
> +	};
> +
[...]

MBR, Sergei
