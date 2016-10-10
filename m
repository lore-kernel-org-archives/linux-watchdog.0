Return-path: <f.fainelli@gmail.com>
Subject: Re: [PATCH 10/10] net: mdio-sam: Add device tree documentation for
 SAM MDIO
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 Lee Jones <lee.jones@linaro.org>
References: <1475853518-22264-1-git-send-email-pantelis.antoniou@konsulko.com>
 <1475853518-22264-11-git-send-email-pantelis.antoniou@konsulko.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Alexandre Courbot <gnurou@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Frank Rowand <frowand.list@gmail.com>,
 Wolfram Sang <wsa@the-dreams.de>, David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>, Wim Van Sebroeck
 <wim@iguana.be>, Peter Rosin <peda@axentia.se>,
 Debjit Ghosh <dghosh@juniper.net>, Georgi Vlaev <gvlaev@juniper.net>,
 Guenter Roeck <linux@roeck-us.net>, Maryam Seraj <mseraj@juniper.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
 netdev@vger.kernel.org
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <1b764238-1094-dcbc-1176-fdc845781c31@gmail.com>
Date: Mon, 10 Oct 2016 01:50:07 -0700
MIME-Version: 1.0
In-Reply-To: <1475853518-22264-11-git-send-email-pantelis.antoniou@konsulko.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>



On 10/07/2016 08:18 AM, Pantelis Antoniou wrote:
> From: Georgi Vlaev <gvlaev@juniper.net>
> 
> Add device tree bindings document for the SAM MDIO block
> present in Juniper's SAM FPGA.
> 
> Signed-off-by: Georgi Vlaev <gvlaev@juniper.net>
> [Ported from Juniper kernel]
> Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
> ---
>  Documentation/devicetree/bindings/net/mdio-sam.txt | 48 ++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/mdio-sam.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mdio-sam.txt b/Documentation/devicetree/bindings/net/mdio-sam.txt
> new file mode 100644
> index 0000000..7d354e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mdio-sam.txt
> @@ -0,0 +1,48 @@
> +Juniper SAM FPGA MFD MDIO bus properties.
> +
> +Required properties:
> +- compatible : "jnx,mdio-sam"
> +- reg : The start offset of the MDIO bus range
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +
> +Optional properties:
> +
> +Required properties for child nodes:
> +- #address-cells = <1>;
> +- #size-cells = <0>;
> +- reg : The MDIO bus offset within the MDIO range.

I would just refer to Documentation/devicetree/bindings/net/phy.txt for
the child node properties.

Other than that:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
