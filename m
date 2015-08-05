Return-path: <teigland@redhat.com>
Date: Wed, 5 Aug 2015 12:13:49 -0500
From: David Teigland <teigland@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
        linux-kernel@vger.kernel.org, Timo Kokkonen <timo.kokkonen@offcode.fi>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 0/8] watchdog: Add support for keepalives triggered by
 infrastructure
Message-ID: <20150805171349.GA15472@redhat.com>
References: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438654414-29259-1-git-send-email-linux@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Aug 03, 2015 at 07:13:26PM -0700, Guenter Roeck wrote:
> - Some watchdogs have a very short maximum timeout, in the range of just a few
>   seconds. Such low timeouts are difficult if not impossible to support from
>   user space. Drivers supporting such watchdog hardware need to implement
>   a timer function to augment heartbeats from user space.

> - A new status flag, WDOG_RUNNING, informs the watchdog subsystem that a
>   watchdog is running, and that the watchdog subsystem needs to generate
>   heartbeat requests while the associated watchdog device is closed.

> Patch #2 adds timer functionality to the watchdog core. It solves the problem
> of short maximum hardware timeouts by augmenting heartbeats triggered from
> user space with internally triggered heartbeats.
> 
> Patch #3 adds functionality to generate heartbeats while the watchdog device is
> closed. It handles situation where where the watchdog is running after
> the driver has been instantiated, but the device is not yet opened,
> and post-close situations necessary if a watchdog can not be stopped.

These sound concerning because it seems that heartbeats could be generated
outside of the direct control of userspace.  I have a program that depends
on having direct control over whether heartbeats are generated (or more
specifically, *not* generated.)  If these new features introduce a new way
for heartbeats to be generated, is there a way I can detect or disable
that behavior from userspace?  Unwanted heartbeats could break my program
and may lead to data corruption.

A related issue from some years ago is the unfortunate fact that closing
the watchdog device also generates a heartbeat.  I'd like to disable that
also, and submitted a patch for it here:
http://www.spinics.net/lists/linux-watchdog/msg01477.html

(Without the patch, I have to work around it by closing the device
prematurely as a way to generate the potentially final heartbeat, and then
reopen it again if I want to continue the heartbeats.)

Dave
