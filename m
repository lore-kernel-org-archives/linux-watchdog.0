Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58880 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbG2PS2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 11:18:28 -0400
Date: Wed, 29 Jul 2015 08:18:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>
Cc: linux-watchdog@vger.kernel.org, wim@iguana.be,
	ezequiel@vanguardiasur.com.ar,
	linux-arm-kernel@lists.infradead.org, manabian@gmail.com
Subject: Re: [PATCH v4 2/2] DT: watchdog: Add NXP LPC18xx Watchdog Timer
 binding documentation
Message-ID: <20150729151825.GA23419@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jul 27, 2015 at 02:04:53AM -0300, Ariel D'Alessandro wrote:
> Add the devicetree binding document for NXP LPC18xx Watchdog Timer.
> 
> Signed-off-by: Ariel D'Alessandro <ariel@vanguardiasur.com.ar>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/lpc18xx-wdt.txt      | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
> new file mode 100644
> index 0000000..09f6b24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/lpc18xx-wdt.txt
> @@ -0,0 +1,19 @@
> +* NXP LPC18xx Watchdog Timer (WDT)
> +
> +Required properties:
> +- compatible: Should be "nxp,lpc1850-wwdt"
> +- reg: Should contain WDT registers location and length
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Should contain "wdtclk" and "reg"; the watchdog counter
> +               clock and register interface clock respectively.
> +- interrupts: Should contain WDT interrupt
> +
> +Examples:
> +
> +watchdog@40080000 {
> +	compatible = "nxp,lpc1850-wwdt";
> +	reg = <0x40080000 0x24>;
> +	clocks = <&cgu BASE_SAFE_CLK>, <&ccu1 CLK_CPU_WWDT>;
> +	clock-names = "wdtclk", "reg";
> +	interrupts = <49>;
> +};
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
