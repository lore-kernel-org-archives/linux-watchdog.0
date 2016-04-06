Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34876 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbcDFPgs (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 6 Apr 2016 11:36:48 -0400
Date: Wed, 6 Apr 2016 08:36:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel@de.bosch.com>
Cc: Wolfram Sang <wsa@the-dreams.de>,
	Oleksij Rempel <linux@rempel-privat.de>,
	dirk.behme@de.bosch.com, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 1/4] watchdog: renesas-wdt: add driver
Message-ID: <20160406153644.GA16700@roeck-us.net>
References: <1459511786-4286-1-git-send-email-wsa@the-dreams.de>
 <1459511786-4286-2-git-send-email-wsa@the-dreams.de>
 <57010C13.7040007@rempel-privat.de>
 <20160404104508.GA1383@katana>
 <57025C5A.2060704@de.bosch.com>
 <20160404123654.GA2983@katana>
 <20160404140812.GB10556@roeck-us.net>
 <57035A6A.3020601@de.bosch.com>
 <20160405184727.GA5862@roeck-us.net>
 <5704A10C.10701@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5704A10C.10701@de.bosch.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Apr 06, 2016 at 07:39:24AM +0200, fixed-term.Oleksij.Rempel wrote:
> 
> 
> On 05.04.2016 20:47, Guenter Roeck wrote:
> > On Tue, Apr 05, 2016 at 08:25:46AM +0200, fixed-term.Oleksij.Rempel wrote:
> >>
> >>
> >> On 04.04.2016 16:08, Guenter Roeck wrote:
> >>> On Mon, Apr 04, 2016 at 02:36:54PM +0200, Wolfram Sang wrote:
> >>>>
> >>>>> we are using it. So it should be implemented in this driver as well,
> >>>>> if it is not supported by HW, then we will need to use second timer or
> >>>>> watchdog for pretimeout interrupt.
> >>>>
> >>>> As I said, I have no task like this assigned (and no personal interest,
> >>>> too). So, you'd need to do it yourself, hire me, or request this feature
> >>>> from Renesas (and hope that they pass the task to me ;)).
> >>>>
> >>> Sorry, I lost the context here. 
> >>>
> >>>>> Please correct me if i'm wrong - module parameter is a way to ignore
> >>>>> kernel config. For same purpose, to disable wdt at runtime "magic 'V'"
> >>>>> should be used.
> >>>>
> >>>> I have to admit that I don't have a specific use-case, I just did
> >>>> general support as requested. So, I followed the style that basically
> >>>> every other watchdog driver has this parameter.
> >>>>
> >>> I don't understand this one. Unless I am missing something, the module
> >>> parameter is standard, and magic close by writing 'V' is supported.
> >>> What is the problem ?
> >>
> >> Sorry it was more about our internal requirements, which are fallowing:
> >> - WDT is always on. there should be no option to disable it.
> >> - WDTs can fail, it is proven fact. In our case, worst scenario, failed
> >> WDT will kill a car battery. This is why we use many watchdogs in one
> >> system. So, using differently configured WDTs of one SoC is valid use
> >> case. From this point, module options are kind of sweet but useless or
> >> harmful.
> > 
> > No one _has_ to use the module parameter. That doesn't mean that it must
> > not be there - someone else may want it for some reason.
> > 
> >> - pretimout interrupt is not optional - not any more. Some issues are
> >> wary hard or impossible to reproduce. Pretimout interrupt helped us to
> >> debug some of them. If WDT hardware can't provide one, we will need to
> >> mix two watchdogs (one for reset and other for interrupt) or wdt with
> >> some other hw timer.
> > 
> > Adding pretimeout support should be easy with a follow-up patch.
> > 
> >>
> >> May be this requirements can be passed to upstream as well :)
> > 
> > Keep in mind that a specific use case does not and should not mandate
> > driver implementation details. The driver can support both module parameter
> > and pretimeout, but none of those has to be used in a specific application.
> > Important is that the kernel _supports_ your use case, which should be no
> > problem.
> 
> Ok,
> thank you for your answer.
> 
> Some of patches was send for almost 5 months, suddenly i don't see them
> in any git repo:
> https://www.spinics.net/lists/linux-watchdog/msg08086.html
> 

Different subject ?

> Are there some doubts about it?

No, pretty much waiting for a rebase to the latest watchdog core code
to have another look.

There have been several proposals for adding pretimeout support into the
watchdog core. Some are more complex, some are less complex. The difficulty
is to find a balance between complexity and functionality.

Guenter
