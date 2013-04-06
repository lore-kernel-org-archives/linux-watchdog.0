Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:53731 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759Ab3DFDru (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 5 Apr 2013 23:47:50 -0400
Date: Fri, 5 Apr 2013 20:47:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: 3.8.3 and 3.9git occasional watchdog oops
Message-ID: <20130406034750.GA25339@roeck-us.net>
References: <201303142154.20501.arekm@maven.pl>
 <201304050023.31143.a.miskiewicz@gmail.com>
 <20130405015959.GA2566@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130405015959.GA2566@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2013 at 06:59:59PM -0700, Guenter Roeck wrote:
> On Fri, Apr 05, 2013 at 12:23:30AM +0200, Arkadiusz Miskiewicz wrote:
> > On Thursday 14 of March 2013, Arkadiusz Mi=C5=9Bkiewicz wrote:
> > > Hi.
> > >=20
> > > Just hit watchdog related oops in 3.8.3 kernel. Unfortunately photo=
s only.
> > >=20
> > > http://ixion.pld-linux.org/~arekm/watchdog-oops-3.8.3/IMG_8942.JPG
> > > http://ixion.pld-linux.org/~arekm/watchdog-oops-3.8.3/IMG_8941.JPG
> >=20
> > 3.9git from today isn't any better unfortunately:
> >=20
> > http://ixion.pld-linux.org/~arekm/watchdog-oops-3.9git.jpg
> >=20
> > >=20
> > > oops started after I enabled systemd watchdog functionality. Cannot
> > > reproduce easily.
> > >=20
> > > watchdog here (thinkpad t400) is:
> > >  iTCO_wdt: Found a ICH9M-E TCO device (Version=3D2, TCOBASE=3D0x106=
0)
> >=20
> >=20
> Wonder if there is a race condition in the watchdog driver: The watchdo=
g device
> is opened before watchdog_register_device returns. I suspect systemd wa=
its for
> a udev event, or by some other means detects that /dev/watchdog was cre=
ated,
> and opens it immediately.
>=20
> I just have no idea where exactly the race condition, if there is one, =
is
> hiding. Or maybe I am completely off track.
>=20
I _think_ I understand the sequence of events.

- The driver is the first watchdog driver to register.
- watchdog_dev_register() gets called and creates the watchdog misc devic=
e
  by calling misc_register().
  At that time, the matching character device (/dev/watchdog0) does not y=
et
  exist, and old_wdd is not set either.
- Userspace gets an event and opens /dev/watchdog
- watchdog_open() is called and sets sets wdd =3D old_wdd, which is still=
 NULL,
  and tries to dereference it. Bang.

If this is the problem, a simple fix would be to set old_wdd before calli=
ng
misc_register().

Can you test a patch ?

Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
