Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:51141 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030211AbcLWOLp (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 23 Dec 2016 09:11:45 -0500
Date: Fri, 23 Dec 2016 15:11:39 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: linux-watchdog@vger.kernel.org,
        Magnus Lilja <lilja.magnus@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20161223141139.rlsvoonih5lhnnpu@pengutronix.de>
References: <20161211093519.xrxxhrqpc7fmadfr@pengutronix.de>
 <d6d987f1-3461-214a-0ca1-16d310ddd370@mleia.com>
 <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
 <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
 <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
 <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
 <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
 <20161223100113.s57bi7257yero7f7@pengutronix.de>
 <7018c466-2467-a9fc-2382-889d3a62741e@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7018c466-2467-a9fc-2382-889d3a62741e@mentor.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Dec 23, 2016 at 01:21:20PM +0200, Vladimir Zapolskiy wrote:
> Hi Uwe,
> 
> On 12/23/2016 12:01 PM, Uwe Kleine-König wrote:
> > On Fri, Dec 23, 2016 at 11:27:24AM +0200, Vladimir Zapolskiy wrote:
> >> On 12/23/2016 10:32 AM, Uwe Kleine-König wrote:
> >>> Hello,
> >>>
> >>> On Fri, Dec 23, 2016 at 10:20:20AM +0200, Vladimir Zapolskiy wrote:
> >>>> On 12/23/2016 03:55 AM, Guenter Roeck wrote:
> >>>>> What is the ultimate conclusion of this exchange ?
> >>>>>
> >>>>> Are we going to get another version of the patch, or did everyone agree that
> >>>>> the patch is good as it is and does not require further changes ?
> >>>>>
> >>>>
> >>>> I can not imagine a different fix.
> >>>
> >>> my preferred fix would be:
> >>>
> >>>  - add an imx35 compatible to all newer dtsi
> >>>  - update the driver to only write the wmcr on imx35 compatible devices
> >>>    adding only imx35.
> >>>
> >>
> >> It breaks old DTS vs. new kernel compatibility, I've already mentioned this.
> > 
> > Correct, and I didn't deny that. In my mail I pointed out the problem
> > this imposes and I think it's small enough to not justify the complexity
> > introduced in your proposed change.
> > 
> 
> I can not statistically estimate well the severity of the problem which was
> fixed by commit 5fe65ce7cc (all boards with a similar change not found in
> a bootloader will be affected, I believe) multiplied by the rate of users,
> who don't update DTB.

I think most people updating the kernel will update the dtb at the same
time. And for those who don't it should be quickly obvious that
something is wrong during development if the machine resets
unexpectedly. Plus I think that most users are not affected anyhow
(either because their bootloader fixes up accordingly or because most
machines don't reset when the timer expires because the hardware isn't
designed accordingly). After all between introduction of i.MX35/i.MX25
(not later than Thu Jun 4 11:32:12 2009 +0200, commit
8c25c36f33157a2e2a1fcd60b6dc00feace80631) and the broken commit
5fe65ce7cc (Mon Sep 8 09:14:07 2014 +0200) it seems it wasn't an issue.

With my suggestion the situation on an affected machine with old dtb and
new kernel is just as it was in these 5 years where nobody complained.

It's fine to target a bugfree system, and if you want to target that
that's applaudable. But then please make it easy for others after you to
not undo your good and add a big comment to the compatible array of the
driver explaining why they are all listed explicitly and how to prevent
to have to expand the list further.

So yes, my suggestion has a risk, but I think when weighting that
against the overhead that is introduced in the driver, I'd go the
simpler way. That's of course something personal and as it's you who
seems to have in interest in fixing the driver, it's your way that
matters more. And if you document your way good enough, I won't stop
you.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
