Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:55493 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751879AbdGDIap (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 4 Jul 2017 04:30:45 -0400
Message-ID: <1499157009.4045.4.camel@pengutronix.de>
Subject: Re: [PATCH v7 10/16] reset: Add a reset controller driver for the
 Lantiq XWAY based SoCs
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        "martin.blumenstingl" <martin.blumenstingl@googlemail.com>,
        john <john@phrozen.org>, linux-spi <linux-spi@vger.kernel.org>,
        "hauke.mehrtens" <hauke.mehrtens@intel.com>,
        Rob Herring <robh@kernel.org>
Date: Tue, 04 Jul 2017 10:30:09 +0200
In-Reply-To: <e1160f30-eeff-3db2-884c-9cd4af35a37d@hauke-m.de>
References: <20170702224051.15109-1-hauke@hauke-m.de>
         <20170702224051.15109-11-hauke@hauke-m.de>
         <CAHp75VexwnVsb-ojXaZDN7QPVRKUeP-R=5C+j5ZSkE37Dtyp1Q@mail.gmail.com>
         <e1160f30-eeff-3db2-884c-9cd4af35a37d@hauke-m.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, 2017-07-03 at 23:30 +0200, Hauke Mehrtens wrote:
> On 07/03/2017 09:51 AM, Andy Shevchenko wrote:
> > On Mon, Jul 3, 2017 at 1:40 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> >> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> >>
> >> The reset controllers (on xRX200 and newer SoCs have two of them) are
> >> provided by the RCU module. This was initially implemented as a simple
> >> reset controller. However, the RCU module provides more functionality
> >> (ethernet GPHYs, USB PHY, etc.), which makes it a MFD device.
> >> The old reset controller driver implementation from
> >> arch/mips/lantiq/xway/reset.c did not honor this fact.
> >>
> >> For some devices the request and the status bits are different.
> > 
> >> +Required properties:
> >> +- compatible           : Should be one of
> >> +                               "lantiq,danube-reset"
> >> +                               "lantiq,xrx200-reset"
> >> +- offset-set           : Offset of the reset set register
> >> +- offset-status                : Offset of the reset status register
> > 
> > Just one side comment (I'm fine with either choice, just for your
> > information). Recently I have reviewed at24 patch which adds a
> > property for getting MAC offset and my reseach ends up with the naming
> > pattern mac-offset (as many others are doing this way). So, perhaps in
> > your case it might make sense to do that way? Anyway, it's a matter of
> > a (bit of a) chaos in DT bindings, whatever you decide users will live
> > with.
> > 
> I put the offset first to group them better together, but I have no
> problem in reversing the order, then it is in a more natural speaking form.

Either way, I would like to see an Acked-by from the device tree
maintainers for the bindings. Given that,

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

to merge this driver through the mips tree, since a git merge with
    git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git drivers/reset-2
is conflict free.

regards
Philipp

