Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:60687 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751485AbdH3P5Q (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 30 Aug 2017 11:57:16 -0400
Date: Wed, 30 Aug 2017 17:57:10 +0200
From: Simon Horman <horms@verge.net.au>
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ARM: dts: r7s72100: Add reset handler
Message-ID: <20170830155700.GA28162@verge.net.au>
References: <20170216172320.10897-1-chris.brandt@renesas.com>
 <20170216172320.10897-4-chris.brandt@renesas.com>
 <CAMuHMdVMBo9fNMTqz_XdU27FF5TX98r-OE5pJ5atJ1s4XLxcTw@mail.gmail.com>
 <20170830082940.GR10398@verge.net.au>
 <SG2PR06MB1165B8B815327A6768AE681A8A9C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR06MB1165B8B815327A6768AE681A8A9C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Aug 30, 2017 at 01:22:32PM +0000, Chris Brandt wrote:
> Hi Simon,
> 
> On Wednesday, August 30, 2017, Simon Horman wrote:
> > On Fri, Feb 17, 2017 at 11:29:25AM +0100, Geert Uytterhoeven wrote:
> > > On Thu, Feb 16, 2017 at 6:23 PM, Chris Brandt <chris.brandt@renesas.com>
> > wrote:
> > > > For the RZ/A1, the only way to do a reset is to overflow the WDT.
> > > >
> > > > Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > Hi Chris,
> > 
> > while going through old patches I noticed that I seem to have missed this
> > one. It looks like it needs a rebase. If it is still applicable could you
> > please consider doing so and reposting.
> 
> 
> It's in -next already:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm/boot/dts/r7s72100.dtsi?h=next-20170829&id=69ed50de582eff6307fd3fa050fdc505731f0a2d
> 
> Doesn't that mean it's queued up for 4.14?
> 
> Or, somehow it didn't make it into the pull request for Arnd's tree?

Thanks, I now see that it is included in v4.12.
Sorry for the noise.
