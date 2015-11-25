Return-path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>, wim@iguana.be,
    linux-watchdog@vger.kernel.org,
    Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
    linux@roeck-us.net
Subject: Re: In-reply-to: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
In-reply-to: <20151123233136.GA18839@localhost>
References: <1448056496-2335-2-git-send-email-damien.riegel@savoirfairelinux.com> <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at> <20151123153747.GA13332@localhost> <E1a0vjV-0000O4-QX@stardust.g4.wien.funkfeuer.at> <20151123233136.GA18839@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1555.1448471077.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2015 18:04:37 +0100
Message-Id: <E1a1dUj-0000P7-Ie@stardust.g4.wien.funkfeuer.at>
List-ID: <linux-watchdog@vger.kernel.org>

Damien Riegel writes:
> On Mon, Nov 23, 2015 at 07:20:57PM +0100, Harald Geyer wrote:
> > Damien Riegel writes:
> > > > +	if (code =3D=3D SYS_DOWN || code =3D=3D SYS_HALT) {
> > > > =

> > > > I think you want this to be (code =3D=3D SYS_POWER_OFF || code =3D=
=3D SYS_HALT)
> > > > AFAIK SYS_DOWN is the code for a reboot, where the system should c=
ome
> > > > back up immediatly, so probably we shouldn't disable the watchdog =
in
> > > > this case, for the system might crash during going down.
> > > =

> > > Well, most of the drivers (all of them but gpio) that I changed stop=
ped
> > > on SYS_HALT and SYS_DOWN, so they explicitely wanted to stop the
> > > watchdog on reboot. I just factorized that in watchdog core.
> > =

> > If they wanted to do so, or the code just got copied around, is
> > unclear. SYS_DOWN isn't the most helpful name after all, but ...
> >  =

> > > Maybe they should not stop on reboot in the first place, but this se=
rie
> > > does not introduce a new behaviour.
> > =

> > okay. I can always send a follow up patch, if I care enough.
> > =

> =

> I don't understand why you assume this is not the desired behaviour and
> that the code was just copied around.

Of course this is only weak evidence: I can't think of a reason why
this would be the desired behaviour other then working around some
obscure hardware issue. Yet this code is present in nearly all the
drivers ... so looks like copy&paste. Also so far nobody has presented
a reason for this code, so looks like it is not a widely known issue.

 =

> > > > More importantly however we should stop the watchdog on SYS_POWER_=
OFF
> > > > I think.
> > > > =

> > > My understanding here is that if the system is powered off, the watc=
hdog
> > > will be powered off too, so there is no need to stop it.
> > =

> > This is true for many platforms, but I'm pretty sure that not all
> > platforms have a real power off. So unless you can think of a reason n=
ot
> > to stop the watchdog on power off, I think the core should do it.
> > Actually if this can't be the default, we probably need to extend
> > your code so that drivers can select the behaviour they want.
> > (Of course we would hate to do that, as power management and watchdogs
> > are pretty orthogonal subsystems and having one depend on the behaviou=
r
> > of the other is very unfortunate.)
> =

> We have to assume that power-off means that the system will be powered
> off (...). If a platform has no real power-off, then it should be
> halted, and in that case the core would stop the watchdog to prevent a
> spurious reboot.

If on a platform without real power-off somebody at the shell
(or maybe some script) issues 'poweroff' - what code will be
sent to the notifier? Honestly I don't know, but I wouldn't rely
that it is SYS_HALT ...
 =

> But maybe you're right and we should not make such distinction between
> power-off and halt, but I don't really want to make changes in drivers I
> don't know the context in which they are used.

Actually you did make changes in at least one driver: gpio_wdt.c
And this can't be argued with majority, because we can be quite confident,
that stopping the watchdog before power-off won't cause problems for any
driver, but OTOH there is no way to forsee the effect of not
stopping gpio_wdt.c ...

Actually since the gpio watchdog talks to some external hardware, we
have no way to tell what the effect of a real power-off will be on the
external hardware as it might have its own power supply that the kernel
can't control.

I can offer to prepare a kernel with some printk's and test it on
some platform where I suspect that there could be issues. But I don't
see much point in it: Even if it turns out not to be an issue on the
platform I test, that wouldn't provide much confidence for other platforms=
.

Harald

-- =

If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via bitcoin to 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
