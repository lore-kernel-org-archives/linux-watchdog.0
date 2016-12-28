Return-path: <ukl@pengutronix.de>
Date: Wed, 28 Dec 2016 21:54:19 +0100
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	Magnus Lilja <lilja.magnus@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21,
 i.MX27 and i.MX31 SoCs
Message-ID: <20161228205419.la74jr4rfes7fa4v@pengutronix.de>
References: <20161211102634.jn3awmlzdrm3pqai@pengutronix.de>
 <2fc2558d-fe05-14a7-745e-f71d2178bad6@mleia.com>
 <fe9b03bf-9c37-862f-b3aa-0f9b5a4dfefb@roeck-us.net>
 <bedae3d8-3057-36e4-1d89-ec41f9f1a25b@mleia.com>
 <20161223083256.3wdqou5xmhr7fidn@pengutronix.de>
 <74751709-c32e-b1b3-4fa3-613f7d57d1d8@mleia.com>
 <20161223100113.s57bi7257yero7f7@pengutronix.de>
 <7018c466-2467-a9fc-2382-889d3a62741e@mentor.com>
 <20161223141139.rlsvoonih5lhnnpu@pengutronix.de>
 <c22600d5-f6b5-4c13-59b4-ba391ea29a4c@mleia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c22600d5-f6b5-4c13-59b4-ba391ea29a4c@mleia.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hello Vladimir,

On Sat, Dec 24, 2016 at 07:08:15AM +0200, Vladimir Zapolskiy wrote:
> Hello Uwe,
> 
> On 12/23/2016 04:11 PM, Uwe Kleine-König wrote:
> > On Fri, Dec 23, 2016 at 01:21:20PM +0200, Vladimir Zapolskiy wrote:
> >> Hi Uwe,
> >>
> >> On 12/23/2016 12:01 PM, Uwe Kleine-König wrote:
> >>> On Fri, Dec 23, 2016 at 11:27:24AM +0200, Vladimir Zapolskiy wrote:
> >>>> On 12/23/2016 10:32 AM, Uwe Kleine-König wrote:
> >>>>> Hello,
> >>>>>
> >>>>> On Fri, Dec 23, 2016 at 10:20:20AM +0200, Vladimir Zapolskiy wrote:
> >>>>>> On 12/23/2016 03:55 AM, Guenter Roeck wrote:
> >>>>>>> What is the ultimate conclusion of this exchange ?
> >>>>>>>
> >>>>>>> Are we going to get another version of the patch, or did everyone agree that
> >>>>>>> the patch is good as it is and does not require further changes ?
> >>>>>>>
> >>>>>>
> >>>>>> I can not imagine a different fix.
> >>>>>
> >>>>> my preferred fix would be:
> >>>>>
> >>>>>  - add an imx35 compatible to all newer dtsi
> >>>>>  - update the driver to only write the wmcr on imx35 compatible devices
> >>>>>    adding only imx35.
> >>>>>
> >>>>
> >>>> It breaks old DTS vs. new kernel compatibility, I've already mentioned this.
> >>>
> >>> Correct, and I didn't deny that. In my mail I pointed out the problem
> >>> this imposes and I think it's small enough to not justify the complexity
> >>> introduced in your proposed change.
> >>>
> >>
> >> I can not statistically estimate well the severity of the problem which was
> >> fixed by commit 5fe65ce7cc (all boards with a similar change not found in
> >> a bootloader will be affected, I believe) multiplied by the rate of users,
> >> who don't update DTB.
> > 
> > I think most people updating the kernel will update the dtb at the same
> > time. And for those who don't it should be quickly obvious that
> > something is wrong during development if the machine resets
> > unexpectedly. Plus I think that most users are not affected anyhow
> > (either because their bootloader fixes up accordingly or because most
> > machines don't reset when the timer expires because the hardware isn't
> > designed accordingly). After all between introduction of i.MX35/i.MX25
> > (not later than Thu Jun 4 11:32:12 2009 +0200, commit
> > 8c25c36f33157a2e2a1fcd60b6dc00feace80631) and the broken commit
> > 5fe65ce7cc (Mon Sep 8 09:14:07 2014 +0200) it seems it wasn't an issue.
> > 
> > With my suggestion the situation on an affected machine with old dtb and
> > new kernel is just as it was in these 5 years where nobody complained.
> 
> Please feel free to send the revert of 5fe65ce7cc, if you think that
> the commit is unneeded.

