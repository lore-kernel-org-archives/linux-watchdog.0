Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36400 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbG1RcW (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 13:32:22 -0400
Received: by wicgb10 with SMTP id gb10so166781006wic.1
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 10:32:21 -0700 (PDT)
Date: Tue, 28 Jul 2015 18:32:16 +0100
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
Message-ID: <20150728173216.GC2284@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <20150728124338.GA2773@codeblueprint.co.uk>
 <20150728150021.GX14943@x1>
 <55B79D60.4080807@roeck-us.net>
 <20150728152832.GY14943@x1>
 <55B7B707.8060606@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <55B7B707.8060606@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 28 Jul 2015, Guenter Roeck wrote:

> On 07/28/2015 08:28 AM, Lee Jones wrote:
> >On Tue, 28 Jul 2015, Guenter Roeck wrote:
> >
> >>On 07/28/2015 08:00 AM, Lee Jones wrote:
> >>>On Tue, 28 Jul 2015, Matt Fleming wrote:
> >>>>On Tue, 28 Jul, at 12:37:21PM, Lee Jones wrote:
> >>>>>
> >>>>>The driver shouldn't be called that either.
> >>>>>
> >>>>>You are the only one.  What makes iTCO 'special'?
> >>>>
> >>>>I don't know, I didn't write it. It looks like Wim did ~9 years a=
go, so
> >>>>it must have made sense to him at the time.
> >>>>
> >>
> >>Coding style wasn't as strict then as it is today. iTCO has just be=
en kept
> >>for historic reasons.
> >
> >For sure, I get that, but it doesn't mean we can't do-the-right-thin=
g
> >(tm) now does it?
> >
> >>Sure, we could have changed it to lowercase, but so far no one both=
ered.
> >>Plus, of course, there is always the element that some maintainers =
hate
> >>that kind of cleanup,
> >
> >Really?  Surely any kind of clean-up is good clean-up.  Especially a=
s
> >Greg KH et. al, have been doing public presentations telling everyon=
e
> >that there is always kernel work for anyone who has the time; spelli=
ng
> >corrections and all.
> >
>=20
> Yes, really. Just try to submit cleanup patches to maintainers other =
than
> Greg and myself, and you'll see. It is a minefield.

Admittedly some of us have our quirks, but I'm happy to challenge
anyone that won't accept clean-up patches that make things better.

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
