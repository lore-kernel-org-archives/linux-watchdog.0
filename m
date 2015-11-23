Return-path: <damien.riegel@savoirfairelinux.com>
Date: Mon, 23 Nov 2015 18:31:37 -0500
From: Damien Riegel <damien.riegel@savoirfairelinux.com>
To: Harald Geyer <harald@ccbib.org>, wim@iguana.be,
	linux-watchdog@vger.kernel.org,
	Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	linux@roeck-us.net
Subject: Re: In-reply-to:
 <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
Message-ID: <20151123233136.GA18839@localhost>
References: <1448056496-2335-2-git-send-email-damien.riegel@savoirfairelinux.com>
 <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at>
 <20151123153747.GA13332@localhost>
 <E1a0vjV-0000O4-QX@stardust.g4.wien.funkfeuer.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1a0vjV-0000O4-QX@stardust.g4.wien.funkfeuer.at>
List-ID: <linux-watchdog@vger.kernel.org>

On Mon, Nov 23, 2015 at 07:20:57PM +0100, Harald Geyer wrote:
> Damien Riegel writes:
> > > +	if (code == SYS_DOWN || code == SYS_HALT) {
> > > 
> > > I think you want this to be (code == SYS_POWER_OFF || code == SYS_HALT)
> > > AFAIK SYS_DOWN is the code for a reboot, where the system should come
> > > back up immediatly, so probably we shouldn't disable the watchdog in
> > > this case, for the system might crash during going down.
> > 
> > Well, most of the drivers (all of them but gpio) that I changed stopped
> > on SYS_HALT and SYS_DOWN, so they explicitely wanted to stop the
> > watchdog on reboot. I just factorized that in watchdog core.
> 
> If they wanted to do so, or the code just got copied around, is
> unclear. SYS_DOWN isn't the most helpful name after all, but ...
>  
> > Maybe they should not stop on reboot in the first place, but this serie
> > does not introduce a new behaviour.
> 
> okay. I can always send a follow up patch, if I care enough.
> 

I don't understand why you assume this is not the desired behaviour and
that the code was just copied around.

> > > More importantly however we should stop the watchdog on SYS_POWER_OFF
> > > I think.
> > > 
> > My understanding here is that if the system is powered off, the watchdog
> > will be powered off too, so there is no need to stop it.
> 
> This is true for many platforms, but I'm pretty sure that not all
> platforms have a real power off. So unless you can think of a reason not
> to stop the watchdog on power off, I think the core should do it.
> Actually if this can't be the default, we probably need to extend
> your code so that drivers can select the behaviour they want.
> (Of course we would hate to do that, as power management and watchdogs
> are pretty orthogonal subsystems and having one depend on the behaviour
> of the other is very unfortunate.)

We have to assume that power-off means that the system will be powered
off (...). If a platform has no real power-off, then it should be
halted, and in that case the core would stop the watchdog to prevent a
spurious reboot.

But maybe you're right and we should not make such distinction between
power-off and halt, but I don't really want to make changes in drivers I
don't know the context in which they are used.


Damien.
