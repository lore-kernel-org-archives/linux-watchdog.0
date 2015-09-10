Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:40310 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018AbbIJXNN (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 10 Sep 2015 19:13:13 -0400
Date: Fri, 11 Sep 2015 09:13:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Fengguang Wu <fengguang.wu@intel.com>,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Greta Zhang <greta.zhang@mediatek.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Pratyush Anand <panand@redhat.com>,
	Timur Tabi <timur@codeaurora.org>,
	Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
	<u.kleine-koenig@pengutronix.de>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.3-rc1 merge window
Message-ID: <20150911091311.56d3df9e@canb.auug.org.au>
In-Reply-To: <20150910163759.57a7d5a0@canb.auug.org.au>
References: <20150909195838.GA12688@spo001.leaseweb.nl>
	<20150910074044.4cae547f@canb.auug.org.au>
	<20150910062004.GB21250@spo001.leaseweb.nl>
	<20150910163759.57a7d5a0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On Thu, 10 Sep 2015 16:37:59 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Thu, 10 Sep 2015 08:20:07 +0200 Wim Van Sebroeck <wim@iguana.be> wrote:
> >
> > > > Please pull from 'master' branch of
> > > > 	git://www.linux-watchdog.org/linux-watchdog.git
> > > 
> > > I have not been able to fetch from that tree for the past couple of
> > > days.  It connects and then hangs for some time and then I get:
> > > 
> > > fatal: read error: Connection reset by peer
> > > 
> > > Sorry for not mentioning it earlier.
> > 
> > The tree hasn't changed since 1.5 weeks, so on content level nothing has changed.
> 
> OK, I managed to refetch your tree (it was still very slow - you might
> want to consider moving it to git.kernel.org).  The patches appear
> identical to what I last fetched (and what has been in linux-next since
> Aug 31), but it has all been recommitted in the last day.
> 
> The end result and the base are exactly the same, so it should not be a
> problem, I guess.

OK, the above is true, but I have been a bit confused.  I was trying to
figure out why (if the above is true, a "git fetch watchdog" did not
update what I have fetched.  It turns out that the tree I pull into
linux-next is
git://www.linux-watchdog.org/linux-watchdog-next.git
the one you asked Linus to pull is
git://www.linux-watchdog.org/linux-watchdog.git

So instead of just fetching from one tree to the other, it seems that
you have reapplied the patches from one to the other :-(
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
