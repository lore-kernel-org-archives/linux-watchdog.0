Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48051 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752310AbaAVS3D (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 13:29:03 -0500
Date: Wed, 22 Jan 2014 15:29:15 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 05/15] watchdog: orion: Make RSTOUT register a
 separate resource
Message-ID: <20140122182914.GH27273@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233321.GR18269@obsidianresearch.com>
 <3176358.2QFcJHj0fv@wuerfel>
 <20140122162136.GA27273@localhost>
 <20140122180100.GE27273@localhost>
 <20140122181409.GV18269@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140122181409.GV18269@obsidianresearch.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 22, 2014 at 11:14:09AM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 22, 2014 at 03:01:01PM -0300, Ezequiel Garcia wrote:
> > On Wed, Jan 22, 2014 at 01:21:36PM -0300, Ezequiel Garcia wrote:
> > > > I don't see a good way out that would preserve backwards compat=
ibility,
> > > > other than hardcoding the physical address in the driver, which=
 seems
> > > > just as bad as breaking compatibility. That said, it is always =
the
> > > > same constant (0xf1000000 + 0x20000 + 0x0108) on Dove, Kirkwood=
 and
> > > > Orion5x (not on mv78xx0, but that doesn't use the wdt), so hard=
coding
> > > > a fallback would technically work, but we should print a fat wa=
rning at
> > > > boot time if we actually fall back to that.
> > > >=20
> > >=20
> > > Yes, I was thinking just about this. Namely:
> > >=20
> > [..]
> >=20
> > How about something like this?
>=20
> I liked Arnd's idea to use an offset from the first register. With th=
e
> mbus driver we can now actually change the 0xF1.. prefix via the DT.
>=20

Good idea. Maybe extracting the base address from the timer control
register: wdt_reg & 0xff000000 ?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
