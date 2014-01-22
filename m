Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:47784 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751973AbaAVRpZ (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 22 Jan 2014 12:45:25 -0500
Date: Wed, 22 Jan 2014 14:45:40 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Lior Amsalem <alior@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Jason Cooper <jason@lakedaemon.net>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Andrew Lunn <andrew@lunn.ch>, Wim Van Sebroeck <wim@iguana.be>,
	Gregory Clement <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v2 06/15] watchdog: orion: Remove unneeded BRIDGE_CAUSE
 clear
Message-ID: <20140122174539.GD27273@localhost>
References: <1390295561-3466-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140122173417.GT18269@obsidianresearch.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 22, 2014 at 10:34:17AM -0700, Jason Gunthorpe wrote:
> On Wed, Jan 22, 2014 at 01:49:05PM -0300, Ezequiel Garcia wrote:
> > > Looking at this patch in isolation it looks to me like the clear
> > > bridge lines should be replaced with a request_irq (as that does =
the
> > > clear) - is the request_irq in the wrong spot?
> >=20
> > First of all, it seems to me that the first item "Disable WDT" is n=
ot
> > currently true on this driver. orion_wdt_start() seem to reset the
> > counter, but doesn't clear the WDT_EN bit. Do you think we should
> > enforce a "true" disable?
>=20
> I think so.
>=20
> > Regarding the sequence. Let me see if I got this problem right. The
> > concern here is about the bootloader leaving the registers in a
> > weird-state, right?
>=20
> It isn't just bootloaders to worry about, but also things like kexec.=
=2E
>=20
> > In that case, I thought that requesting the IRQ at probe time was e=
nough
> > to ensure the BRIDGE_CAUSE would be cleared by the time the watchdo=
g is
> > started. However, after reading through the irqchip code again, I'm=
 no longer
> > sure this is the case.
>=20
> The watchdog should ideally be fully stopped before request_irq so
> there is no possible race.
>=20

Agreed. So, let's assume we can guarantee that request_irq() does the
job of clearing the cause register (clearing pending irqs).

So, your suggestion is to put request_irq() in the watchdog start()?

Otherwise, we can ensure a watchdog full stop at probe(), before
requesting the IRQ. Both solutions should work, uh?

I don't have a strong opinion. It's not like the watchdog is going to b=
e
frequently started/stopped (right?) so we can easily do the
request_irq() in the start() without worrying.
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
