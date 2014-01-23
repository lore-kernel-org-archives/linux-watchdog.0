Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52230 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750797AbaAWMEc (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 23 Jan 2014 07:04:32 -0500
Date: Thu, 23 Jan 2014 09:04:48 -0300
From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20140123120447.GD6065@localhost>
References: <1390295561-3466-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20140121233537.GS18269@obsidianresearch.com>
 <20140122164904.GB27273@localhost>
 <20140122173417.GT18269@obsidianresearch.com>
 <52E02AB6.7040104@gmail.com>
 <20140122205213.GW18269@obsidianresearch.com>
 <20140122221237.GA30763@localhost>
 <20140122223117.GX18269@obsidianresearch.com>
 <52E05C4E.9060709@gmail.com>
 <20140123001934.GY18269@obsidianresearch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20140123001934.GY18269@obsidianresearch.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jan 22, 2014 at 05:19:34PM -0700, Jason Gunthorpe wrote:
[..]
>=20
> On Kirkwood this means all of the main interrupt controller bits are
> level and all the bridge bits are edge. Which means edge is
> definitely correct for the bridge handler, and level correct for the
> main handler.
>=20

Which means we should change the bridge handler to edge?

Is there any _noticeable_ side-effect in doing the handling via level?

--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdo=
g" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
