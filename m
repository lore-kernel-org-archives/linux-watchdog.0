Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:37742 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752099AbaCLVzO (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 12 Mar 2014 17:55:14 -0400
Date: Wed, 12 Mar 2014 18:54:56 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
	Jason Cooper <jason@lakedaemon.net>,
	Guenter Roeck <linux@roeck-us.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lior Amsalem <alior@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH v3 0/8] Watchdog support for Armada 375/38x SoC
Message-ID: <20140312215456.GA13340@arch.cereza>
References: <1394658715-2017-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140312214312.GA14357@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140312214312.GA14357@obsidianresearch.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mar 12, Jason Gunthorpe wrote:
> On Wed, Mar 12, 2014 at 06:11:47PM -0300, Ezequiel Garcia wrote:
>=20
> > I've pushed a branch so people can test this easily, e.g. ensuring
> > no regressions on Dove, Kirkwood and A370/XP:
> >=20
> > https://github.com/MISL-EBU-System-SW/mainline-public/tree/wdt_a385=
_a375_v3
>=20
> This branch worked for me, the watchdog functioned as expected.
>=20

Good to hear. Is that a Tested-by on Kirkwood?

> # killall -STOP wdt...
> ..
> .
> orion_wdt: Oops: Watchdog Timeout
> CPU: 0 PID: 0 Comm: swapper Not tainted 3.14.0-rc1-00205-g666e53f-dir=
ty #1
> [..]
> <REBOOT>
>=20
> I got these two oddball messages during boot though:
>=20
> irq: Cannot allocate irq_descs @ IRQ26, assuming pre-allocated
> irq: Cannot allocate irq_descs @ IRQ61, assuming pre-allocated
>=20
> Probably unrelated to the watchdog.. Unfortunately I've run out of
> time right now to investigate.
>=20

Probably. That branch is based on some mvebu/for-next tip, which has al=
l
the watchdog and devicetree dependencies for this patchset to apply.

I can re-send a series based on v3.15-rc1 and we can check again; maybe
we're just missing some irq patch.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
