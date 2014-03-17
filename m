Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:60600 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750716AbaCQUrZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 17 Mar 2014 16:47:25 -0400
Date: Mon, 17 Mar 2014 17:47:06 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Jason Cooper <jason@lakedaemon.net>,
	Wim Van Sebroeck <wim@iguana.be>,
	Guenter Roeck <linux@roeck-us.net>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Subject: Re: [PATCH v4 0/9] Watchdog support for Armada 375/38x SoC
Message-ID: <20140317204706.GB1118@arch.cereza>
References: <1394907484-26002-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <532748C2.9030009@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <532748C2.9030009@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mar 17, Sebastian Hesselbarth wrote:
> On 03/15/2014 07:17 PM, Ezequiel Garcia wrote:
> >Fourth round of the patchset adding support for watchdog on Armada 3=
75 and
> >Armada 38x SoCs.
> >
> >The new Armada 375/385 SoCs have two registers for the watchdog RSTO=
UT:
> >
> >  1. It has a dedicated register (similar to the one in A370/XP)
> >  2. Also has a bit in a shared RSTOUT register.
> >
> >Therefore, in order to support this two-folded RSTOUT, we extend the=
 'reg'
> >property in the watchdog devicetree and require a new pair of cells =
to specify
> >the shared RSTOUT.
> >
> >On the driver side, we need to implement per-SoC stop() and enabled(=
)
> >functions. Such somewhat complex infrastructure is needed to ensure =
the driver
> >performs proper reset of the watchdog timer, by masking and disablin=
g the
> >RSTOUT before the interrupt is enabled.
> >
> >I've pushed a branch so people can test this easily, e.g. ensuring
> >no regressions on Dove, Kirkwood and A370/XP:
>=20
> Ezequiel,
>=20
> Although, I just saw below that you actually already tested on Dove,
> you can add my
>=20
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
>=20

Great, thanks!
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
