Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34819 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751125AbdEaU6I (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 31 May 2017 16:58:08 -0400
Date: Wed, 31 May 2017 15:58:06 -0500
From: Rob Herring <robh@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org,
        linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v3 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
Message-ID: <20170531205806.uohn2tr6qtrocpl6@rob-hp-laptop>
References: <20170528184006.31668-1-hauke@hauke-m.de>
 <20170528184006.31668-11-hauke@hauke-m.de>
 <1496053214.17695.49.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1496053214.17695.49.camel@pengutronix.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 29, 2017 at 12:20:14PM +0200, Philipp Zabel wrote:
> Hi Hauke,
> 
> On Sun, 2017-05-28 at 20:40 +0200, Hauke Mehrtens wrote:
> [...]
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/reset/lantiq,reset.txt
> > @@ -0,0 +1,30 @@
> > +Lantiq XWAY SoC RCU reset controller binding
> > +============================================
> > +
> > +This binding describes a reset-controller found on the RCU module on Lantiq
> > +XWAY SoCs.
> > +
> > +
> > +-------------------------------------------------------------------------------
> > +Required properties:
> > +- compatible		: Should be one of
> > +				"lantiq,reset-danube"
> > +				"lantiq,reset-xrx200"
> > +- regmap		: A phandle to the RCU syscon
> > +- offset-set		: Offset of the reset set register
> > +- offset-status		: Offset of the reset status register
> > +- #reset-cells		: Specifies the number of cells needed to encode the
> > +			  reset line, should be 2.
> > +			  The first cell takes the reset set bit and the
> > +			  second cell takes the status bit.
> > +
> > +-------------------------------------------------------------------------------
> > +Example for the reset-controllers on the xRX200 SoCs:
> > +	reset0: reset-controller@0 {
> > +		compatible = "lantiq,reset-xrx200";
> > +
> > +		regmap = <&rcu0>;
> 
> Why not place these nodes as children of &rcu0 ? This property would be
> superfluous then.

They are children. So it should be removed and made clear that these are 
child nodes of rcu (here and in other patches in this series).

Rob
