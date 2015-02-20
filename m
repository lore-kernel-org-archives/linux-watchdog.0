Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:52837 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791AbbBTQ3K (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 20 Feb 2015 11:29:10 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YOqRx-001lrs-DI
	for linux-watchdog@vger.kernel.org; Fri, 20 Feb 2015 16:29:09 +0000
Date: Fri, 20 Feb 2015 08:28:55 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Rob Herring <robherring2@gmail.com>
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] at91sam9_wdt: Allow watchdog to reset device at
 early boot
Message-ID: <20150220162855.GB22752@roeck-us.net>
References: <54B53160.6060309@roeck-us.net>
 <cover.1424262664.git.timo.kokkonen@offcode.fi>
 <6c0a3a5bcd93d18437eeed04712b4aeff201a16f.1424262664.git.timo.kokkonen@offcode.fi>
 <54E49AA5.40008@roeck-us.net>
 <20150218151713.7a718311@bbrezillon>
 <54E4A6C4.4070706@roeck-us.net>
 <20150218160033.GK11529@piout.net>
 <CAL_JsqLj=bGTWr1aUMRNMjC+xmftMLjUHnGu5M337jNdDDOsZA@mail.gmail.com>
 <54E57F4F.5040300@offcode.fi>
 <CAL_Jsq+p=dEE0hz3B+nMG_Y1zNeZiJhfQXzDQ6b8xyKcc2VBJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+p=dEE0hz3B+nMG_Y1zNeZiJhfQXzDQ6b8xyKcc2VBJg@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Feb 20, 2015 at 08:06:23AM -0600, Rob Herring wrote:
