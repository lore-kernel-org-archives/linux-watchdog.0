Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:42696 "EHLO
	filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915Ab2IGPwP (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 7 Sep 2012 11:52:15 -0400
Date: Fri, 7 Sep 2012 18:51:43 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: linux-watchdog@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: omap_wdt: convert to new watchdog core
Message-ID: <20120907155143.GA10099@harshnoise.musicnaut.iki.fi>
References: <1346769684-25543-1-git-send-email-aaro.koskinen@iki.fi>
 <20120907133107.GA14585@bitmer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120907133107.GA14585@bitmer.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Sep 07, 2012 at 04:31:07PM +0300, Jarkko Nikula wrote:
> On Tue, Sep 04, 2012 at 05:41:24PM +0300, Aaro Koskinen wrote:
> > Convert omap_wdt to new watchdog core. On OMAP boards, there are usually
> > multiple watchdogs. Since the new watchdog core supports multiple
> > watchdogs, all watchdog drivers used on OMAP should be converted.
> > 
> > The legacy watchdog device node is still created, so this should not
> > break existing users.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> > ---
> >  drivers/watchdog/Kconfig    |    1 +
> >  drivers/watchdog/omap_wdt.c |  268 ++++++++++++++++++-------------------------
> >  2 files changed, 115 insertions(+), 154 deletions(-)
> > 
> Am I missing some extra patch but this causes a crash on top of v3.6-rc4
> commit eeea3ac?
> 
> Crash happens in omap_wdt.c:99 on Nokia N9.

Thanks for the report! I'll look into this and test with other
Nokia boards. I tested the patch only with N800 and v3.6-rc4
(4cbe5a555fa58a79b6ecbb6c531b8bab0650778d) and did not see any issues
with normal use cases (boot, watchdog open, feeding, watchdog close).

A.
