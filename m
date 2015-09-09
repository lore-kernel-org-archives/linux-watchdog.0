Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59095 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752369AbbIIXoP (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Sep 2015 19:44:15 -0400
Date: Thu, 10 Sep 2015 07:44:08 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Wim Van Sebroeck <wim@iguana.be>,
	Andrew Morton <akpm@linux-foundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
	Bjorn Andersson <bjorn.andersson@sonymobile.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Francesco Lavra <francescolavra.fl@gmail.com>,
	Greta Zhang <greta.zhang@mediatek.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Pratyush Anand <panand@redhat.com>,
	Timur Tabi <timur@codeaurora.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.3-rc1 merge window
Message-ID: <20150909234408.GA18441@wfg-t540p.sh.intel.com>
References: <20150909195838.GA12688@spo001.leaseweb.nl>
 <20150910074044.4cae547f@canb.auug.org.au>
 <CA+55aFwDUTshKj4G_JYVenOcYYhoW46gVGr3d8eK23S0ys8-VA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwDUTshKj4G_JYVenOcYYhoW46gVGr3d8eK23S0ys8-VA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 09, 2015 at 02:42:23PM -0700, Linus Torvalds wrote:
> On Wed, Sep 9, 2015 at 2:40 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > I have not been able to fetch from that tree for the past couple of
> > days.  It connects and then hangs for some time
> 
> .. yup, that's what I got just when trying to pull.

FYI, git fetch failures are one major reason if 0day tests are
delayed or not covered:

[2015-09-10 05:00:24] failed to fetch watchdog
[2015-09-10 06:46:04] failed to fetch watchdog

There are some more non-kernel.org trees that tend to suffer from
connection issues.

btw, note the 1+ hour poll interval -- it's auto lowered for
"inactive" trees. Only git.kernel.org trees can be watched closely
since they are polled as a whole through

        http://git.kernel.org/manifest.js.gz
        
Thanks,
Fengguang
