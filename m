Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:40137 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750843AbbIJGiF (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 10 Sep 2015 02:38:05 -0400
Date: Thu, 10 Sep 2015 16:37:59 +1000
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
Message-ID: <20150910163759.57a7d5a0@canb.auug.org.au>
In-Reply-To: <20150910062004.GB21250@spo001.leaseweb.nl>
References: <20150909195838.GA12688@spo001.leaseweb.nl>
	<20150910074044.4cae547f@canb.auug.org.au>
	<20150910062004.GB21250@spo001.leaseweb.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

On Thu, 10 Sep 2015 08:20:07 +0200 Wim Van Sebroeck <wim@iguana.be> wrote:
>
> > > Please pull from 'master' branch of
> > > 	git://www.linux-watchdog.org/linux-watchdog.git
> > 
> > I have not been able to fetch from that tree for the past couple of
> > days.  It connects and then hangs for some time and then I get:
> > 
> > fatal: read error: Connection reset by peer
> > 
> > Sorry for not mentioning it earlier.
> 
> The tree hasn't changed since 1.5 weeks, so on content level nothing has changed.

OK, I managed to refetch your tree (it was still very slow - you might
want to consider moving it to git.kernel.org).  The patches appear
identical to what I last fetched (and what has been in linux-next since
Aug 31), but it has all been recommitted in the last day.

The end result and the base are exactly the same, so it should not be a
problem, I guess.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
