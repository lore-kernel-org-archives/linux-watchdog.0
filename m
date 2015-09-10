Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3445 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752821AbbIJAwJ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Sep 2015 20:52:09 -0400
Date: Thu, 10 Sep 2015 08:52:02 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
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
	Pratyush Anand <panand@redhat.com>,
	Timur Tabi <timur@codeaurora.org>,
	Uwe =?utf-8?Q?Kleine-K=E9=B0=8Aig?=
	<u.kleine-koenig@pengutronix.de>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.3-rc1 merge window
Message-ID: <20150910005202.GB22498@wfg-t540p.sh.intel.com>
References: <20150909195838.GA12688@spo001.leaseweb.nl>
 <20150910074044.4cae547f@canb.auug.org.au>
 <CA+55aFwDUTshKj4G_JYVenOcYYhoW46gVGr3d8eK23S0ys8-VA@mail.gmail.com>
 <20150909234408.GA18441@wfg-t540p.sh.intel.com>
 <55F0CD7B.4080706@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55F0CD7B.4080706@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Sep 09, 2015 at 05:23:23PM -0700, Guenter Roeck wrote:
> On 09/09/2015 04:44 PM, Fengguang Wu wrote:
> >On Wed, Sep 09, 2015 at 02:42:23PM -0700, Linus Torvalds wrote:
> >>On Wed, Sep 9, 2015 at 2:40 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >>>
> >>>I have not been able to fetch from that tree for the past couple of
> >>>days.  It connects and then hangs for some time
> >>
> >>.. yup, that's what I got just when trying to pull.
> >
> >FYI, git fetch failures are one major reason if 0day tests are
> >delayed or not covered:
> >
> >[2015-09-10 05:00:24] failed to fetch watchdog
> >[2015-09-10 06:46:04] failed to fetch watchdog
> >
> >There are some more non-kernel.org trees that tend to suffer from
> >connection issues.
> >
> 
> On the plus side, most if not all of the patches in Wim's tree are in
> the watchdog-next branch of my repository at kernel.org. Since that branch
> is covered by the 0day tests and by my own tests, I would not expect
> any major surprises.

That's great, the hwmon branches are in good state:

 Aug 18 To Guenter Roeck  ( 111:0) [hwmon:watchdog-next] e07c1407dcf9d4c5645f753a997d6f24ff93ce97 BUILD SUCCESS
 Aug 19 To Guenter Roeck  ( 167:0) [hwmon:watchdog-next] 359be6ae025459b64df09f0dea6c43f8faba769e BUILD SUCCESS
 Aug 19 To Guenter Roeck  ( 142:0) [hwmon:watchdog-next] 8f5555c0f5a355e5f45944d9517e983a1146fe4a BUILD SUCCESS
 Aug 19 To Pratyush Anand (1723:2) [hwmon:watchdog-next 25/25] drivers/watchdog/txx9wdt.c:134:20: error: 'pdev' undeclared
 Aug 19 To Guenter Roeck  ( 111:0) [hwmon:watchdog-next] 407c45d2786005b666119c96fc677819927898aa BUILD SUCCESS
 Sep 01 To Guenter Roeck  ( 151:0) [hwmon:watchdog-next] 63cd9ae5a6609e79d2df73018e8a657e0b91ca17 BUILD SUCCESS
 Sep 04 To Guenter Roeck  ( 148:0) [hwmon:watchdog-next] b2aaf0eb653276599384a107de3608839f0ed950 BUILD SUCCESS

Thanks,
Fengguang
