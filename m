Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:48725 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbaLRJEL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Dec 2014 04:04:11 -0500
Received: by mail-qg0-f42.google.com with SMTP id q108so540190qgd.1
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Dec 2014 01:04:10 -0800 (PST)
Date: Thu, 18 Dec 2014 09:04:04 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it,
	kernel@stlinux.com, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/8] watchdog: bindings: Provide ST bindings for ST's LPC
 Watchdog device
Message-ID: <20141218090404.GU13885@x1>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <5479005.CEJLtxOOIa@wuerfel>
 <20141218081334.GO13885@x1>
 <2894129.AmAkgPJPNf@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2894129.AmAkgPJPNf@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

We=20
On Thu, 18 Dec 2014, Arnd Bergmann wrote:

> On Thursday 18 December 2014 08:13:34 Lee Jones wrote:
> > On Wed, 17 Dec 2014, Arnd Bergmann wrote:
> >=20
> > > On Wednesday 17 December 2014 16:45:24 Lee Jones wrote:
> > > > +- compatible   : Must be one of: "st,stih407-lpc" "st,stih416-lp=
c"
> > > > +                                 "st,stih415-lpc" "st,stid127-lp=
c"
> > > > +- reg          : LPC registers base address + size
> > > > +- interrupts    : LPC interrupt line number and associated flags
> > > > +- clocks       : Clock used by LPC device (See: ../clock/clock-b=
indings.txt)
> > > > +- st,lpc-mode  : The LPC can run either one of two modes ST_LPC_=
MODE_RTC [0] or
> > > > +                 ST_LPC_MODE_WDT [1].  One (and only one) mode m=
ust be
> > > > +                 selected.
> > > >=20
> > >=20
> > > I'm glad you got it to work with two drivers for the same device.
> > >=20
> > > With this binding, I'm still a bit unhappy about the st,lpc-mode pr=
operty,
> > > in particular since you rely on a shared include file for something=
 that
> > > can only be set in one way or another and always has to be present.
> > >=20
> > > Why not just use a boolean property that enforces one mode when pre=
sent
> > > and another mode when absent?
> >=20
> > There is nothing stopping me from doing that, and it was a
> > consideration.  I concluded that this method would be more explicit
> > however.  Both when describing our choices in DT and at a functional
> > level within each of the drivers.
> >=20
> > Let me know if you fundamentally disagree and I can fix-up.
>=20
> I generally don't like  header files that define interfaces between C c=
ode
> and DT nodes. There are cases where it's the least ugly solution, but I=
 don't
> think this is one of them.
>=20
> If you want to be more explicit about the modes, how about having one
> boolean property per mode? That would also allow devices that could be
> driven in either mode, e.g. if you have only one instance of this devic=
e.

Isn't this was you suggested above?

Making a decision on the absence is a property is what I'm calling
not-explicit.  If it's accidentally left off the driver(s) won't issue a
warning, it'll just assume that the lack of this boolean property was
intentional and go follow the Watchdog path for instance.

But as I briefly mentioned to you elsewhere, there are actually 3
devices (Watchdog, RTC and Global Timer).  How would you like to
handle that with a Boolean property when we introduce this new driver?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
