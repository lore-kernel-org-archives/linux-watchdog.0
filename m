Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:58248 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbIJAXf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 9 Sep 2015 20:23:35 -0400
Message-ID: <55F0CD7B.4080706@roeck-us.net>
Date: Wed, 09 Sep 2015 17:23:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Fengguang Wu <fengguang.wu@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
CC: Stephen Rothwell <sfr@canb.auug.org.au>,
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
	=?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Wenyou Yang <wenyou.yang@atmel.com>
Subject: Re: [GIT PULL REQUEST] watchdog - v4.3-rc1 merge window
References: <20150909195838.GA12688@spo001.leaseweb.nl> <20150910074044.4cae547f@canb.auug.org.au> <CA+55aFwDUTshKj4G_JYVenOcYYhoW46gVGr3d8eK23S0ys8-VA@mail.gmail.com> <20150909234408.GA18441@wfg-t540p.sh.intel.com>
In-Reply-To: <20150909234408.GA18441@wfg-t540p.sh.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 09/09/2015 04:44 PM, Fengguang Wu wrote:
> On Wed, Sep 09, 2015 at 02:42:23PM -0700, Linus Torvalds wrote:
>> On Wed, Sep 9, 2015 at 2:40 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>>
>>> I have not been able to fetch from that tree for the past couple of
>>> days.  It connects and then hangs for some time
>>
>> .. yup, that's what I got just when trying to pull.
>
> FYI, git fetch failures are one major reason if 0day tests are
> delayed or not covered:
>
> [2015-09-10 05:00:24] failed to fetch watchdog
> [2015-09-10 06:46:04] failed to fetch watchdog
>
> There are some more non-kernel.org trees that tend to suffer from
> connection issues.
>

On the plus side, most if not all of the patches in Wim's tree are in
the watchdog-next branch of my repository at kernel.org. Since that branch
is covered by the 0day tests and by my own tests, I would not expect
any major surprises.

Guenter

