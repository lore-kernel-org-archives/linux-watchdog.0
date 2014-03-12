Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33566 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756166AbaCLSHy (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 14:07:54 -0400
Date: Wed, 12 Mar 2014 19:07:51 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
Message-ID: <20140312180751.GC1484@spo001.leaseweb.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com> <20140303104042.GU607@lukather> <20140311205405.GA10228@spo001.leaseweb.com> <20140312091649.GU2815@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140312091649.GU2815@lukather>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Maxime,

> Hi Wim,
> 
> On Tue, Mar 11, 2014 at 09:54:05PM +0100, Wim Van Sebroeck wrote:
> > > On Fri, Feb 07, 2014 at 10:29:23PM +0100, Maxime Ripard wrote:
> > > > Hi,
> > > > 
> > > > This is the second version of the A10 watchdog compatible changes.
> > > > The only difference with the v1 being that we're now droping the old
> > > > compatibles, instead of keeping them, since the DT maintainers said it was
> > > > fine.
> > > > 
> > > > Thanks,
> > > > Maxime
> > > > 
> > > > Maxime Ripard (3):
> > > >   watchdog: sunxi: Change compatibles
> > > >   ARM: sunxi: Add the new watchog compatibles to the reboot code
> > > >   ARM: sunxi: dt: Update the watchdog compatibles
> > > 
> > > Ping?
> > 
> > I'm OK with the patches, but what is the preferred way to get them upstream?
> > via watchdog tree or via arch/soc tree?
> 
> Since it touches the machine restart code, I'd prefer to merge it
> myself if it's ok?

No Problem. You have my Acked-by.

Kind regards,
Wim.

