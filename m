Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:43895 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756439AbaCDUDn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 4 Mar 2014 15:03:43 -0500
Date: Tue, 4 Mar 2014 17:03:28 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Cooper <jason@lakedaemon.net>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Wim Van Sebroeck <wim@iguana.be>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v2 0/7] Watchdog support for Armada 375/38x SoC
Message-ID: <20140304200328.GA11316@arch.cereza>
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140304175341.GO1872@titan.lakedaemon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140304175341.GO1872@titan.lakedaemon.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mar 04, Jason Cooper wrote:
> On Tue, Mar 04, 2014 at 01:07:17PM -0300, Ezequiel Garcia wrote:
> > Here's a new patchset adding support for watchdog on Armada 375 and
> > Armada 38x SoCs. Regarding the previous patchset, this time we're h=
andling
> > the SoCs differences in the watchdog driver itself.
> >=20
> > The new Armada 375/385 SoCs have two registers for the watchdog RST=
OUT:
> >=20
> >  1. It has a dedicated register (similar to the one in A370/XP)
> >  2. Also has a bit in a shared RSTOUT register.
> >=20
> > Therefore, in order to support this two-folded RSTOUT, we extend th=
e 'reg'
> > property in the watchdog devicetree and require a new pair of cells=
 to specify
> > the shared RSTOUT.
> >=20
> > On the driver side, we need to implement per-SoC stop() and enabled=
()
> > functions. Such somewhat complex infrastructure is needed to ensure=
 the driver
> > performs proper reset of the watchdog timer, by masking and disabli=
ng the
> > RSTOUT before the interrupt is enabled.
> >=20
> > Changes from v1:
> >=20
> >   * Reworked entirely!
> >=20
> > Ezequiel Garcia (7):
> >   watchdog: orion: Introduce a SoC-specific RSTOUT mapping
> >   watchdog: orion: Introduce per-SoC stop() function
> >   watchdog: orion: Introduce per-SoC enabled() function
> >   watchdog: orion: Add Armada 375/380 SoC support
> >   ARM: mvebu: Enable Armada 375 watchdog in the devicetree
> >   ARM: mvebu: Enable Armada 380/385 watchdog in the devicetree
> >   ARM: mvebu: Add A375/A380 watchdog binding documentation
> >=20
> >  .../devicetree/bindings/watchdog/marvel.txt        |   7 +
> >  arch/arm/boot/dts/armada-375.dtsi                  |   6 +
> >  arch/arm/boot/dts/armada-38x.dtsi                  |   7 +
> >  drivers/watchdog/orion_wdt.c                       | 167 +++++++++=
++++++++++--
> >  4 files changed, 177 insertions(+), 10 deletions(-)
>=20
> From a cursory look, this is a big improvement.  Just one small note:=
  I
> almost didn't see this, since I wasn't in the Cc.  No need to resend,=
 I
> bounced it around to the right folders so I can track it.
>=20

Ouch.. sorry about that. Of course, wasn't on purpose!
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
