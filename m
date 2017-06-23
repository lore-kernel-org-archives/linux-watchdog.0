Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35372 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbdFWWFK (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Jun 2017 18:05:10 -0400
Date: Fri, 23 Jun 2017 17:05:08 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v5 05/16] watchdog: lantiq: add device tree binding
 documentation
Message-ID: <20170623220508.2kgxfadjeee76eqt@rob-hp-laptop>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-6-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620223743.13735-6-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 21, 2017 at 12:37:32AM +0200, Hauke Mehrtens wrote:
> The binding was not documented before, add the documentation now.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/watchdog/lantiq-wdt.txt    | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> new file mode 100644
> index 000000000000..1d41142ca55f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/lantiq-wdt.txt
> @@ -0,0 +1,22 @@
> +Lantiq WTD watchdog binding
> +============================
> +
> +This describes the binding of the Lantiq watchdog driver.
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible		: Should be one of
> +				"lantiq,wdt"
> +				"lantiq,xrx100-wdt"
> +				"lantiq,falcon-wdt"
> +- regmap		: A phandle to the RCU syscon (required for
> +			  "lantiq,falcon-wdt" and "lantiq,xrx100-wdt")

regmap is a Linuxism. I'd suggest "lantiq,rcu" instead.

> +
> +-------------------------------------------------------------------------------
> +Example for the watchdog on the xRX200 SoCs:
> +		watchdog@803f0 {
> +			compatible = "lantiq,xrx100-wdt";

Why did you remove the xrx200 compatible? You should add it to the 
compatible list (with the fallback).

> +			reg = <0x803f0 0x10>;
> +
> +			regmap = <&rcu0>;
> +		};
> -- 
> 2.11.0
> 
