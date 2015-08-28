Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36419 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbH1BCL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 27 Aug 2015 21:02:11 -0400
Date: Thu, 27 Aug 2015 18:02:07 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Justin Chen <justinpopo6@gmail.com>
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	devicetree@vger.kernel.org, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v2 1/2] watchdog: bcm7038: add device tree binding
 documentation
Message-ID: <20150828010207.GB5597@roeck-us.net>
References: <1440716004-27022-1-git-send-email-justinpopo6@gmail.com>
 <1440716004-27022-2-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1440716004-27022-2-git-send-email-justinpopo6@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Aug 27, 2015 at 03:53:23PM -0700, Justin Chen wrote:
> Add device tree binding documentation for the watchdog hardware block
> on bcm7038 and newer SoCs.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
> new file mode 100644
> index 0000000..39e5cf5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/brcm,bcm7038-wdt.txt
> @@ -0,0 +1,19 @@
> +BCM7038 Watchdog timer
> +
> +Required properties:
> +
> +- compatible : should be "brcm,bcm7038-wdt"
> +- reg : Specifies base physical address and size of the registers.
> +
> +Optional properties:
> +
> +- clocks: The clock running the watchdog. If no clock is found the
> +	  driver will default to 27000000 HZ.
> +
> +Example:
> +
> +watchdog {
> +	compatible = "brcm,bcm7038-wdt";
> +	clocks = <&upg_fixed>;
> +	reg = <0xf040a7e8 0x16>;
> +};
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
