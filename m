Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40450 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754204AbaAUKq2 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 05:46:28 -0500
Date: Tue, 21 Jan 2014 07:46:38 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 01/15] ARM: Introduce atomic MMIO modify
Message-ID: <20140121104637.GD3577@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <3512865.jTEvHVvFLA@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <3512865.jTEvHVvFLA@wuerfel>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Jan 21, 2014 at 10:45:21AM +0100, Arnd Bergmann wrote:
> On Tuesday 21 January 2014 06:12:27 Ezequiel Garcia wrote:
> > Some SoC have MMIO regions that are shared across orthogonal
> > subsystems. This commit implements a possible solution for the
> > thread-safe access of such regions through a spinlock-protected API=
=2E
> >=20
> > Concurrent access is protected with a single spinlock for the
> > entire MMIO address space. While this protects shared-registers,
> > it also serializes access to unrelated/unshared registers.
> >=20
> > We add relaxed and non-relaxed variants, by using writel_relaxed an=
d writel,
> > respectively. The rationale for this is that some users may not req=
uire
> > register write completion but only thread-safe access to a register=
=2E
> >=20
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>=20
> You add the new atomic mmio interfaces in an ARM global header file,
> but at the same time make them ARM-only. I'm not opposed to having
> interfaces like that, but I'm not convinced they are actually needed
> for this case and if we go there, it needs to be done more carefully
> and should be available for all architectures so that portable driver=
s
> can use them.
>=20

Yes, true. We've discussed about this and even post an arch-generic API=
:

http://lwn.net/Articles/564709/

In the end it was decided to keep it ARM-specific for now:

http://www.spinics.net/lists/arm-kernel/msg271773.html

Just for reference, the last posted patchset for the atomic I/O API
is this:

http://www.spinics.net/lists/arm-kernel/msg292775.html

> It also seems to duplicate functionality that is already present in
> regmap-mmio.
>=20

Yes, this is true. We tried to use regmap-mmio/syscon but we need this
to initialize the clocksource which is too early for that to work:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg484535.htm=
l

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
