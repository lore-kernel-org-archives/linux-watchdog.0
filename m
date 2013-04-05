Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:64039 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161189Ab3DECAB (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 4 Apr 2013 22:00:01 -0400
Date: Thu, 4 Apr 2013 18:59:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arkadiusz Miskiewicz <a.miskiewicz@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: 3.8.3 and 3.9git occasional watchdog oops
Message-ID: <20130405015959.GA2566@roeck-us.net>
References: <201303142154.20501.arekm@maven.pl>
 <201304050023.31143.a.miskiewicz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201304050023.31143.a.miskiewicz@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2013 at 12:23:30AM +0200, Arkadiusz Miskiewicz wrote:
> On Thursday 14 of March 2013, Arkadiusz Mi=C5=9Bkiewicz wrote:
> > Hi.
> >=20
> > Just hit watchdog related oops in 3.8.3 kernel. Unfortunately photos =
only.
> >=20
> > http://ixion.pld-linux.org/~arekm/watchdog-oops-3.8.3/IMG_8942.JPG
> > http://ixion.pld-linux.org/~arekm/watchdog-oops-3.8.3/IMG_8941.JPG
>=20
> 3.9git from today isn't any better unfortunately:
>=20
> http://ixion.pld-linux.org/~arekm/watchdog-oops-3.9git.jpg
>=20
> >=20
> > oops started after I enabled systemd watchdog functionality. Cannot
> > reproduce easily.
> >=20
> > watchdog here (thinkpad t400) is:
> >  iTCO_wdt: Found a ICH9M-E TCO device (Version=3D2, TCOBASE=3D0x1060)
>=20
>=20
Wonder if there is a race condition in the watchdog driver: The watchdog =
device
is opened before watchdog_register_device returns. I suspect systemd wait=
s for
a udev event, or by some other means detects that /dev/watchdog was creat=
ed,
and opens it immediately.

I just have no idea where exactly the race condition, if there is one, is
hiding. Or maybe I am completely off track.

Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
