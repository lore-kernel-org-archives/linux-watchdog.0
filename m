Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40684 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754441AbaAULFv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 21 Jan 2014 06:05:51 -0500
Date: Tue, 21 Jan 2014 08:06:04 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Removing PLAT_ORION dependency from ARCH_MVEBU (Was Re: [PATCH v2
 14/15] watchdog: orion: Allow to build on any Orion platform)
Message-ID: <20140121110603.GB4356@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-15-git-send-email-ezequiel.garcia@free-electrons.com>
 <52DE40BD.10700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <52DE40BD.10700@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Sebastian,

I'm picking on this discussion, with a new Subject.

On Tue, Jan 21, 2014 at 10:41:17AM +0100, Sebastian Hesselbarth wrote:
> On 01/21/14 10:12, Ezequiel Garcia wrote:
> > After getting rid of all the mach-specific code, it's now possible
> > to allow builds in any Orion platform.
> >
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >   drivers/watchdog/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 5be6e91..1689f72 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -282,7 +282,7 @@ config DAVINCI_WATCHDOG
> >
> >   config ORION_WATCHDOG
> >   	tristate "Orion watchdog"
> > -	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
> > +	depends on PLAT_ORION
[..]
>=20
> I haven't checked why ARCH_MVEBU at all added PLAT_ORION as dependenc=
y,
> but IIRC it was just because of a missing mbus driver? If it is just
> this, we should also remove PLAT_ORION from ARCH_MVEBU to have a clea=
n
> cut between new common arch and existing sub-archs.
>=20

Well, I'm not sure if I'm following you. Many drivers currently depend
on PLAT_ORION, so if we remove PLAT_ORION from ARCH_MVEBU we would have
to replace: s/PLAT_ORION/ARCH_{MVEBU, KIRKWOOD, DOVE, ...}.

Is this the suggested roadmap or I've completely misunderstood it?
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
