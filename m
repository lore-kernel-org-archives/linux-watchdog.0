Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37555 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753018AbaCLVNA (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 17:13:00 -0400
Date: Wed, 12 Mar 2014 18:12:43 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/7] Watchdog support for Armada 375/38x SoC
Message-ID: <20140312211243.GA1853@arch.cereza>
References: <1393949244-5011-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140307001346.GB13690@arch.cereza>
 <20140311214525.GA3564@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140311214525.GA3564@obsidianresearch.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mar 11, Jason Gunthorpe wrote:
> On Thu, Mar 06, 2014 at 09:13:46PM -0300, Ezequiel Garcia wrote:
>=20
> > > On the driver side, we need to implement per-SoC stop() and enabl=
ed()
> > > functions. Such somewhat complex infrastructure is needed to ensu=
re the driver
> > > performs proper reset of the watchdog timer, by masking and disab=
ling the
> > > RSTOUT before the interrupt is enabled.
>=20
> > JasonG: How does this look now?
>=20
> A cursory look seems reasonable..
>=20

Good.

> > Any chance someone gives a Tested-by on Dove/Kirkwood?
>=20
> If you have a git I can pull I can try it here.
>=20

I've just posted a v3 for this series together with a branch:

https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_a385_a37=
5_v3

Thanks!
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
