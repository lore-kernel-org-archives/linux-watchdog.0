Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38467 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752659AbbG2HaR (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 29 Jul 2015 03:30:17 -0400
Received: by wibxm9 with SMTP id xm9so13145944wib.1
        for <linux-watchdog@vger.kernel.org>; Wed, 29 Jul 2015 00:30:16 -0700 (PDT)
Date: Wed, 29 Jul 2015 08:30:13 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matt Fleming <matt@codeblueprint.co.uk>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jean Delvare <jdelvare@suse.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Matt Fleming <matt.fleming@intel.com>,
	Peter Tyser <ptyser@xes-inc.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Aaron Sierra <asierra@xes-inc.com>
Subject: Re: [PATCH 1/5] iTCO_wdt: Expose watchdog properties using platform
 data
Message-ID: <20150729073013.GE2284@x1>
References: <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <20150728124338.GA2773@codeblueprint.co.uk>
 <20150728150021.GX14943@x1>
 <55B79D60.4080807@roeck-us.net>
 <20150728152832.GY14943@x1>
 <55B7B707.8060606@roeck-us.net>
 <20150728173216.GC2284@x1>
 <20150728185143.GA5382@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150728185143.GA5382@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jul 2015, Guenter Roeck wrote:

> On Tue, Jul 28, 2015 at 06:32:16PM +0100, Lee Jones wrote:
> > On Tue, 28 Jul 2015, Guenter Roeck wrote:
> >=20
> > > On 07/28/2015 08:28 AM, Lee Jones wrote:
> > > >On Tue, 28 Jul 2015, Guenter Roeck wrote:
> > > >
> > > >>On 07/28/2015 08:00 AM, Lee Jones wrote:
> > > >>>On Tue, 28 Jul 2015, Matt Fleming wrote:
> > > >>>>On Tue, 28 Jul, at 12:37:21PM, Lee Jones wrote:
> > > >>>>>
> > > >>>>>The driver shouldn't be called that either.
> > > >>>>>
> > > >>>>>You are the only one.  What makes iTCO 'special'?
> > > >>>>
> > > >>>>I don't know, I didn't write it. It looks like Wim did ~9 years=
 ago, so
> > > >>>>it must have made sense to him at the time.
> > > >>>>
> > > >>
> > > >>Coding style wasn't as strict then as it is today. iTCO has just =
been kept
> > > >>for historic reasons.
> > > >
> > > >For sure, I get that, but it doesn't mean we can't do-the-right-th=
ing
> > > >(tm) now does it?
> > > >
> > > >>Sure, we could have changed it to lowercase, but so far no one bo=
thered.
> > > >>Plus, of course, there is always the element that some maintainer=
s hate
> > > >>that kind of cleanup,
> > > >
> > > >Really?  Surely any kind of clean-up is good clean-up.  Especially=
 as
> > > >Greg KH et. al, have been doing public presentations telling every=
one
> > > >that there is always kernel work for anyone who has the time; spel=
ling
> > > >corrections and all.
> > > >
> > >=20
> > > Yes, really. Just try to submit cleanup patches to maintainers othe=
r than
> > > Greg and myself, and you'll see. It is a minefield.
> >=20
> > Admittedly some of us have our quirks, but I'm happy to challenge
> > anyone that won't accept clean-up patches that make things better.
> >=20
> There might possibly be a discussion at the kernel summit about that,
> in the context of encouraging (or discouraging) new kernel developers.
> If you are invited to the KS, it might make sense to attend that discus=
sion.

I'd be happy to, but I don't have any first-hand experience of these
awkward (backward) Maintainers, who for some reason thing 'no change'
("don't touch it, it works"?) is better than 'improvement'.=20

If/when you come across it, a link would be appreciated.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
