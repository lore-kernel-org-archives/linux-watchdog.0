Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:58777 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaLRJ2v (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Dec 2014 04:28:51 -0500
Received: by mail-oi0-f50.google.com with SMTP id x69so131859oia.9
        for <linux-watchdog@vger.kernel.org>; Thu, 18 Dec 2014 01:28:50 -0800 (PST)
Date: Thu, 18 Dec 2014 09:28:44 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, a.zummo@towertech.it,
	kernel@stlinux.com, rtc-linux@googlegroups.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	wim@iguana.be, linux@roeck-us.net, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/8] watchdog: bindings: Provide ST bindings for ST's LPC
 Watchdog device
Message-ID: <20141218092844.GB4525@x1>
References: <1418834727-1602-1-git-send-email-lee.jones@linaro.org>
 <2894129.AmAkgPJPNf@wuerfel>
 <20141218090404.GU13885@x1>
 <1554161.vPuSVrZM0j@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <1554161.vPuSVrZM0j@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 18 Dec 2014, Arnd Bergmann wrote:

> On Thursday 18 December 2014 09:04:04 Lee Jones wrote:
> > We=20
> > On Thu, 18 Dec 2014, Arnd Bergmann wrote:
> >=20
> > > On Thursday 18 December 2014 08:13:34 Lee Jones wrote:
> > > > On Wed, 17 Dec 2014, Arnd Bergmann wrote:
> > > >=20
> > > > > On Wednesday 17 December 2014 16:45:24 Lee Jones wrote:
> > > > > > +- compatible   : Must be one of: "st,stih407-lpc" "st,stih=
416-lpc"
> > > > > > +                                 "st,stih415-lpc" "st,stid=
127-lpc"
> > > > > > +- reg          : LPC registers base address + size
> > > > > > +- interrupts    : LPC interrupt line number and associated=
 flags
> > > > > > +- clocks       : Clock used by LPC device (See: ../clock/c=
lock-bindings.txt)
> > > > > > +- st,lpc-mode  : The LPC can run either one of two modes S=
T_LPC_MODE_RTC [0] or
> > > > > > +                 ST_LPC_MODE_WDT [1].  One (and only one) =
mode must be
> > > > > > +                 selected.
> > > > > >=20
> > > > >=20
> > > > > I'm glad you got it to work with two drivers for the same dev=
ice.
> > > > >=20
> > > > > With this binding, I'm still a bit unhappy about the st,lpc-m=
ode property,
> > > > > in particular since you rely on a shared include file for som=
ething that
> > > > > can only be set in one way or another and always has to be pr=
esent.
> > > > >=20
> > > > > Why not just use a boolean property that enforces one mode wh=
en present
> > > > > and another mode when absent?
> > > >=20
> > > > There is nothing stopping me from doing that, and it was a
> > > > consideration.  I concluded that this method would be more expl=
icit
> > > > however.  Both when describing our choices in DT and at a funct=
ional
> > > > level within each of the drivers.
> > > >=20
> > > > Let me know if you fundamentally disagree and I can fix-up.
> > >=20
> > > I generally don't like  header files that define interfaces betwe=
en C code
> > > and DT nodes. There are cases where it's the least ugly solution,=
 but I don't
> > > think this is one of them.
> > >=20
> > > If you want to be more explicit about the modes, how about having=
 one
> > > boolean property per mode? That would also allow devices that cou=
ld be
> > > driven in either mode, e.g. if you have only one instance of this=
 device.
> >=20
> > Isn't this was you suggested above?
>=20
> My first suggestion was to just have one boolean property, and use on=
e
> driver if that is absent. The second one was to have two (or three) s=
eparate
> boolean properties that each refer to whether a particular driver is =
allowed
> to use this device or not.
>=20
> > But as I briefly mentioned to you elsewhere, there are actually 3
> > devices (Watchdog, RTC and Global Timer).  How would you like to
> > handle that with a Boolean property when we introduce this new driv=
er?
>=20
> Right, this would require having more than one property, but I still =
think
> it's better than the header file.

I'll put my point across just once and then become subservient once
more.  I don't agree that defining 3 properties is better than
creating just 1.  We have lots of properties containing indexes and
flags.  Just because we've decided to #define them in order to read
them easily shouldn't detract from the fact that it's a better setup.

  st,lpc-mode <1|2|3>;

Must be better than:

    st,lpc-globaltimer-mode;
    st,lpc-watchdog-mode;
    st,lpc-rtc-mode;

If each of the drivers only checks for it's own property and fails to
probe if it's not present how will we detect and warn about a lack of
any of the 3 properties without a central, all-knowing (MFD) driver?=20

This is likely to cause someone [why isn't my driver probing] issues
and subsequently waste valuable engineering time in the future.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
