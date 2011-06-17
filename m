Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mailrelay001.isp.belgacom.be ([195.238.6.51]:14133 "EHLO
	mailrelay001.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757298Ab1FQHUr (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 17 Jun 2011 03:20:47 -0400
Date: Fri, 17 Jun 2011 09:20:45 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Jamie Iles <jamie@jamieiles.com>,
	Peter Fordham <peter.fordham@gmail.com>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Subject: Re: [MPCore Watchdog]: Convert from misc_dev to dynamic device
	node.
Message-ID: <20110617072045.GM23305@infomag.iguana.be>
References: <BANLkTinaQpnVxwX5rB1jrabGX6ArvhhS7g@mail.gmail.com> <BANLkTinY8bM0PyLLcu6icEsWT=X=KVV3DQ@mail.gmail.com> <20110615190945.GA2518@pulham.picochip.com> <201106152136.23971.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201106152136.23971.arnd@arndb.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Arnd,

> On Wednesday 15 June 2011 21:09:45 Jamie Iles wrote:
> > On Wed, Jun 15, 2011 at 11:57:12AM -0700, Peter Fordham wrote:
> > > > I've added Wim (watchdog driver maintainer), but I would think that if
> > > > this change is worth doing then it should be done for all drivers.
> > > 
> > > Agreed, but today this may be more work than I'm strictly interested in
> > > doing. If we do decide it's the right thing then I'll look into converting the
> > > other drivers later.
> > 
> > So I'm not fully aware of what particular problem this is solving, but 
> > if it is needed for this driver then it should really be done for all of 
> > them.  That's probably one for Wim to answer though.  Wim posted a 
> > series for a generic watchdog framework a while back[1] but this still 
> > made use of a misc device.
> 
> Let's first wait until the generic watchdog framework gets merged and
> the drivers are converted. After that is in, we can discuss further changes.
> 
> I highly doubt that making an incompatible API change benefits anyone here,
> but it certainly shouldn't be done for a single driver that is separate from
> the framework.

Agree for the full 100%.

Thanks,
Wim.

