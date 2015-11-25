Return-path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Guenter Roeck <linux@roeck-us.net>
cc: Damien Riegel <damien.riegel@savoirfairelinux.com>, wim@iguana.be,
    linux-watchdog@vger.kernel.org,
    Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Subject: Re: In-reply-to: <1448056496-2335-1-git-send-email-damien.riegel@savoirfairelinux.com>
In-reply-to: <5655FFF9.8040109@roeck-us.net>
References: <1448056496-2335-2-git-send-email-damien.riegel@savoirfairelinux.com> <E1a0sdo-0000RV-FA@stardust.g4.wien.funkfeuer.at> <20151123153747.GA13332@localhost> <E1a0vjV-0000O4-QX@stardust.g4.wien.funkfeuer.at> <20151123233136.GA18839@localhost> <E1a1dUj-0000P7-Ie@stardust.g4.wien.funkfeuer.at> <5655FFF9.8040109@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2439.1448488569.1@stardust.g4.wien.funkfeuer.at>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2015 22:56:09 +0100
Message-Id: <E1a1i2r-0000dN-H4@stardust.g4.wien.funkfeuer.at>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Guenter!

Guenter Roeck writes:
> On 11/25/2015 09:04 AM, Harald Geyer wrote:
> > Damien Riegel writes:
> >> On Mon, Nov 23, 2015 at 07:20:57PM +0100, Harald Geyer wrote:
> >>> Damien Riegel writes:
> >>>>> +	if (code =3D=3D SYS_DOWN || code =3D=3D SYS_HALT) {
> >>>>>
> >>>>> I think you want this to be (code =3D=3D SYS_POWER_OFF || code =3D=
=3D SYS_HALT)
> >>>>> AFAIK SYS_DOWN is the code for a reboot, where the system should c=
ome
> >>>>> back up immediatly, so probably we shouldn't disable the watchdog =
in
> >>>>> this case, for the system might crash during going down.
> >>>>
> >>>> Well, most of the drivers (all of them but gpio) that I changed sto=
pped
> >>>> on SYS_HALT and SYS_DOWN, so they explicitely wanted to stop the
> >>>> watchdog on reboot. I just factorized that in watchdog core.
> >>>
> >>> If they wanted to do so, or the code just got copied around, is
> >>> unclear. SYS_DOWN isn't the most helpful name after all, but ...
> >>>
> >>>> Maybe they should not stop on reboot in the first place, but this s=
erie
> >>>> does not introduce a new behaviour.
> >>>
> >>> okay. I can always send a follow up patch, if I care enough.
> >>>
> >>
> >> I don't understand why you assume this is not the desired behaviour a=
nd
> >> that the code was just copied around.
> >
> > Of course this is only weak evidence: I can't think of a reason why
> > this would be the desired behaviour other then working around some
> > obscure hardware issue. Yet this code is present in nearly all the
> > drivers ... so looks like copy&paste. Also so far nobody has presented
> =

> That "looks like" is just an assumption. that you can not think of a rea=
son
> doesn't mean there isn't one.
> =

> > a reason for this code, so looks like it is not a widely known issue.
> >
> =

> Should or can we assume that the vast majority of watchdog driver writer=
s
> did not know what they were doing ? I do not think so. We have to assume
> that they knew what they were doing, and we have to support that behavio=
r.

So far nobody has come forth and said: I knew what I was doing, my
reasoning was this and that. But maybe we have just not CCed enough
people... =

but the SYS_DOWN case really is a minor issue.
 =

> We can support different functionality, but the starting point is to sup=
port
> what is there today.

Yes, I have already agreed to propose a follow up patch, if I care
enough, so let's drop the SYS_DOWN down case from the discussion for now.

> >>>>> More importantly however we should stop the watchdog on SYS_POWER_=
OFF
> >>>>> I think.
> >>>>>
> >>>> My understanding here is that if the system is powered off, the wat=
chdog
> >>>> will be powered off too, so there is no need to stop it.
> >>>
> >>> This is true for many platforms, but I'm pretty sure that not all
> >>> platforms have a real power off. So unless you can think of a reason=
 not
> >>> to stop the watchdog on power off, I think the core should do it.
> >>> Actually if this can't be the default, we probably need to extend
> >>> your code so that drivers can select the behaviour they want.
> >>> (Of course we would hate to do that, as power management and watchdo=
gs
> >>> are pretty orthogonal subsystems and having one depend on the behavi=
our
> >>> of the other is very unfortunate.)
> >>
> >> We have to assume that power-off means that the system will be powere=
d
> >> off (...). If a platform has no real power-off, then it should be
> >> halted, and in that case the core would stop the watchdog to prevent =
a
> >> spurious reboot.
> >
> > If on a platform without real power-off somebody at the shell
> > (or maybe some script) issues 'poweroff' - what code will be
> > sent to the notifier? Honestly I don't know, but I wouldn't rely
> > that it is SYS_HALT ...
> >
> >> But maybe you're right and we should not make such distinction betwee=
n
> >> power-off and halt, but I don't really want to make changes in driver=
s I
> >> don't know the context in which they are used.
> >
> > Actually you did make changes in at least one driver: gpio_wdt.c
> > And this can't be argued with majority, because we can be quite confid=
ent,
> > that stopping the watchdog before power-off won't cause problems for a=
ny
> > driver, but OTOH there is no way to forsee the effect of not
> > stopping gpio_wdt.c ...
> >
> > Actually since the gpio watchdog talks to some external hardware, we
> > have no way to tell what the effect of a real power-off will be on the
> > external hardware as it might have its own power supply that the kerne=
l
> > can't control.
> >
> > I can offer to prepare a kernel with some printk's and test it on
> > some platform where I suspect that there could be issues. But I don't
> > see much point in it: Even if it turns out not to be an issue on the
> > platform I test, that wouldn't provide much confidence for other platf=
orms.
> >
> =

> My take is that the infrastructure should support the majority of the
> existing use cases. If there are other use cases, there are two options:
> Enhance the infrastructure to support more if not all use cases, or
> don't use the infrastructure for the non-matching use cases.

I see where you are coming from, but then the gpio watchdog probably
shouldn't be moved to the core infrastructure yet. Not without an
Ack from the original author...

> For poweroff, one could also argue that the watchdog should _not_ stop.
> Reason is that if the poweroff fails, for whatever reason, we don't want
> the system to be stuck in some odd state. Keeping the watchdog running
> ensures that the system comes back alive. If the poweroff request result=
s
> in the system entering the rom monitor, I would expect the rom monitor t=
o
> disable or ping the watchdog.
> =

> Similar arguments can really be made for all cases. Should the watchdog
> be stopped on restart because the restart is known to take too long for
> the maximum watchdog interval ? Should it be stopped on device shutdown
> (which is also registered by some watchdog drivers, and called when the
> system restarts) ?
> =

> In other words, one can always find arguments one way or another. Some
> may be platform / architecture specific, some may be use case specific.
> Maybe the behavior should or could be made configurable.

Yes, looks like that's the outcome of this discussion.

> We can either start somewhere and move common code into the watchdog cor=
e,
> or we can do nothing. I prefer to start somewhere and improve it as we
> go along.

Sure, though we should try not to introduce any regressions during this
process.

Since my patch for the stmp3xxx won't be able to use the core infrastructu=
re
for now, can it get picked up as is?
http://www.spinics.net/lists/linux-watchdog/msg07482.html

* it fixes a real bug
* AFAIK there is no unaddressed feedback from the Mailinglist
* we can always improve it (core infrastructure) as we go along

Thanks,
Harald

-- =

If you want to support my work:
see http://friends.ccbib.org/harald/supporting/
or donate via bitcoin to 1FUtd8T9jRN1rFz63vZz7s2fDtB6d6A7aS
