Return-path: <robh@kernel.org>
Date: Mon, 9 May 2016 15:38:31 -0500
From: Rob Herring <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>
Cc: linux@roeck-us.net, wim@iguana.be, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jk@ozlabs.org, benh@kernel.crashing.org, arnd@arndb.de
Subject: Re: [PATCH 1/2] doc/devicetree: Add Aspeed watchdog timer bindings
Message-ID: <20160509203831.GA20352@rob-hp-laptop>
References: <1462797277-14969-1-git-send-email-joel@jms.id.au>
 <1462797277-14969-2-git-send-email-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1462797277-14969-2-git-send-email-joel@jms.id.au>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, May 09, 2016 at 10:04:36PM +0930, Joel Stanley wrote:
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> new file mode 100644
> index 000000000000..58184b161e0d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
> @@ -0,0 +1,14 @@
> +Aspeed Watchdog Timer
> +
> +Required properties:
> + - compatible: must be "aspeed,wdt"

This should have the specific SOCs listed.

Rob

> + - reg: physical base address of the controller and length of memory mapped
> +   region
> +
> +Example:
> +
> +	wdt1: wdt@1e785000 {

IIRC, "watchdog@..." is the correct generic name.

> +		compatible = "aspeed,wdt";
> +		reg = <0x1e785000 0x1c>;
> +		interrupts = <27>;
> +	};
> -- 
> 2.8.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
