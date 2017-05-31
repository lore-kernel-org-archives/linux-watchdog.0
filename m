Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33312 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbdEaUAY (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 May 2017 16:00:24 -0400
Date: Wed, 31 May 2017 15:00:21 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v3 05/16] watchdog: lantiq: add device tree binding
 documentation
Message-ID: <20170531200021.ld54cecme4ekak4i@rob-hp-laptop>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-6-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170528184006.31668-6-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, May 28, 2017 at 08:39:55PM +0200, Hauke Mehrtens wrote:
> The binding was not documented before, add the documentation now.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> new file mode 100644
> index 000000000000..675c30e23b65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> @@ -0,0 +1,28 @@
> +Lantiq WTD watchdog binding
> +============================
> +
> +This describes the binding of the Lantiq watchdog driver.
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,wdt"
> +				"lantiq,wdt-xrx100"
> +				"lantiq,wdt-falcon"
> +
> +Optional properties:
> +- regmap		: A phandle to the RCU syscon
> +- offset-status		: Offset of the reset cause register
> +- mask-status		: Mask of the reset cause register value

These 2 should be implied by the compatible. But if already used in 
upstream dts files, then it's okay.

> +
> +
> +-------------------------------------------------------------------------------
> +Example for the watchdog on the xRX200 SoCs:
> +		watchdog@803F0 {

Lowercase hex please.

> +			compatible = "lantiq,wdt-xrx200", "lantiq,wdt-xrx100";

Doesn't match the documentation.

> +			reg = <0x803F0 0x10>;

Lowercase hex please.

> +
> +			regmap = <&rcu0>;
> +			offset-status = <0x14>;
> +			mask-status = <0x80000000>;
> +		};
> -- 
> 2.11.0
> 
