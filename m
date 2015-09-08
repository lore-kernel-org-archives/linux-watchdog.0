Return-path: <robherring2@gmail.com>
Sender: Rob Herring <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2 v3] watchdog: bcm7038: add device tree binding
 documentation
To: Justin Chen <justinpopo6@gmail.com>, linux-kernel@vger.kernel.org
References: <1441734348-11138-1-git-send-email-justinpopo6@gmail.com>
 <1441734348-11138-2-git-send-email-justinpopo6@gmail.com>
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@roeck-us.net,
 devicetree@vger.kernel.org, wim@iguana.be, linux-watchdog@vger.kernel.org,
 bcm-kernel-feedback-list@broadcomc.com
Message-ID: <55EF6946.7080108@kernel.org>
Date: Tue, 8 Sep 2015 18:03:34 -0500
MIME-Version: 1.0
In-Reply-To: <1441734348-11138-2-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On 09/08/2015 12:45 PM, Justin Chen wrote:
> Add device tree binding documentation for the watchdog hardware block
> on bcm7038 and newer SoCs.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> Acked-by: Guenter Roeck <linux@roeck-us.net>

Some minor comments, otherwise:

Acked-by: Rob Herring <robh@kernel.org>


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

s/HZ/Hz/

> +
> +Example:
> +
> +watchdog {

This should have a unit address (watchdog@f040a7e8).

> +	compatible = "brcm,bcm7038-wdt";
> +	clocks = <&upg_fixed>;
> +	reg = <0xf040a7e8 0x16>;
> +};
> 
