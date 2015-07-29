Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:32805 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbbG2KHu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 06:07:50 -0400
Received: by wicmv11 with SMTP id mv11so212277269wic.0
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2015 03:07:49 -0700 (PDT)
Date: Wed, 29 Jul 2015 11:07:45 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150729100745.GA9319@x1>
References: <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <20150728124338.GA2773@codeblueprint.co.uk>
 <20150728150021.GX14943@x1>
 <55B79D60.4080807@roeck-us.net>
 <20150728152832.GY14943@x1>
 <55B7B707.8060606@roeck-us.net>
 <20150728173216.GC2284@x1>
 <20150729110423.45b33e22@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20150729110423.45b33e22@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, 29 Jul 2015, Jean Delvare wrote:

> Hi Lee,
>=20
> On Tue, 28 Jul 2015 18:32:16 +0100, Lee Jones wrote:
> > On Tue, 28 Jul 2015, Guenter Roeck wrote:
> > > On 07/28/2015 08:28 AM, Lee Jones wrote:
> > > >On Tue, 28 Jul 2015, Guenter Roeck wrote:
> > > >>Sure, we could have changed it to lowercase, but so far no one =
bothered.
> > > >>Plus, of course, there is always the element that some maintain=
ers hate
> > > >>that kind of cleanup,
> > > >
> > > >Really?  Surely any kind of clean-up is good clean-up.  Especial=
ly as
> > > >Greg KH et. al, have been doing public presentations telling eve=
ryone
> > > >that there is always kernel work for anyone who has the time; sp=
elling
> > > >corrections and all.
> > >=20
> > > Yes, really. Just try to submit cleanup patches to maintainers ot=
her than
> > > Greg and myself, and you'll see. It is a minefield.
> >=20
> > Admittedly some of us have our quirks, but I'm happy to challenge
> > anyone that won't accept clean-up patches that make things better.
>=20
> I may be one of these, to some degree, under certain circumstances.
>=20
> The problem is that what you call "better" may not actually sound
> better to me. Or it might be better in some respect but worse in othe=
rs.

Granted, there must always be a certain degree of common sense
involved.

> Specifically, your proposal to rename a kernel driver to remove
> capitals, obviously has upsides, but it may also have downsides. Are
> modprobe and friends case-insensitive? If not then renaming the modul=
e
> that way may break existing "options" or "blacklist" statements
> in /etc/modprobe.conf, or initialization scripts.

We rename/move/add/remove drivers all the time.  I understand that
you're speaking from a distribution PoV, but you guys have to take
these actions into account as a matter of course.  When you move to a
new kernel, you'll have teams who re-generate the aforementioned
files, or breakages would occur on every single release.

> Such a change may also require some changes on the distribution side,
> from a packaging perspective.

Right, which would be one of the responsibilities of the kernel
package maintainer at any given distro.  How is this any different to
any other kernel up-level?

> Likewise, renaming variables in the code makes it look better, but at
> the cost of making future backports to that driver more difficult.

This is something which has to be taken into consideration, granted.
Looking at this example, I can see 4 backports that happened in the
last 4 years, and each of them would have been trivial to fix.

> And if nothing else, the time you (or others) spend on this, is time
> you won't spend somewhere else where it may be more useful. Or fun.

There is no better way to pass the day than to abide coding standards
and my time is worthless. ;)

> So in the end there's always a balance between the costs and the
> benefits. Which may explain why sometimes some maintainers aren't so
> interested in certain clean-up patches.

If there are technical reasons why 'better' isn't really BETTER, then
I absolutely agree with you, but when I said 'better' before, I really
did mean BETTER.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
