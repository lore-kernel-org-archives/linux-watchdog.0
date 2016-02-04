Return-path: <joshc@ni.com>
Date: Thu, 4 Feb 2016 12:38:44 -0600
From: Josh Cartwright <joshc@ni.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Kyle Roeschley <kyle.roeschley@ni.com>, linux-watchdog@vger.kernel.org
Subject: Re: [2/2] niwatchdog: add support for custom ioctls
Message-ID: <20160204183844.GI17746@jcartwri.amer.corp.natinst.com>
References: <1452558181-19511-2-git-send-email-kyle.roeschley@ni.com>
 <20160117042941.GA16822@roeck-us.net>
 <20160125233140.GB26173@senary>
 <56A6C527.1010207@roeck-us.net>
 <20160203004409.GA2001@senary>
 <56B37E72.4080903@roeck-us.net>
MIME-Version: 1.0
In-Reply-To: <56B37E72.4080903@roeck-us.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-ID: <linux-watchdog@vger.kernel.org>

On Thu, Feb 04, 2016 at 08:38:10AM -0800, Guenter Roeck wrote:
> >realize that users may not care about differences of less than a second, but it
> >seems better to err on the side of caution and provide more accuracy than
> >they would be expected to need. For instance, this watchdog operates on a
> >real-time system with any number of industrial applications which could require
> >high accuracy even from the watchdog.
>
> I don't really believe that this is or will ever be the case. I would argue that
> any system which requires such a high accuracy for a watchdog timeout has a severe
> architectural problem. After all, we are not talking about reaction time to an
> external or internal event here. We are talking about what should happen if
> something goes wrong so badly that it results in an immediate system reboot
> or hardware reset.

I think we're pushing on what the definition of a "watchdog" is, and
it's purpose is within a wider system.  Historically, the kernels' usage
of "watchdog" meant some hardware which would facilitate a reset of the
system if not fed/pet in a timely manner.  In this case, I'd definitely
agree with your statement that sub-millisecond timing is overkill and/or
a poor design.

For our "watchdog" hardware, however, resetting the hardware/CPU state
is only _one_ possible action that can be configured to occur when the
timer expires.

But other actions exist too.  In the most timing-sensitive case, our
"watchdog" is attached to to an external trigger bus, which carries
trigger signals equidistantly to a series of data acquisition devices
(or other plug-in measurement devices).  The "watchdog" can be
configured to signal one or several of these trigger lines (triggering
synchronized acquisition or whatever) in the case of expiration.

In this way, it's much more like a general user configurable countdown
timer than it is a "watchdog" in the Linux sense.  The question is
whether or not WATCHDOG_CORE should grow to include some of the
functionality required, or if that functionality should live somewhere
else.  (And if the answer is "somewhere else", how can we _also_
implement the standard watchdog interface for the case where we want
hardware reset to be the configured action).

Thanks,
  Josh
