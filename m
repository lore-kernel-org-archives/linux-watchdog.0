Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52345 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752284AbaB1PJf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 28 Feb 2014 10:09:35 -0500
Date: Fri, 28 Feb 2014 12:09:26 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH 0/2] Watchdog on Armada 375 SoC
Message-ID: <20140228150925.GC24805@localhost>
References: <1393419047-10071-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140226203633.GA24656@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20140226203633.GA24656@obsidianresearch.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2014 at 01:36:33PM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2014 at 09:50:45AM -0300, Ezequiel Garcia wrote:
> =20
> > Here we found both the above RSTOUT:
> >=20
> > 1. It has the same dedicated register as A370/XP (0x20704)
> > 2. Also has a bit in the shared RSTOUT register (0x18254)
>=20
> Unless you know otherwise I think the same risk exists, RSTOUT could
> be (or become) internally asserted when you unmask the bit in the
> control register that drives the pin, which says the watchdog driver
> should control to it.
>=20

I guess it's also possible to have the system-controller ensure the
watchdog is fully stopped, before unmasking the shared RSTOUT.

However, it seems it would be too ugly and hackish.

> >=20
> > 	watchdog-timer@20300 {
> > 		compatible =3D "marvell,orion-wdt";
> > 		reg =3D <0x20300 0x28
> > 		       {shared RSOUT} 0x4
> > 		       0x0 0x0>;
> > 	};
>=20
> I wouldn't have the 0x0, if you want to go this way, just make the
> 375 compatible string require a 3 entry reg.
>=20

Yes, this sounds like the right thing to do. It means we need to also
have per-SoC hooks for stop() and is_enabled(), but it's the price to
pay for changing the register semantic: the shared RSTOUT has unmask/mask
semantics on A375, while it's enable/disable on Kirkwood and friends.

Let me cook a new patch.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
