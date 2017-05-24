Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42029 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933143AbdEXNLB (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 24 May 2017 09:11:01 -0400
Message-ID: <1495631452.3840.27.camel@pengutronix.de>
Subject: Re: [PATCH v2 09/15] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, martin.blumenstingl@googlemail.com,
        john@phrozen.org, linux-spi@vger.kernel.org,
        hauke.mehrtens@intel.com, robh@kernel.org
Date: Wed, 24 May 2017 15:10:52 +0200
In-Reply-To: <2f809dc7-53c6-ebf9-53c1-466bf34e39db@hauke-m.de>
References: <20170521130918.27446-1-hauke@hauke-m.de>
         <20170521130918.27446-10-hauke@hauke-m.de>
         <1495445613.3558.67.camel@pengutronix.de>
         <2f809dc7-53c6-ebf9-53c1-466bf34e39db@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 2017-05-23 at 23:25 +0200, Hauke Mehrtens wrote:
> On 05/22/2017 11:33 AM, Philipp Zabel wrote:
> > Hi Hauke,
> > 
> > thank you for the patch. I have a few questions and comments below:
> > 
> > On Sun, 2017-05-21 at 15:09 +0200, Hauke Mehrtens wrote:
> >> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >>
> >> The reset controllers (on xRX200 and newer SoCs have two of them) are
> >> provided by the RCU module. This was initially implemented as a simple
> >> reset controller. However, the RCU module provides more functionality
> >> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> >> The old reset controller driver implementation from
> >> arch/mips/lantiq/xway/reset.c did not honor this fact.
> > 
> > Does this driver replace arch/mips/lantiq/xway/reset.c?
> 
> This serial consists of multiple patches which are all together
> replacing this code. The RCU register block does controls multiple
> blocks in the SoC. One is the reset controller, but also the GPHY FW
> loading and some other unrelated stuff.

Thank you for clarifying.

> >> +		compatible = "lantiq,rcu-reset";
> >> +		lantiq,rcu-syscon = <&rcu0 0x10 0x14>;
> >> +		#reset-cells = <2>;
> >> +	};
> >> +
> >> +	rcu_reset1: rcu_reset {
> >> +		compatible = "lantiq,rcu-reset";
> >> +		lantiq,rcu-syscon = <&rcu0 0x48 0x24>;
> >> +		#reset-cells = <2>;
> >> +	};
> > 
> > I think these should be children of the &rcu0 node. Then you could use
> > the reg property to specify the registers.
> 
> The problem is that the RCU registers at offset 0x10 and 0x14 also have
> bits to indicate what caused the last hardware reset and which boot mode
> was selected by putting some pins to low or high level. I want to access
> the same register from the watchdog driver and probably form more
> positions which do not have anything to do with a reset controller.

That is ok, I just suggest to get the syscon regmap not from a phandle
property, but from the node parent. The reset controller is a part of
the RCU.

> > Also, have you considered using a binding like the ti-syscon-reset? 
> > That could remove the need for a rcu_reset node per register pair
> > altogether, but might not make sense if the reset registers are densely
> > populated.
> 
> Would your suggestion be something like this?
> 
> rcu_reset0: reset-controller {
> 	compatible = "lantiq,rcu-reset";
> 	lantiq,rcu-syscon = <&rcu0>;
> 	#reset-cells = <2>;
> 	ti,reset-bits = <
> 		0x48 0x24
> 		0x10 0x14
> 	>;
> };

Yes, for example. I'd put the reset-controller node inside the &rcu0
node and drop the lantiq,rcu-syscon property, though.

> I prefer to have two device tree nodes entries for these two register
> blocks.

If Rob is fine with this, I won't object. I'd just be interested to know
why.

regards
Philipp

