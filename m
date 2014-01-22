Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47483 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752697AbaAVQVX (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 11:21:23 -0500
Date: Wed, 22 Jan 2014 13:21:37 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a
 separate resource
Message-ID: <20140122162136.GA27273@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233321.GR18269@obsidianresearch.com>
 <3176358.2QFcJHj0fv@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <3176358.2QFcJHj0fv@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Jason, Arnd:

On Wed, Jan 22, 2014 at 10:48:37AM +0100, Arnd Bergmann wrote:
> On Tuesday 21 January 2014 16:33:21 Jason Gunthorpe wrote:
> > On Tue, Jan 21, 2014 at 06:12:31AM -0300, Ezequiel Garcia wrote:
> > > In order to support other SoC, it's required to distinguish
> > > the 'control' timer register, from the 'rstout' register
> > > that enables system reset on watchdog expiration.
> >=20
> > > +     res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > > +     if (!res)
> > > +             return -ENODEV;
> >            ^^^^^^^^^^^^^^^^^^^^^^
> >=20
> > This change seems to break compatibility with existing DT files tha=
t
> > have only a single entry in reg?
> >=20
> > Can the value be defaulted some how if missing?
>=20
> I think this is a direct consequence of the attempt to remove the
> header file dependency, since the RSTOUTn_MASK macro is defined
> in mach/bridge-regs.h.
>=20

Exactly. Just for the record, I warned about this a while back:

http://www.spinics.net/lists/arm-kernel/msg270163.html

That said, it truly sucks to break compatibility so finding a way to
keep backwards compatibility would be certainly desirable.

> I don't see a good way out that would preserve backwards compatibilit=
y,
> other than hardcoding the physical address in the driver, which seems
> just as bad as breaking compatibility. That said, it is always the
> same constant (0xf1000000 + 0x20000 + 0x0108) on Dove, Kirkwood and
> Orion5x (not on mv78xx0, but that doesn't use the wdt), so hardcoding
> a fallback would technically work, but we should print a fat warning =
at
> boot time if we actually fall back to that.
>=20

Yes, I was thinking just about this. Namely:

If the second resource is missing *and* the compatible-string is
"orion-watchdog" (or it's not DT-registered), then use a hardcoded
RSTOUTn_MASK address. And pr_warn() something.

Thanks for the feedback,
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
