Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:33470 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755762AbaCKUyM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 11 Mar 2014 16:54:12 -0400
Date: Tue, 11 Mar 2014 21:54:05 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] watchdog: sunxi: Change compatible patterns
Message-ID: <20140311205405.GA10228@spo001.leaseweb.com>
References: <1391808566-31008-1-git-send-email-maxime.ripard@free-electrons.com> <20140303104042.GU607@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140303104042.GU607@lukather>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Maxime,

> Hi Wim,
> 
> On Fri, Feb 07, 2014 at 10:29:23PM +0100, Maxime Ripard wrote:
> > Hi,
> > 
> > This is the second version of the A10 watchdog compatible changes.
> > The only difference with the v1 being that we're now droping the old
> > compatibles, instead of keeping them, since the DT maintainers said it was
> > fine.
> > 
> > Thanks,
> > Maxime
> > 
> > Maxime Ripard (3):
> >   watchdog: sunxi: Change compatibles
> >   ARM: sunxi: Add the new watchog compatibles to the reboot code
> >   ARM: sunxi: dt: Update the watchdog compatibles
> 
> Ping?

I'm OK with the patches, but what is the preferred way to get them upstream?
via watchdog tree or via arch/soc tree?

Kind regards,
Wim.

