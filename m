Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:44931 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdKIQ5D (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 9 Nov 2017 11:57:03 -0500
Date: Thu, 9 Nov 2017 08:57:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: James Hogan <james.hogan@mips.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Mathieu Malaterre <malat@debian.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: jz4780: Allow selection of jz4740-wdt
 driver
Message-ID: <20171109165700.GA23671@roeck-us.net>
References: <20170908183558.1537-1-malat@debian.org>
 <20170908183558.1537-2-malat@debian.org>
 <20171109074718.GR15260@jhogan-linux>
 <20171109160147.GB19959@roeck-us.net>
 <20171109164342.GR15235@jhogan-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171109164342.GR15235@jhogan-linux>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Nov 09, 2017 at 04:43:43PM +0000, James Hogan wrote:
> On Thu, Nov 09, 2017 at 08:01:47AM -0800, Guenter Roeck wrote:
> > On Thu, Nov 09, 2017 at 07:47:19AM +0000, James Hogan wrote:
> > > Hi Wim,
> > > 
> > > On Fri, Sep 08, 2017 at 08:35:54PM +0200, Mathieu Malaterre wrote:
> > > > This driver works for jz4740 & jz4780
> > > > 
> > > > Suggested-by: Maarten ter Huurne <maarten@treewalker.org>
> > > > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > > 
> > > I just noticed that though Ralf applied the other two patches in this
> > > series (defconfig + dt), he hadn't applied this patch.
> > > 
> > > Please can we have an ack from a watchdog maintainer so this can get
> > > into 4.15 via the MIPS tree? It could alternatively go via the watchdog
> > > tree if you prefer.
> > > 
> > 
> > FWIW, according to my logs I did send out a Reviewed-by: some time ago,
> > which normally means that I expect it to go through the watchdog tree.
> > I wasn't aware that you wanted the patch to go through the mips tree.
> > Sorry if I missed that earlier. For the record,
> > 
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > 
> > since I don't care one way or another.
> 
> Okay thanks, I wasn't sure and don't much mind which way it goes.
> 
> > 
> > I assume you want me to drop this and the related patches from my own
> > watchdpog-next tree to prevent it from showing up in Wim's tree (if
> > it isn't already there). Is that correct ?
> 
> I haven't seen this patch in linux-next, or I wouldn't have mentioned
> it. If its already in some staging tree for 4.15 that I've missed then
> it may as well stay there, otherwise I'll just take it through the MIPS
> tree with your ack.
> 
Looks like none of the patches I reviewed since the last release cycle
made it into watchdog-next, meaning they might all miss the next release.
Guess Wim is busy. Nothing I can do there.

Guenter
