Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:44908 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753722AbbEFH0L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 May 2015 03:26:11 -0400
Message-ID: <5549C20F.4010605@offcode.fi>
Date: Wed, 06 May 2015 10:26:07 +0300
From: Timo Kokkonen <timo.kokkonen@offcode.fi>
MIME-Version: 1.0
To: =?windows-1252?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, boris.brezillon@free-electrons.com,
	nicolas.ferre@atmel.com, alexandre.belloni@free-electrons.com,
	Wenyou.Yang@atmel.com,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>
Subject: Re: [PATCHv7 0/8] watchdog: Extend kernel API and add early_timeout_sec
 feature
References: <1429701102-22320-1-git-send-email-timo.kokkonen@offcode.fi> <20150505135054.GI25193@pengutronix.de>
In-Reply-To: <20150505135054.GI25193@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Uwe,

On 05.05.2015 16:50, Uwe Kleine-König wrote:
> Hello,
>
> I talked to Marc Kleine-Budde about your approach, thought a bit more
> about it and want to share a few thoughts with you.
>
> Actually your series addresses three different problems
>
>   a) some watchdog hardware isn't stoppable;
>   b) some watchdog hardware has short maximal timeout;
>   c) what to do with a watchdog that is already running at probe time?
>
> The common solution is to add a mid-layer between userspace and the
> driver that bridges the possible hardware limitations when userspace
> wants to stop the watchdog or set a big timeout value. c) is a bit
> different but could make use of the infrastructure that is introduced
> while fixing a+b). The main difference between a+b) and c) is that for
> c) you have to introduce some policy. If the series were mine I'd first
> do three commits that address a), b) and c) each. Then convert drivers
> to it.

The infrastructure needed for both a and b is the same, the actual code 
to implement either a or b is also touching the same functions and quite 
slim, so I think it may not be feasible to separate those in their own 
patches. But I'll think about it and see if logical separation makes sense.

> Guenter and I already said something similar, but I will eventually
> repeat it here more explicitly: When introducing a midlayer that
> abstracts between hardware and it's users the IMHO most important thing
> to get right is to be explicit about which side of a midlayer you're
> currently working at. That is, be explicit about watchdog_is_running:
> Does it mean the hardware is running, or does userspace believe the
> watchdog to be active? Same for timeout, stoppable etc.pp.

Yes, I agree. Thanks for clarifying this. I will keep this in mind and 
try to be explicit when naming functions and variables. The best way 
would be to also rename the existing variables too, but that would also 
touch all the existing drivers. Keeping the current naming scheme in 
place no doubt is less explicit about which side of the new midlayer 
they are working on. But luckily the logic of the existing driver 
doesn't change, they are all exposing things directly to userland and 
they can be documented as is. The new variables and functions add 
interfaces only between the new midlayer and HW, so they are explicit as 
well. So I think it is a fair compromise to leave all existing interface 
towards the user space as is.

> When you consider changing the unit the watchdog core is using, why not
> change to nano seconds and 64 bit variables? You might be able to copy
> some algorithms and ideas from the timer core that uses these.

Yes, sounds like a good idea. I will look into it.

> For c), I'd want to have a compile time setting that specifies the
> default value for the policy:
>   - disable at probe
>   - don't touch a running timer
>   - start at probe
> This is friendly to distributions that might want to set "disable at
> probe"-default to be on the safe side. Still make this overridable by a
> kernel parameter. I'm not sure that "start at probe" is a sensible
> feature. (Either you want to start the watchdog early, in this case even
> before Linux starts; or you're not that strict then it doesn't matter
> much if it takes yet another little while until your application that
> pets the watchdog is up.)

Yes, this is very simple and sounds like a reasonable thing to have. I 
will add a Kconfig entry for this kind of build time default.

I will start working on the next version soon before I start forgetting 
all the good feedback I have received...

Thanks!
-Timo