> On Thu, Feb 19, 2015 at 12:14 AM, Timo Kokkonen
> <timo.kokkonen@offcode.fi> wrote:
> > Hi,
> >
> >
> > On 18.02.2015 23:11, Rob Herring wrote:
> >>
> >> On Wed, Feb 18, 2015 at 10:00 AM, Alexandre Belloni
> >> <alexandre.belloni@free-electrons.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On 18/02/2015 at 06:50:44 -0800, Guenter Roeck wrote :
> >>>>>>>
> >>>>>>>    Optional properties:
> >>>>>>>    - timeout-sec: Contains the watchdog timeout in seconds.
> >>>>>>> +- early-timeout-sec: If present, specifies a timeout value in
> >>>>>>> seconds
> >>>>>>> +  that the driver keeps on ticking the watchdog HW on behalf of user
> >>>>>>> +  space. Once this timeout expires watchdog is left to expire in
> >>>>>>> +  timeout-sec seconds. If this propery is set to zero, watchdog is
> >>>>>>> +  started (or left running) so that a reset occurs in timeout-sec
> >>>>>>> +  since the watchdog was started.
> >>>>>>>
> >>>>>>>    Example:
> >>>>>>>
> >>>>>>>    watchdog {
> >>>>>>>             timeout-sec = <60>;
> >>>>>>> +   early-timeout-sec = <120>;
> >>>>>>
> >>>>>>
> >>>>>> That is not a generic property as you defined it; if so,
> >>>>>> it would have to be implemented in the watchdog core code,
> >>>>>> not in the at91 code. You'll have to document it in the bindings
> >>>>>> description for at91sam9_wdt.
> >>>>>
> >>>>>
> >>>>> Then, if this is a controller specific property, it should be defined
> >>>>> with the 'atmel,' prefix.
> >>>>> We're kind of looping here: the initial discussion was "is there a need
> >>>>> for this property to be a generic one ?", and now you're saying no,
> >>>>> while you previously left the door opened.
> >>>>>
> >>>>> Tomi is proposing a generic approach, as you asked him to. I agree that
> >>>>> parsing the property in core code and making its value part of the
> >>>>> generic watchdog struct makes sense (that's what I proposed to Tomi a
> >>>>> few weeks ago).
> >>>>>
> >>>> Hmm ... the problem here is that the property description creates the
> >>>> assumption or expectation that the property is used if defined,
> >>>> which is not the case.
> >>>>
> >>>> I am not sure how to best resolve this. Maybe a comment in the property
> >>>> description stating that implementation of is device (driver) dependent
> >>>> ?
> >>>> After all, that is true for the timeout-sec property as well.
> >>>>
> >>>
> >>> I would leave it in the generic file and state that it may not be
> >>> implemented in the driver. That way, the property is documented for new
> >>> driver writers.
> >>
> >>
> >> That is pretty much true of any optional property. Whether implemented
> >> in the driver or core is an implementation detail that does not belong
> >> in the binding.
> >>
> >> I find this property pretty questionable. Certainly having the kernel
> >> service a watchdog either enabled at reset, in the bootloader, or by
> >> the kernel is a useful feature. A timeout for "how long userspace
> >> watchdog daemon takes to start" does not belong in DT. timeout-sec
> >> should be the default/initial timeout and long enough for userspace to
> >> start. Userspace can then change it to a more suitable value.
> >
> >
> > That would be a good workaround if we had enough time in the watchdog HW to
> > wait long enough for the user space to start up. For example in atmel HW the
> > maximum is 16 seconds, which may not be enough for the kernel to boot up and
> > the user space to start the watchdog daemon.
> 
> Well, the 16 sec maximum may be something useful to put into the DT as
> that actually is a property of the h/w.
> 
> > But even that is not enough as all of the watchdog drivers attempt to
> > *disable* the watchdog device before user space opens it. What good is a
> > watchdog if it is disabled by the kernel and we got stuck before the daemon
> > wakes up and re-enables it? This the problem with all of the watchdog
> > drivers right now. There are plenty of products out there that can't deal
> > with this kind of limitation. They are all hacking around it one way or
> > another. If there is a crash, the watchdog must reset the device. I can't
> > think of any other run time way to configure the watchdog for this kind of
> > situation than having a device tree property for it.
> 
> I fully agree the current design is broken. We should fix that in a
> generic way.
> 
> > What I am proposing here is a way to solve this without hacking. I was told
> > to think also a way to defer starting the watchdog for a given timeout so
> > that user space would have more time to wake up, which sounded like a good
> > idea. And this obviously needs to be implemented so that the watchdog is
> > guaranteed to reset the device should there be a crash of any kind that
> > prevents the watchdog daemon from starting up. There are a lot of details
> > that need to be taken care of properly and therefore watchdog core can't do
> > much about it, which is why I thought there is no much point trying to do it
> > in watchdog core.
> 
> Deferring would assume that the watchdog is not already enabled.
> 
> Putting in how long the kernel should service the watchdog in DT is
> like putting soft or hard lockup detection times into DT. These are
> kernel settings. If you need to change this, you should update your
> kernel or kernel settings, not the DT.
> 
The time to userspace handover may differ from HW variant to HW variant.
Some may load faster, some may load slower.

Similar, the runtime watchdog timeout may be different from system
to system.  On a system with faster CPU, and/or one with faster io,
one may want (or need) a faster watchdog timeout. I assumed that
was accepted and understood when the timeout-sec property was
introduced a long time ago, but maybe not.

Yes, the problem should be resolved in a generic way. This has been
on my mind for a long time, including the problem if a watchdog should
or should not stay or become enabled during early boot. All those are
system properties which should be addressed generically, and there
should be a means to express those properties in devicetree.

Problem goes back into the old back-and-forth of what can be in devicetree
or not. Sorting that out always takes a long time and a substantial amount
of effort. Unfortunately, I don't have that time (writing the code would
probably be trivial in comparison).

If someone is willing and able to spend the necessary time to negotiate 
acceptable devicetree properties and to write the necessary code, I'll be
more than happy to review and as much as possible test the resulting patches,
and I am sure that Wim will be happy to accept them. Until then we'll have
to live with what we have today.

Thanks,
Guenter
