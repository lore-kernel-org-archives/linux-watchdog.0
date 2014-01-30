Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:39008 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752275AbaA3Whd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 30 Jan 2014 17:37:33 -0500
Date: Thu, 30 Jan 2014 19:37:39 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-watchdog@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 00/20] Armada 370/XP watchdog support
Message-ID: <20140130223738.GA1261@localhost>
References: <1390836440-12744-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140129181949.GB27143@localhost>
 <20140130205315.GD29184@titan.lakedaemon.net>
 <20140130215056.GA1063@localhost>
 <52EACB92.2080700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <52EACB92.2080700@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, Jan 30, 2014 at 11:00:50PM +0100, Sebastian Hesselbarth wrote:
> On 01/30/2014 10:50 PM, Ezequiel Garcia wrote:
> > On Thu, Jan 30, 2014 at 03:53:15PM -0500, Jason Cooper wrote:
> >> Ezequiel,
> >>
> >> On Wed, Jan 29, 2014 at 03:19:50PM -0300, Ezequiel Garcia wrote:
> >>> On Mon, Jan 27, 2014 at 12:27:00PM -0300, Ezequiel Garcia wrote:
> >>>> A new round, mostly fixing some minor nitpicks.
> >>>>
> >>>
> >>> If anyone wants to give this a test, here's a public branch:
> >>>
> >>> https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_fo=
r_v3.14_v5
> >>
> >> I just took a quick glance at this (commit oneliners/tags) and the=
re
> >> doesn't appear to be any dependence on Sebastian's series.  Did I =
miss
> >> something?
> >>
> >
> > True, I've completely missed that. I pushed the branch in a rush!
> >
> > Let me prepare a v6, fixing the remaining issue pointed out by Russ=
ell,
> > and push again (together with Sebastian's irqchip fixes).
>=20
> Umm, no. Just directly name irqchip-orion fixes. Jason will send a PR
> for irqchip-fixes _with-in_ v3.14 while watchdog will go into v3.15.
>=20

That sounds good.

> Or are there any plans to get watchdog in *now*?
>=20

Not on my side, I'm aiming at v3.15.

> In any way, do not include my patches into your set.
>=20

Hm, maybe I've misexpressed myself. I wasn't intending to include
the patches on a submission, but just in a branch on the github repo.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
