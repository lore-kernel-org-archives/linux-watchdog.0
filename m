Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33552 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbbG1P2i (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 28 Jul 2015 11:28:38 -0400
Received: by wicmv11 with SMTP id mv11so184433885wic.0
        for <linux-watchdog@vger.kernel.org>; Tue, 28 Jul 2015 08:28:37 -0700 (PDT)
Date: Tue, 28 Jul 2015 16:28:32 +0100
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
Message-ID: <20150728152832.GY14943@x1>
References: <1438004292-16382-1-git-send-email-matt@codeblueprint.co.uk>
 <1438004292-16382-2-git-send-email-matt@codeblueprint.co.uk>
 <20150728094643.GT14943@x1>
 <20150728110717.GH2492@codeblueprint.co.uk>
 <20150728113721.GU14943@x1>
 <20150728124338.GA2773@codeblueprint.co.uk>
 <20150728150021.GX14943@x1>
 <55B79D60.4080807@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <55B79D60.4080807@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, 28 Jul 2015, Guenter Roeck wrote:

> On 07/28/2015 08:00 AM, Lee Jones wrote:
> >On Tue, 28 Jul 2015, Matt Fleming wrote:
> >>On Tue, 28 Jul, at 12:37:21PM, Lee Jones wrote:
> >>>
> >>>The driver shouldn't be called that either.
> >>>
> >>>You are the only one.  What makes iTCO 'special'?
> >>
> >>I don't know, I didn't write it. It looks like Wim did ~9 years ago=
, so
> >>it must have made sense to him at the time.
> >>
>=20
> Coding style wasn't as strict then as it is today. iTCO has just been=
 kept
> for historic reasons.

=46or sure, I get that, but it doesn't mean we can't do-the-right-thing
(tm) now does it?

> Sure, we could have changed it to lowercase, but so far no one bother=
ed.
> Plus, of course, there is always the element that some maintainers ha=
te
> that kind of cleanup,

Really?  Surely any kind of clean-up is good clean-up.  Especially as
Greg KH et. al, have been doing public presentations telling everyone
that there is always kernel work for anyone who has the time; spelling
corrections and all.

> and patch submitters like Matt are stuck between
> a rock and a hard place.

Matt,

Either do the 5min clean-up or don't, no biggy.  If you don't then I
can do it.  At the very least please don't add any _new_ camel case
variables or filenames.

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
