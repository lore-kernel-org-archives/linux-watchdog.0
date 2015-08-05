Return-path: <teigland@redhat.com>
Date: Wed, 5 Aug 2015 12:51:58 -0500
From: David Teigland <teigland@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-kernel@vger.kernel.org, Timo Kokkonen <timo.kokkonen@offcode.fi>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
Message-ID: <20150805175158.GB15472@redhat.com>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
 <20150805171349.GA15472@redhat.com>
 <55C24ADF.7010605@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55C24ADF.7010605@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Wed, Aug 05, 2015 at 10:41:51AM -0700, Guenter Roeck wrote:
> Not really. The heartbeats will be generated such that the watchdog expires
> no later that <last heartbeat from userspace + configured timeout>. I discussed
> this already with Uwe; he had the same concern. This isn't in the current
> version of the patch set, but it will be in the next version. That means
> that nothing will change from user space perspective.

Sounds good, thanks.

> >A related issue from some years ago is the unfortunate fact that closing
> >the watchdog device also generates a heartbeat.  I'd like to disable that
> >also, and submitted a patch for it here:
> >http://www.spinics.net/lists/linux-watchdog/msg01477.html
> >
> 
> That is a different issue, though, and unrelated to this patch set.
> Wim had a good point there: Presumably the problem you are trying to solve
> applies to the entire system, not to a specific watchdog. What you are looking
> for looks more like a system parameter, not like something to set with an ioctl
> message. The reason here is that you'd still want to be able to use standard
> applications such as systemd or watchdogd to trigger heartbeats, and not depend
> on your own.

I'd need this behavior when the system is running my program (sanlock with
wdmd), which uses /dev/watchdog.  No other programs (systemd or watchdogd)
could be using /dev/watchdog at the same time.

Dave
