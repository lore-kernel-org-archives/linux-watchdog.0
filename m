Return-path: <vz@mleia.com>
Subject: Re: [PATCH v1] watchdog: imx2: fix hang-up on boot for i.MX21, i.MX27
 and i.MX31 SoCs
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
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
 <20161223141139.rlsvoonih5lhnnpu@pengutronix.de>
Cc: linux-watchdog@vger.kernel.org, Magnus Lilja <lilja.magnus@gmail.com>,
 Wim Van Sebroeck <wim@iguana.be>, linux-arm-kernel@lists.infradead.org,
 Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>, Guenter Roeck <linux@roeck-us.net>
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <c22600d5-f6b5-4c13-59b4-ba391ea29a4c@mleia.com>
Date: Sat, 24 Dec 2016 07:08:15 +0200
MIME-Version: 1.0
In-Reply-To: <20161223141139.rlsvoonih5lhnnpu@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
List-ID: <linux-watchdog@vger.kernel.org>

Hello Uwe,

On 12/23/2016 04:11 PM, Uwe Kleine-König wrote:
> On Fri, Dec 23, 2016 at 01:21:20PM +0200, Vladimir Zapolskiy wrote:
>> Hi Uwe,
>>
>> On 12/23/2016 12:01 PM, Uwe Kleine-König wrote:
>>> On Fri, Dec 23, 2016 at 11:27:24AM +0200, Vladimir Zapolskiy wrote:
>>>> On 12/23/2016 10:32 AM, Uwe Kleine-König wrote:
>>>>> Hello,
>>>>>
>>>>> On Fri, Dec 23, 2016 at 10:20:20AM +0200, Vladimir Zapolskiy wrote:
>>>>>> On 12/23/2016 03:55 AM, Guenter Roeck wrote:
>>>>>>> What is the ultimate conclusion of this exchange ?
>>>>>>>
>>>>>>> Are we going to get another version of the patch, or did everyone agree that
>>>>>>> the patch is good as it is and does not require further changes ?
>>>>>>>
>>>>>>
>>>>>> I can not imagine a different fix.
>>>>>
>>>>> my preferred fix would be:
>>>>>
>>>>>  - add an imx35 compatible to all newer dtsi
>>>>>  - update the driver to only write the wmcr on imx35 compatible devices
>>>>>    adding only imx35.
>>>>>
>>>>
>>>> It breaks old DTS vs. new kernel compatibility, I've already mentioned this.
>>>
>>> Correct, and I didn't deny that. In my mail I pointed out the problem
>>> this imposes and I think it's small enough to not justify the complexity
>>> introduced in your proposed change.
>>>
>>
>> I can not statistically estimate well the severity of the problem which was
>> fixed by commit 5fe65ce7cc (all boards with a similar change not found in
>> a bootloader will be affected, I believe) multiplied by the rate of users,
>> who don't update DTB.
> 
> I think most people updating the kernel will update the dtb at the same
> time. And for those who don't it should be quickly obvious that
> something is wrong during development if the machine resets
> unexpectedly. Plus I think that most users are not affected anyhow
> (either because their bootloader fixes up accordingly or because most
> machines don't reset when the timer expires because the hardware isn't
> designed accordingly). After all between introduction of i.MX35/i.MX25
> (not later than Thu Jun 4 11:32:12 2009 +0200, commit
> 8c25c36f33157a2e2a1fcd60b6dc00feace80631) and the broken commit
> 5fe65ce7cc (Mon Sep 8 09:14:07 2014 +0200) it seems it wasn't an issue.
> 
> With my suggestion the situation on an affected machine with old dtb and
> new kernel is just as it was in these 5 years where nobody complained.

Please feel free to send the revert of 5fe65ce7cc, if you think that
the commit is unneeded.

> 
> It's fine to target a bugfree system, and if you want to target that
> that's applaudable. But then please make it easy for others after you to
> not undo your good and add a big comment to the compatible array of the
> driver explaining why they are all listed explicitly and how to prevent
> to have to expand the list further.

Please clarify, what do you mean here by "undo my good"? Revert my fix
and break boot on i.MX31 again or something else?

> 
> So yes, my suggestion has a risk, but I think when weighting that
> against the overhead that is introduced in the driver, I'd go the
> simpler way.

What overhead do you mean here? Prolonged time in a loop while finding
a compatible by looking at 10 more values?

That's the price of the accepted commit 5fe65ce7cc and overlooked
incompatibilities in hardware while writing DTSI files for i.MX SoCs.

> That's of course something personal and as it's you who
> seems to have in interest in fixing the driver, it's your way that
> matters more. And if you document your way good enough, I won't stop
> you.
> 

We're going round in circles. And I don't understand what do you mean
by "documenting my way" here.

For clarity I do NOT object against changes in DTS, I do NOT object
to shrink the list of compatibles, I object to mix up the requested
DTS changes for practically every i.MX powered board, bug fix and
a new potential bug in one single change. The series of commits is
generally good, but it lacks atomicity property of a fix, and in
the middle of the series users have to update DTB, it is an overkill.

Is it possible to change DTS *only* and fix kernel boot problem? NO.
Is it possible to change driver *only* and fix kernel boot problem? YES.
Conclusion: the problem is within the driver, to solve the problem
it is sufficient to fix the driver.

As I see it what you propose with involving DTS changes is a solution
to *another* problem (boot time performance optimisation? amount of
driver's lines of code? DTS beautification?).

And obviously it makes no sense to send a DTS change plus error-prone
change plus the actual fix to linux-stable then, even if they are
split by commits.

Uwe, I'm disappointed that we still did not come to a conclusion,
would you agree to a compromise?

I'll add a comment to v2:

/*
 * The list of compatibles is added to achieve backward compatibility
 * between DTS and kernel while fixing the incompatibility between
 * i.MX21/i.MX27/i.MX31 and i.MX25/i.MX35/etc. watchdog controllers.
 *
 * Please do *NOT* extend the list by adding a compatible value for
 * a controller, which is compatible with one of the already listed.
 *
 * You may consider to shrink the list at your own risk, but this may
 * break backward compatibility and users may have to update their DTB,
 * which is good eventually.
 */

And you send the removal of the comment and compatibles as a *separate*
change, if you find such a long list of compatibles redundant.

--
With best wishes,
Vladimir
