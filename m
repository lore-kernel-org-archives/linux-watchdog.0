Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34849 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbdFWWM0 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Jun 2017 18:12:26 -0400
Date: Fri, 23 Jun 2017 17:12:24 -0500
From: Rob Herring <robh@kernel.org>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, andy.shevchenko@gmail.com,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v5 07/16] Documentation: DT: MIPS: lantiq: Add docs for
 the RCU bindings
Message-ID: <20170623221224.fhfc6ezydd3uglfr@rob-hp-laptop>
References: <20170620223743.13735-1-hauke@hauke-m.de>
 <20170620223743.13735-8-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620223743.13735-8-hauke@hauke-m.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 21, 2017 at 12:37:34AM +0200, Hauke Mehrtens wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> This adds the initial documentation for the RCU module (a MFD device
> which provides USB PHYs, reset controllers and more).
> 
> The RCU register range is used for multiple purposes. Mostly one device
> uses one or multiple register exclusively, but for some registers some
> bits are for one driver and some other bits are for a different driver.
> With this patch all accesses to the RCU registers will go through
> syscon.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  .../devicetree/bindings/mips/lantiq/rcu.txt        | 95 ++++++++++++++++++++++
>  1 file changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mips/lantiq/rcu.txt b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> new file mode 100644
> index 000000000000..9c875f4f3c90
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mips/lantiq/rcu.txt
> @@ -0,0 +1,95 @@
> +Lantiq XWAY SoC RCU binding
> +===========================
> +
> +This binding describes the RCU (reset controller unit) multifunction device,
> +where each sub-device has it's own set of registers.
> +
> +The RCU register range is used for multiple purposes. Mostly one device
> +uses one or multiple register exclusively, but for some registers some
> +bits are for one driver and some other bits are for a different driver.
> +With this patch all accesses to the RCU registers will go through
> +syscon.
> +
> +
> +-------------------------------------------------------------------------------
> +Required properties:
> +- compatible	: The first and second values must be:
> +		  "lantiq,xrx200-rcu", "simple-mfd", "syscon"
> +- reg		: The address and length of the system control registers
> +
> +
> +-------------------------------------------------------------------------------
> +Example of the RCU bindings on a xRX200 SoC:
> +	rcu0: rcu@203000 {
> +		compatible = "lantiq,xrx200-rcu", "simple-mfd", "syscon";
> +		reg = <0x203000 0x100>;
> +		ranges = <0x0 0x203000 0x100>;
> +		big-endian;
> +
> +		gphy0: gphy@0 {

unit address should match reg, so "phy@20"

> +			compatible = "lantiq,xrx200a2x-gphy";
> +			reg = <0x20 0x4>;
> +
> +			resets = <&reset0 31 30>, <&reset1 7 7>;
> +			reset-names = "gphy", "gphy2";
> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
> +		};
> +
> +		gphy1: gphy@1 {

phy@68

> +			compatible = "lantiq,xrx200a2x-gphy";
> +			reg = <0x68 0x4>;
> +
> +			resets = <&reset0 29 28>, <&reset1 6 6>;
> +			reset-names = "gphy", "gphy2";
> +			lantiq,gphy-mode = <GPHY_MODE_GE>;
> +		};
> +
> +		reset0: reset-controller@0 {

...@10

> +			compatible = "lantiq,xrx200-reset";
> +
> +			offset-set = <0x10>;
> +			offset-status = <0x14>;

reg = <0x10 8>;

> +			#reset-cells = <2>;
> +		};
> +
> +		reset1: reset-controller@1 {
> +			compatible = "lantiq,xrx200-reset";
> +
> +			offset-set = <0x48>;
> +			offset-status = <0x24>;

reg = <0x48 4>, <0x24 4>;

> +			#reset-cells = <2>;
> +		};
> +
> +		usb_phy0: usb2-phy@0 {
> +			compatible = "lantiq,xrx200-usb2-phy";
> +			status = "disabled";
> +
> +			regmap = <&rcu0>;

This should be dropped.

> +			offset-phy = <0x18>;
> +			offset-ana = <0x38>;

Use reg.

> +			resets = <&reset1 4 4>, <&reset0 4 4>;
> +			reset-names = "phy", "ctrl";
> +			#phy-cells = <0>;
> +		};
> +
> +		usb_phy1: usb2-phy@1 {
> +			compatible = "lantiq,xrx200-usb2-phy";
> +			status = "disabled";
> +
> +			regmap = <&rcu0>;

Drop.

> +			offset-phy = <0x34>;
> +			offset-ana = <0x3C>;

Use reg.

> +			resets = <&reset1 5 4>, <&reset0 4 4>;
> +			reset-names = "phy", "ctrl";
> +			#phy-cells = <0>;
> +		};
> +
> +		reboot {
> +			compatible = "syscon-reboot";
> +
> +			regmap = <&rcu0>;

Drop.

> +			offset = <0x10>;
> +			mask = <0x40000000>;
> +		};
> +	};
> +
> -- 
> 2.11.0
> 
