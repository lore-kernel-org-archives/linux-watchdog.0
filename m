Return-path: <teigland@redhat.com>
Date: Wed, 5 Aug 2015 14:51:25 -0500
From: David Teigland <teigland@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-kernel@vger.kernel.org, Timo Kokkonen <timo.kokkonen@offcode.fi>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
Message-ID: <20150805195125.GA20863@redhat.com>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <20150805171349.GA15472@redhat.com>
 <55C24ADF.7010605@roeck-us.net>
 <20150805175158.GB15472@redhat.com>
 <55C25D92.8020609@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55C25D92.8020609@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Aug 05, 2015 at 12:01:38PM -0700, Guenter Roeck wrote:
> I think I can understand why Wim was reluctant to accept your patch;
> I must admit I don't understand your use case either.

Very breifly, sanlock is a shared storage based lease manager, and the
expiration of a lease is tied to the expiration of the watchdog.  I have
to ensure that the watchdog expires at or before the time that the lease
expires.  This means that I cannot allow a watchdog heartbeat apart from a
corresponding lease renewal on the shared storage.  Otherwise, the
calculation by other hosts of the time of the hard reset will be wrong,
and the data on shared storage could be corrupted.

> I wonder if you are actually mis-using the watchdog subsystem to generate
> hard resets.

I am indeed using it to generate hard resets.

> After all, you could avoid the unexpected close situation with
> an exit handler in your application. That handler could catch anything but
> SIGKILL, but anyone using SIGKILL doesn't really deserve better.

I avoid the unexpected close situation by prematurely closing the device
to generate the heartbeat from close, and then reopening if needed.  That
covers the SIGKILL case.  So, I have a work around, but the patch would
still be nice.

> If the intent is to reset the system after the application closes,
> executing "/sbin/restart -f" might be a safer approach than just killing
> the watchdog.

I need to reset the system if the application crashes, or if the
application is running but can't renew its lease.  In the former case,
executing something doesn't work.  In the later case, I have done similar
(with /proc/sysrq-trigger), but it doesn't always apply and I'd still want
the hardware reset as redundancy.

> In addition to that, I don't think it is a good idea to rely on the assumption
> that the watchdog will expire exactly after the configured timeout.
> Many watchdog drivers implement a soft timeout on top of the hardware timeout,
> and thus already implement the internal heartbeat. Most of those drivers
> will stop sending internal heartbeats if user space did not send a heartbeat
> within the configured timeout period. The actual reset will then occur later,
> after the actual hardware watchdog timed out. This can be as much as the
> hardware timeout period, which may be substantial.

OK, thanks, I'll look into this in more detail.  Is there a way I can
identify which cases these are, or do you know an example I can look at?
In the worst case I'd have to extend the lease expiration time by a full
timeout period when the dubious drivers are used.

Dave
