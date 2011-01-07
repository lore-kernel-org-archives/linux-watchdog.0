Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42731 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755008Ab1AGSJh (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Jan 2011 13:09:37 -0500
Date: Fri, 7 Jan 2011 18:09:24 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Jamie Iles <jamie@jamieiles.com>
Cc: viresh kumar <viresh.linux@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv3] watchdog: add support for the Synopsys DesignWare WDT
Message-ID: <20110107180924.GV31708@n2100.arm.linux.org.uk>
References: <1294401797-24158-1-git-send-email-jamie@jamieiles.com> <AANLkTi=s4Wuj1YyALL7f1AK-MQjvPre8mvviLhw5TdPH@mail.gmail.com> <20110107165250.GU31708@n2100.arm.linux.org.uk> <20110107175613.GH2844@pulham.picochip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20110107175613.GH2844@pulham.picochip.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Jan 07, 2011 at 05:56:13PM +0000, Jamie Iles wrote:
> On Fri, Jan 07, 2011 at 04:52:50PM +0000, Russell King - ARM Linux wrote:
> > On Fri, Jan 07, 2011 at 10:13:50PM +0530, viresh kumar wrote:
> > > > +
> > > > +       dw_wdt.clk = clk_get(&pdev->dev, NULL);
> > > > +       if (IS_ERR_OR_NULL(dw_wdt.clk))
> > > > +               return -ENODEV;
> > > 
> > > should release mem_region and free ioremaped space.
> > > Also, may be we can continue here in case of error too.
> > > Some platforms might nor support clock framework. You can enable and
> > > disable clk's
> > > if dw_wdt.clk is !NULL
> > 
> > And some platforms have been known to return NULL for clk_get() as they
> > don't support more than one clock.
> > 
> > arch/arm/mach-aaec2000/core.c:struct clk *clk_get(struct device *dev, const char *id)
> > arch/arm/mach-aaec2000/core.c-{
> > arch/arm/mach-aaec2000/core.c-  return dev && strcmp(dev_name(dev), "mb:16") ==
> > 0 ? NULL : ERR_PTR(-ENOENT);
> > --
> > arch/arm/mach-at91/at91x40.c:struct clk *clk_get(struct device *dev, const char
> > *id)
> > arch/arm/mach-at91/at91x40.c-{
> > arch/arm/mach-at91/at91x40.c-   return NULL;
> > --
> > arch/arm/mach-netx/fb.c:struct clk *clk_get(struct device *dev, const char *id)
> > arch/arm/mach-netx/fb.c-{
> > arch/arm/mach-netx/fb.c-        return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
> > 
> > Please stick to the conventions of the API in the driver.  IS_ERR() values
> > mean we failed.  Anything else must be considered success.  Don't assume
> > NULL means we failed.
> 
> Ok, so I'll change the driver to get the clock rate of the watchdog 
> through platform data for those that don't provide a struct clk and 
> clk_get_rate() returns 0.
> 
> Looking at mach-aaec2000 and mach-netx they don't provide a 
> clk_get_rate() which from linux/clk.h doesn't look like it's optional.  
> Should these platforms have some kind of stub clk_get_rate()?

Probably, though I don't think aaec2000 is maintained anymore (I think it
was a dump-and-run thing) so should probably be deleted from the kernel
tree.

netx - since December 2008, it's only received updates when other stuff
has changed (eg, on my clocksource sweep, or when I've noticed it no
longer building.)  So I think that's also a candidate for deletion
unless someone speaks up.

Wonder if anyone wants to volunteer to delete them... ;)