I think there is at least a handful of machines that need it. And I
doubt any of them will get a new kernel without a new dtb.

> > It's fine to target a bugfree system, and if you want to target that
> > that's applaudable. But then please make it easy for others after you to
> > not undo your good and add a big comment to the compatible array of the
> > driver explaining why they are all listed explicitly and how to prevent
> > to have to expand the list further.
> 
> Please clarify, what do you mean here by "undo my good"? Revert my fix
> and break boot on i.MX31 again or something else?

What I want is that if you add all these compatibles to the driver,
please also add a big comment explaining why they are there. Otherwise
someone with good intentions will come an cleanup.
 
> > So yes, my suggestion has a risk, but I think when weighting that
> > against the overhead that is introduced in the driver, I'd go the
> > simpler way.
> 
> What overhead do you mean here? Prolonged time in a loop while finding
> a compatible by looking at 10 more values?

No, I don't think this will add relevant overhead. I want to keep the
driver simple for easier maintenance.

> That's the price of the accepted commit 5fe65ce7cc and overlooked
> incompatibilities in hardware while writing DTSI files for i.MX SoCs.
> 
> > That's of course something personal and as it's you who
> > seems to have in interest in fixing the driver, it's your way that
> > matters more. And if you document your way good enough, I won't stop
> > you.
> > 
> 
> We're going round in circles. And I don't understand what do you mean
> by "documenting my way" here.
> 
> For clarity I do NOT object against changes in DTS, I do NOT object
> to shrink the list of compatibles, I object to mix up the requested
> DTS changes for practically every i.MX powered board, bug fix and
> a new potential bug in one single change. The series of commits is
> generally good, but it lacks atomicity property of a fix, and in
> the middle of the series users have to update DTB, it is an overkill.
> 
> Is it possible to change DTS *only* and fix kernel boot problem? NO.
> Is it possible to change driver *only* and fix kernel boot problem? YES.
> Conclusion: the problem is within the driver, to solve the problem
> it is sufficient to fix the driver.

This argumentation is wrong in general. Any fixable damage can be fixed
in code only by changing how the dtb is interpreted.

The problem here is that 5fe65ce7cc is right for i.MX35 (and others) but
wrong for i.MX21 (and others) and there is no differentiation between
these two types in the driver. So I think we agree the right thing to do
in the end is: Make the driver aware that there are two different
hardware types and in the dtsi make use of the right one.


> I'll add a comment to v2:
> 
> /*
>  * The list of compatibles is added to achieve backward compatibility
>  * between DTS and kernel while fixing the incompatibility between

I'd write: "to achieve compatibility between old DTS and new kernel"

>  * i.MX21/i.MX27/i.MX31 and i.MX25/i.MX35/etc. watchdog controllers.
>  *
>  * Please do *NOT* extend the list by adding a compatible value for
>  * a controller, which is compatible with one of the already listed.
>  *
>  * You may consider to shrink the list at your own risk, but this may
>  * break backward compatibility and users may have to update their DTB,
>  * which is good eventually.
>  */
> 
> And you send the removal of the comment and compatibles as a *separate*
> change, if you find such a long list of compatibles redundant.

I'd do it the other way around and so get more and simpler patches:

 - make driver aware of i.MX35
 - fix dtsi to use i.MX35 type where applicable

and IMHO optionally:

 - introduce compatibility stuff with the above comment

I hope we converge to a solution acceptable for you and me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
