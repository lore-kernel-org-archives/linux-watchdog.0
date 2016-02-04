Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-bn1bon0133.outbound.protection.outlook.com ([157.56.111.133]:63136
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965149AbcBDVCQ (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Feb 2016 16:02:16 -0500
Date: Thu, 4 Feb 2016 14:47:59 -0600
From: Kyle Roeschley <kyle.roeschley@ni.com>
To: Josh Cartwright <joshc@ni.com>
CC: <linux-watchdog@vger.kernel.org>
Subject: Re: [2/2] niwatchdog: add support for custom ioctls
Message-ID: <20160204204758.GA5412@senary>
References: <1452558181-19511-2-git-send-email-kyle.roeschley@ni.com>
 <20160117042941.GA16822@roeck-us.net>
 <20160125233140.GB26173@senary>
 <56A6C527.1010207@roeck-us.net>
 <20160203004409.GA2001@senary>
 <56B37E72.4080903@roeck-us.net>
 <20160204183844.GI17746@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20160204183844.GI17746@jcartwri.amer.corp.natinst.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Feb 04, 2016 at 12:38:44PM -0600, Josh Cartwright wrote:
> On Thu, Feb 04, 2016 at 08:38:10AM -0800, Guenter Roeck wrote:
> > >realize that users may not care about differences of less than a second, but it
> > >seems better to err on the side of caution and provide more accuracy than
> > >they would be expected to need. For instance, this watchdog operates on a
> > >real-time system with any number of industrial applications which could require
> > >high accuracy even from the watchdog.
> >
> > I don't really believe that this is or will ever be the case. I would argue that
> > any system which requires such a high accuracy for a watchdog timeout has a severe
> > architectural problem. After all, we are not talking about reaction time to an
> > external or internal event here. We are talking about what should happen if
> > something goes wrong so badly that it results in an immediate system reboot
> > or hardware reset.
> 
> I think we're pushing on what the definition of a "watchdog" is, and
> it's purpose is within a wider system.  Historically, the kernels' usage
> of "watchdog" meant some hardware which would facilitate a reset of the
> system if not fed/pet in a timely manner.  In this case, I'd definitely
> agree with your statement that sub-millisecond timing is overkill and/or
> a poor design.
> 
> For our "watchdog" hardware, however, resetting the hardware/CPU state
> is only _one_ possible action that can be configured to occur when the
> timer expires.
> 
> But other actions exist too.  In the most timing-sensitive case, our
> "watchdog" is attached to to an external trigger bus, which carries
> trigger signals equidistantly to a series of data acquisition devices
> (or other plug-in measurement devices).  The "watchdog" can be
> configured to signal one or several of these trigger lines (triggering
> synchronized acquisition or whatever) in the case of expiration.
> 
> In this way, it's much more like a general user configurable countdown
> timer than it is a "watchdog" in the Linux sense.  The question is
> whether or not WATCHDOG_CORE should grow to include some of the
> functionality required, or if that functionality should live somewhere
> else.  (And if the answer is "somewhere else", how can we _also_
> implement the standard watchdog interface for the case where we want
> hardware reset to be the configured action).
> 

To this point, the current idea was to use sysfs attributes "action_reset"
(which is on by default), "action_interrupt" (which is off by default), and
"counter" (to directly read/write the counter value). However, we run into the
locking problem that I mentioned in my last email. Anyone have any ideas on
that?

Regards,

Kyle Roeschley
