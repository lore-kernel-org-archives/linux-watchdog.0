Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36119 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932183Ab3GPOSz (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 16 Jul 2013 10:18:55 -0400
Date: Tue, 16 Jul 2013 11:18:51 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-watchdog@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Lior Amsalem <alior@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	wim@iguana.be
Subject: Re: [PATCH 05/10] watchdog: orion: Add a memory resource for RSTOUT
 register
Message-ID: <20130716141850.GB23904@localhost>
References: <1373931163-12670-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1373931163-12670-6-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130716140415.GB19448@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130716140415.GB19448@lunn.ch>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org
Content-Transfer-Encoding: quoted-printable

Andrew,

On Tue, Jul 16, 2013 at 04:04:15PM +0200, Andrew Lunn wrote:
> On Mon, Jul 15, 2013 at 08:32:38PM -0300, Ezequiel Garcia wrote:
> > Instead of accessing the RSTOUT register directly, this commit
> > adds a platform memory resource to map this register into the driver.
>=20
>=20
> Have you looked at:
>=20
> arch/arm/mach-mvebu/system-controller.c
>=20

Mmm... I saw the use of the RSTOUT register in kirkwood_restart()
but wasn't sure who should be the real 'owner' of this register.

> It is also using this register. Are we going to have a similar problem
> as the TIMER_CTRL register, which you refactered in an earlier patch?
>=20

Probably.

> "marvell,orion-system-controller" is not actually used yet, but once
> kirkwood moves into mach-mvebu, it will start using it.
>=20

I guess so. We should take that into account *now*. Let me think about
it and see if I can have something sane for v2.

Thanks!
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
